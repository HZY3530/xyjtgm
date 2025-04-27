import request from '@/utils/request'

// 查询题库题目列表
export function listExams(query) {
  return request({
    url: '/manage/exams/list',
    method: 'get',
    params: query
  })
}

// 查询题库题目详细
export function getExams(examId) {
  return request({
    url: '/manage/exams/' + examId,
    method: 'get'
  })
}

// 新增题库题目
export function addExams(data) {
  return request({
    url: '/manage/exams',
    method: 'post',
    data: data
  })
}

// 修改题库题目
export function updateExams(data) {
  return request({
    url: '/manage/exams',
    method: 'put',
    data: data
  })
}

// 删除题库题目
export function delExams(examId) {
  return request({
    url: '/manage/exams/' + examId,
    method: 'delete'
  })
}
