<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="位置" prop="location">
        <el-input
            v-model="queryParams.location"
            placeholder="请输入位置"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
            v-hasPermi="['manage:chargingstations:add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['manage:chargingstations:edit']"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['manage:chargingstations:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
            v-hasPermi="['manage:chargingstations:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="chargingstationsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="序号" align="center" width="55">
        <template #default="scope">
          <span>{{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="名字" align="center" prop="stationName"/>
      <el-table-column label="位置" align="center" prop="location"/>
      <el-table-column label="安装时间" align="center" prop="installDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.installDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="费用" align="center" prop="feeStandard"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
                     v-hasPermi="['manage:chargingstations:edit']">修改
          </el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                     v-hasPermi="['manage:chargingstations:remove']">删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改充电桩对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="chargingstationsRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="名字" prop="stationName">
          <el-input v-model="form.stationName" placeholder="请输入名字"/>
        </el-form-item>
        <el-form-item label="位置" prop="location">
          <el-input v-model="form.location" placeholder="请输入位置"/>
        </el-form-item>
        <el-form-item label="安装时间" prop="installDate">
          <el-date-picker clearable
                          v-model="form.installDate"
                          type="date"
                          value-format="YYYY-MM-DD"
                          placeholder="请选择安装时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="费用" prop="feeStandard">
          <el-input v-model="form.feeStandard" placeholder="请输入费用"/>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Chargingstations">
import {
  listChargingstations,
  getChargingstations,
  delChargingstations,
  addChargingstations,
  updateChargingstations
} from "@/api/manage/chargingstations";

const {proxy} = getCurrentInstance();

const chargingstationsList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    location: null,
  },
  rules: {
    stationName: [
      {required: true, message: "名字不能为空", trigger: "blur"}
    ],
    location: [
      {required: true, message: "位置不能为空", trigger: "blur"}
    ],
    installDate: [
      {required: true, message: "安装时间不能为空", trigger: "blur"}
    ],
    feeStandard: [
      {required: true, message: "费用不能为空", trigger: "blur"}
    ]
  }
});

const {queryParams, form, rules} = toRefs(data);

/** 查询充电桩列表 */
function getList() {
  loading.value = true;
  listChargingstations(queryParams.value).then(response => {
    chargingstationsList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    stationID: null,
    stationName: null,
    location: null,
    installDate: null,
    feeStandard: null
  };
  proxy.resetForm("chargingstationsRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.stationID);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加充电桩";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _stationID = row.stationID || ids.value
  getChargingstations(_stationID).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改充电桩";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["chargingstationsRef"].validate(valid => {
    if (valid) {
      if (form.value.stationID != null) {
        updateChargingstations(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addChargingstations(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _stationIDs = row.stationID || ids.value;
  proxy.$modal.confirm('是否确认删除充电桩编号为"' + _stationIDs + '"的数据项？').then(function () {
    return delChargingstations(_stationIDs);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('manage/chargingstations/export', {
    ...queryParams.value
  }, `chargingstations_${new Date().getTime()}.xlsx`)
}

getList();
</script>
