import request from '@/utils/request'

// 查询举报信息列表
export function listReports(query) {
  return request({
    url: '/manage/reports/list',
    method: 'get',
    params: query
  })
}

// 查询举报信息详细
export function getReports(reportId) {
  return request({
    url: '/manage/reports/' + reportId,
    method: 'get'
  })
}

// 新增举报信息
export function addReports(data) {
  return request({
    url: '/manage/reports',
    method: 'post',
    data: data
  })
}

// 修改举报信息
export function updateReports(data) {
  return request({
    url: '/manage/reports',
    method: 'put',
    data: data
  })
}

// 删除举报信息
export function delReports(reportId) {
  return request({
    url: '/manage/reports/' + reportId,
    method: 'delete'
  })
}
