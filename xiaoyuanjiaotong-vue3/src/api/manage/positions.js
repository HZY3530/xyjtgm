import request from '@/utils/request'

// 查询志愿岗位列表
export function listPositions(query) {
  return request({
    url: '/manage/positions/list',
    method: 'get',
    params: query
  })
}

// 查询志愿岗位详细
export function getPositions(volunteerPositionId) {
  return request({
    url: '/manage/positions/' + volunteerPositionId,
    method: 'get'
  })
}

// 新增志愿岗位
export function addPositions(data) {
  return request({
    url: '/manage/positions',
    method: 'post',
    data: data
  })
}

// 修改志愿岗位
export function updatePositions(data) {
  return request({
    url: '/manage/positions',
    method: 'put',
    data: data
  })
}

// 删除志愿岗位
export function delPositions(volunteerPositionId) {
  return request({
    url: '/manage/positions/' + volunteerPositionId,
    method: 'delete'
  })
}
