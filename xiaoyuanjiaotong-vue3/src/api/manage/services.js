import request from '@/utils/request'

// 查询志愿信息列表
export function listServices(query) {
  return request({
    url: '/manage/services/list',
    method: 'get',
    params: query
  })
}

// 查询志愿信息详细
export function getServices(serviceId) {
  return request({
    url: '/manage/services/' + serviceId,
    method: 'get'
  })
}

// 新增志愿信息
export function addServices(data) {
  return request({
    url: '/manage/services',
    method: 'post',
    data: data
  })
}

// 修改志愿信息
export function updateServices(data) {
  return request({
    url: '/manage/services',
    method: 'put',
    data: data
  })
}

// 删除志愿信息
export function delServices(serviceId) {
  return request({
    url: '/manage/services/' + serviceId,
    method: 'delete'
  })
}
