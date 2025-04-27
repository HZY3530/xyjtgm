import request from '@/utils/request'

// 查询车牌列表
export function listPlates(query) {
  return request({
    url: '/manage/plates/list',
    method: 'get',
    params: query
  })
}

// 查询车牌详细
export function getPlates(plateId) {
  return request({
    url: '/manage/plates/' + plateId,
    method: 'get'
  })
}

// 新增车牌
export function addPlates(data) {
  return request({
    url: '/manage/plates',
    method: 'post',
    data: data
  })
}

// 修改车牌
export function updatePlates(data) {
  return request({
    url: '/manage/plates',
    method: 'put',
    data: data
  })
}

// 删除车牌
export function delPlates(plateId) {
  return request({
    url: '/manage/plates/' + plateId,
    method: 'delete'
  })
}
