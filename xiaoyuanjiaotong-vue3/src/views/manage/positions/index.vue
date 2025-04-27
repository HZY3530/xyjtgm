<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="岗位类型" prop="positionType">
        <el-input
            v-model="queryParams.positionType"
            placeholder="请输入岗位类型"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="志愿地点" prop="volunteerLocation">
        <el-input
            v-model="queryParams.volunteerLocation"
            placeholder="请输入志愿地点"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="截止时间" prop="deadline">
        <el-date-picker clearable
                        v-model="queryParams.deadline"
                        type="date"
                        value-format="YYYY-MM-DD"
                        placeholder="请选择截止时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="岗位状态" prop="positionStatus">
        <el-select v-model="queryParams.positionStatus" placeholder="请选择岗位状态" clearable>
          <el-option
              v-for="dict in sys_notice_status"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
          />
        </el-select>
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
            v-hasPermi="['manage:positions:add']"
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
            v-hasPermi="['manage:positions:edit']"
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
            v-hasPermi="['manage:positions:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
            v-hasPermi="['manage:positions:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="positionsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="序号" align="center" width="55">
        <template #default="scope">
          <span>{{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column label="岗位类型" align="center" prop="positionType"/>
      <el-table-column label="志愿地点" align="center" prop="volunteerLocation"/>
      <el-table-column label="工作内容" align="center" prop="jobContent"/>
      <el-table-column label="截止时间" align="center" prop="deadline" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.deadline, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="当前人数" align="center" prop="currentNumber"/>
      <el-table-column label="所需人数" align="center" prop="requiredNumber"/>
      <el-table-column label="岗位状态" align="center" prop="positionStatus">
        <template #default="scope">
          <dict-tag :options="sys_notice_status" :value="scope.row.positionStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
                     v-hasPermi="['manage:positions:edit']">修改
          </el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                     v-hasPermi="['manage:positions:remove']">删除
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

    <!-- 添加或修改志愿岗位对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="positionsRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="岗位类型" prop="positionType">
          <el-input v-model="form.positionType" placeholder="请输入岗位类型"/>
        </el-form-item>
        <el-form-item label="志愿地点" prop="volunteerLocation">
          <el-input v-model="form.volunteerLocation" placeholder="请输入志愿地点"/>
        </el-form-item>
        <el-form-item label="工作内容">
          <editor v-model="form.jobContent" :min-height="192"/>
        </el-form-item>
        <el-form-item label="截止时间" prop="deadline">
          <el-date-picker clearable
                          v-model="form.deadline"
                          type="date"
                          value-format="YYYY-MM-DD"
                          placeholder="请选择截止时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="当前人数" prop="currentNumber">
          <el-input v-model="form.currentNumber" placeholder="请输入当前人数"/>
        </el-form-item>
        <el-form-item label="所需人数" prop="requiredNumber">
          <el-input v-model="form.requiredNumber" placeholder="请输入所需人数"/>
        </el-form-item>
        <el-form-item label="岗位状态" prop="positionStatus">
          <el-select v-model="form.positionStatus" placeholder="请选择岗位状态">
            <el-option
                v-for="dict in sys_notice_status"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
            ></el-option>
          </el-select>
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

<script setup name="Positions">
import {listPositions, getPositions, delPositions, addPositions, updatePositions} from "@/api/manage/positions";

const {proxy} = getCurrentInstance();
const {sys_notice_status} = proxy.useDict('sys_notice_status');

const positionsList = ref([]);
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
    positionType: null,
    volunteerLocation: null,
    jobContent: null,
    deadline: null,
    positionStatus: null
  },
  rules: {
    positionType: [
      {required: true, message: "岗位类型不能为空", trigger: "blur"}
    ],
    volunteerLocation: [
      {required: true, message: "志愿地点不能为空", trigger: "blur"}
    ],
    jobContent: [
      {required: true, message: "工作内容不能为空", trigger: "blur"}
    ],
    deadline: [
      {required: true, message: "截止时间不能为空", trigger: "blur"}
    ],
    currentNumber: [
      {required: true, message: "当前人数不能为空", trigger: "blur"}
    ],
    requiredNumber: [
      {required: true, message: "所需人数不能为空", trigger: "blur"}
    ],
    positionStatus: [
      {required: true, message: "岗位状态不能为空", trigger: "change"}
    ]
  }
});

const {queryParams, form, rules} = toRefs(data);

/** 查询志愿岗位列表 */
function getList() {
  loading.value = true;
  listPositions(queryParams.value).then(response => {
    positionsList.value = response.rows;
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
    volunteerPositionId: null,
    positionType: null,
    volunteerLocation: null,
    jobContent: null,
    deadline: null,
    currentNumber: null,
    requiredNumber: null,
    positionStatus: null
  };
  proxy.resetForm("positionsRef");
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
  ids.value = selection.map(item => item.volunteerPositionId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加志愿岗位";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _volunteerPositionId = row.volunteerPositionId || ids.value
  getPositions(_volunteerPositionId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改志愿岗位";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["positionsRef"].validate(valid => {
    if (valid) {
      if (form.value.volunteerPositionId != null) {
        updatePositions(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addPositions(form.value).then(response => {
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
  const _volunteerPositionIds = row.volunteerPositionId || ids.value;
  proxy.$modal.confirm('是否确认删除志愿岗位编号为"' + _volunteerPositionIds + '"的数据项？').then(function () {
    return delPositions(_volunteerPositionIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('manage/positions/export', {
    ...queryParams.value
  }, `positions_${new Date().getTime()}.xlsx`)
}

getList();
</script>
