<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="举报人" prop="nickName">
        <el-input
            v-model="queryParams.nickName"
            placeholder="请输入举报人昵称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="违规车牌" prop="plateNumber">
        <el-input
            v-model="queryParams.plateNumber"
            placeholder="请输入违规车牌号"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="处理状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择处理状态" clearable>
          <el-option
              v-for="dict in reports"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="志愿地点" prop="serviceLocation">
        <el-input
          v-model="queryParams.serviceLocation"
          placeholder="请输入志愿地点"
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
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['manage:services:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['manage:services:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['manage:services:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="servicesList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="序号" align="center" width="55">
        <template #default="scope">
          <span>{{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="举报人" align="center" prop="nickName" />
      <el-table-column label="违规车牌" align="center" prop="plateNumber" />

      <el-table-column label="志愿地点" align="center" prop="serviceLocation" />
      <el-table-column label="描述" align="center" prop="description" />
      <el-table-column label="处理状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="reports" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="加分分值" align="center" prop="score" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>

        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['manage:services:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['manage:services:remove']">删除</el-button>
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

    <!-- 添加或修改志愿信息对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="servicesRef" :model="form" :rules="rules" label-width="80px">


        <el-form-item label="处理状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择处理状态">
            <el-option
                v-for="dict in reports"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item
            v-if="form.status === '已处理'"
            label="加分分值"
            prop="score"
        >
          <el-input-number
              v-model="form.score"
              :min="1"
              :max="12"
              placeholder="请输入加分分值"
          />
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

<script setup name="Services">
import { listServices, getServices, delServices, addServices, updateServices } from "@/api/manage/services";

const { proxy } = getCurrentInstance();
const { reports } = proxy.useDict('reports');

const servicesList = ref([]);
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
    userId: null,
    plateNumber: null,
    nickName: null,
    serviceLocation: null,
    status: null,
    plateId: null,
    score:null

  },
  rules: {
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询志愿信息列表 */
function getList() {
  loading.value = true;
  listServices(queryParams.value).then(response => {
    servicesList.value = response.rows;
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
    serviceId: null,
    userId: null,
    createTime: null,
    updateTime: null,
    serviceLocation: null,
    description: null,
    plateId: null,
    plateNumber: null,
    nickName: null,
    status: null,
    score: null
  };
  proxy.resetForm("servicesRef");
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
  ids.value = selection.map(item => item.serviceId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加志愿信息";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _serviceId = row.serviceId || ids.value
  getServices(_serviceId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改志愿信息";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["servicesRef"].validate(valid => {
    if (valid) {
      if (form.value.serviceId != null) {
        updateServices(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addServices(form.value).then(response => {
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
  const _serviceIds = row.serviceId || ids.value;
  proxy.$modal.confirm('是否确认删除志愿信息编号为"' + _serviceIds + '"的数据项？').then(function() {
    return delServices(_serviceIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('manage/services/export', {
    ...queryParams.value
  }, `services_${new Date().getTime()}.xlsx`)
}

getList();
</script>
