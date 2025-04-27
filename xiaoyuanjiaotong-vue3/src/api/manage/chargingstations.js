import request from '@/utils/request'

// 查询充电桩列表
export function listChargingstations(query) {
  return request({
    url: '/manage/chargingstations/list',
    method: 'get',
    params: query
  })
}

// 查询充电桩详细
export function getChargingstations(stationID) {
  return request({
    url: '/manage/chargingstations/' + stationID,
    method: 'get'
  })
}

// 新增充电桩
export function addChargingstations(data) {
  return request({
    url: '/manage/chargingstations',
    method: 'post',
    data: data
  })
}

// 修改充电桩
export function updateChargingstations(data) {
  return request({
    url: '/manage/chargingstations',
    method: 'put',
    data: data
  })
}

// 删除充电桩
export function delChargingstations(stationID) {
  return request({
    url: '/manage/chargingstations/' + stationID,
    method: 'delete'
  })
}
