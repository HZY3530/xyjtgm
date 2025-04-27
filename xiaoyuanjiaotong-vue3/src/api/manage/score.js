import request from '@/utils/request'

// 查询学法考试分数列表
export function listScore(query) {
  return request({
    url: '/manage/score/list',
    method: 'get',
    params: query
  })
}

// 查询学法考试分数详细
export function getScore(id) {
  return request({
    url: '/manage/score/' + id,
    method: 'get'
  })
}

// 新增学法考试分数
export function addScore(data) {
  return request({
    url: '/manage/score',
    method: 'post',
    data: data
  })
}

// 修改学法考试分数
export function updateScore(data) {
  return request({
    url: '/manage/score',
    method: 'put',
    data: data
  })
}

// 删除学法考试分数
export function delScore(id) {
  return request({
    url: '/manage/score/' + id,
    method: 'delete'
  })
}
