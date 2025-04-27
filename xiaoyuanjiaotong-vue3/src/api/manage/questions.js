import request from '@/utils/request'

// 查询题库列表
export function listQuestions(query) {
  return request({
    url: '/manage/questions/list',
    method: 'get',
    params: query
  })
}

// 查询题库详细
export function getQuestions(questionId) {
  return request({
    url: '/manage/questions/' + questionId,
    method: 'get'
  })
}

// 新增题库
export function addQuestions(data) {
  return request({
    url: '/manage/questions',
    method: 'post',
    data: data
  })
}

// 修改题库
export function updateQuestions(data) {
  return request({
    url: '/manage/questions',
    method: 'put',
    data: data
  })
}

// 删除题库
export function delQuestions(questionId) {
  return request({
    url: '/manage/questions/' + questionId,
    method: 'delete'
  })
}
