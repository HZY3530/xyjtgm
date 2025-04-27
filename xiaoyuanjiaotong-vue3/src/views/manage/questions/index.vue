<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="问题类型" prop="category">
        <el-input
            v-model="queryParams.category"
            placeholder="请输入问题类型"
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
            v-hasPermi="['manage:questions:add']"
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
            v-hasPermi="['manage:questions:edit']"
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
            v-hasPermi="['manage:questions:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="Download"
            @click="handleExport"
            v-hasPermi="['manage:questions:export']"
        >导出
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Upload" @click="handleExcelImport" v-hasPermi="['manage:questions:add']">导入</el-button>

      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
        v-loading="loading"
        :data="questionsList"
        @selection-change="handleSelectionChange"
        :row-key="row => row.questionId"
    >
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="序号" align="center" width="55">
        <template #default="scope">
          <span>{{ (queryParams.pageNum - 1) * queryParams.pageSize + scope.$index + 1 }}</span>
        </template>
      </el-table-column>
      <el-table-column type="expand" label="查看选项" align="center" width="100">
        <template #default="{ row }">
          <div v-if="row.examsList && row.examsList.length">
            <div v-for="(exam, index) in row.examsList" :key="index" class="exam-item">
              {{ exam.examContent }}
            </div>
          </div>
          <div v-else class="empty-tip">暂无关联题目</div>
        </template>
      </el-table-column>

      <el-table-column label="题目" align="center">
        <template #default="{ row }">
          <span v-html="row.questionContent"></span>
        </template>
      </el-table-column>
      <el-table-column label="答案" align="center" prop="answer"/>
      <el-table-column label="问题类型" align="center" prop="category"/>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">

          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
                     v-hasPermi="['manage:questions:edit']">修改
          </el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                     v-hasPermi="['manage:questions:remove']">删除
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

    <!-- 添加或修改题库对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="questionsRef" :model="form" :rules="rules" label-width="80px">

        <el-form-item label="题目" prop="questionContent">
          <el-input v-model="form.questionContent" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="答案" prop="answer">
          <el-input v-model="form.answer" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="问题类型" prop="category">
          <el-input v-model="form.category" placeholder="请输入问题类型"/>
        </el-form-item>
        <el-divider content-position="center">题目信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="Plus" @click="handleAddExams">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="Delete" @click="handleDeleteExams">删除</el-button>
          </el-col>
        </el-row>
        <div>
          <el-table :data="examsList" :row-class-name="rowExamsIndex" @selection-change="handleExamsSelectionChange"
                    ref="exams">
            <el-table-column type="selection" width="50" align="center"/>
            <el-table-column label="序号" align="center" prop="index" width="50"/>

            <el-table-column label="选项">
              <template #default="{ row }">
                <el-input
                    v-model="row.examContent"
                    placeholder="请输入选项内容"
                />
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
    <!-- 数据导入对话框 -->
    <el-dialog title="数据导入" v-model="excelOpen" width="400px" append-to-body>
      <el-upload ref="uploadRef" class="upload-demo"
                 :action="uploadExcelUrl"
                 :headers="headers"
                 :on-success="handleUploadSuccess"
                 :on-error="handleUploadError"
                 :before-upload="handleBeforeUpload"
                 :limit="1"
                 :auto-upload="false">
        <template #trigger>
          <el-button type="primary">上传文件</el-button>

        </template>

        <el-button class="ml-3" type="success" @click="submitUpload">
          上传
        </el-button>

        <template #tip>
          <div class="el-upload__tip">
            上传文件仅支持，xls/xlsx格式，文件大小不得超过1M
          </div>

        </template>

      </el-upload>

    </el-dialog>
  </div>
</template>

<script setup name="Questions">
import {listQuestions, getQuestions, delQuestions, addQuestions, updateQuestions} from "@/api/manage/questions";
import { getToken } from "@/utils/auth";
const {proxy} = getCurrentInstance();

const questionsList = ref([]);
const examsList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const checkedExams = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    category: null
  },
  rules: {}
});

const {queryParams, form, rules} = toRefs(data);

/** 查询题库列表 */
function getList() {
  loading.value = true;
  listQuestions(queryParams.value).then(response => {
    questionsList.value = response.rows;
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
    questionId: null,
    questionContent: null,
    answer: null,
    category: null
  };
  examsList.value = [];
  proxy.resetForm("questionsRef");
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
  ids.value = selection.map(item => item.questionId);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加题库";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _questionId = row.questionId || ids.value
  getQuestions(_questionId).then(response => {
    form.value = response.data;
    examsList.value = response.data.examsList;
    open.value = true;
    title.value = "修改题库";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["questionsRef"].validate(valid => {
    if (valid) {
      form.value.examsList = examsList.value;
      if (form.value.questionId != null) {
        updateQuestions(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addQuestions(form.value).then(response => {
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
  const _questionIds = row.questionId || ids.value;
  proxy.$modal.confirm('是否确认删除题库编号为"' + _questionIds + '"的数据项？').then(function () {
    return delQuestions(_questionIds);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 题库题目序号 */
function rowExamsIndex({row, rowIndex}) {
  row.index = rowIndex + 1;
}

/** 题库题目添加按钮操作 */
function handleAddExams() {
  let obj = {};
  obj.examContent = "";
  examsList.value.push(obj);
}

/** 题库题目删除按钮操作 */
function handleDeleteExams() {
  if (checkedExams.value.length == 0) {
    proxy.$modal.msgError("请先选择要删除的题库题目数据");
  } else {
    const examss = examsList.value;
    const checkedExamss = checkedExams.value;
    examsList.value = examss.filter(function (item) {
      return checkedExamss.indexOf(item.index) == -1
    });
  }
}

/** 复选框选中数据 */
function handleExamsSelectionChange(selection) {
  checkedExams.value = selection.map(item => item.index)
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('manage/questions/export', {
    ...queryParams.value
  }, `questions_${new Date().getTime()}.xlsx`)
}
/* 打开数据导入对话框 */
const excelOpen = ref(false);
function handleExcelImport() {
  excelOpen.value = true;
}

/* 上传地址 */
const uploadExcelUrl = ref(import.meta.env.VITE_APP_BASE_API + "/manage/questions/import"); // 上传excel文件地址
/* 上传请求头 */
const headers = ref({ Authorization: "Bearer " + getToken() });

/* 上传excel */
const uploadRef = ref({});
function submitUpload() {
  uploadRef.value.submit()
}

const props = defineProps({
  modelValue: [String, Object, Array],
  // 大小限制(MB)
  fileSize: {
    type: Number,
    default: 100,
  },
  // 文件类型, 例如["xls", "xlsx"]
  fileType: {
    type: Array,
    default: () => ["xls", "xlsx"],
  },
});

// 上传前loading加载
function handleBeforeUpload(file) {
  let isExcel = false;
  if (props.fileType.length) {
    let fileExtension = "";
    if (file.name.lastIndexOf(".") > -1) {
      fileExtension = file.name.slice(file.name.lastIndexOf(".") + 1);
    }
    isExcel = props.fileType.some(type => {
      if (file.type.indexOf(type) > -1) return true;
      if (fileExtension && fileExtension.indexOf(type) > -1) return true;
      return false;
    });
  }
  if (!isExcel) {
    proxy.$modal.msgError(
        `文件格式不正确, 请上传${props.fileType.join("/")}格式文件!`
    );
    return false;
  }
  if (props.fileSize) {
    const isLt = file.size / 1024 / 1024 < props.fileSize;
    if (!isLt) {
      proxy.$modal.msgError(`上传excel大小不能超过 ${props.fileSize} MB!`);
      return false;
    }
  }
  proxy.$modal.loading("正在上传excel，请稍候...");
}

// 上传失败
function handleUploadError() {
  proxy.$modal.msgError("上传excel失败");
  uploadRef.value.clearFiles();
  proxy.$modal.closeLoading();
}

// 上传成功回调
function handleUploadSuccess(res, file) {
  if (res.code === 200) {
    proxy.$modal.msgSuccess("上传excel成功");
    excelOpen.value = false;
    getList();
  }else{
    proxy.$modal.msgError("res.msg");
  }
  uploadRef.value.clearFiles();
  proxy.$modal.closeLoading();
}
getList();
</script>
<style lang='scss' scoped>

.exam-item {
  padding: 8px 20px;
  border-bottom: 1px solid #ebeef5;
}

.empty-tip {
  padding: 10px;
  color: #909399;
  text-align: center;
}
</style>
