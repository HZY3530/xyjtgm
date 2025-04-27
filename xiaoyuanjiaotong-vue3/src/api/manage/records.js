import request from '@/utils/request'

// 查询充电记录列表
export function listRecords(query) {
  return request({
    url: '/manage/records/list',
    method: 'get',
    params: query
  })
}

// 查询充电记录详细
export function getRecords(recordId) {
  return request({
    url: '/manage/records/' + recordId,
    method: 'get'
  })
}

// 新增充电记录
export function addRecords(data) {
  return request({
    url: '/manage/records',
    method: 'post',
    data: data
  })
}

// 修改充电记录
export function updateRecords(data) {
  return request({
    url: '/manage/records',
    method: 'put',
    data: data
  })
}

// 删除充电记录
export function delRecords(recordId) {
  return request({
    url: '/manage/records/' + recordId,
    method: 'delete'
  })
}
