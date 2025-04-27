package com.xiaoyuanjiaotong.manage.service;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.Chargingstations;

/**
 * 充电桩Service接口
 * 
 * @author huhu
 * @date 2025-04-26
 */
public interface IChargingstationsService 
{
    /**
     * 查询充电桩
     * 
     * @param stationID 充电桩主键
     * @return 充电桩
     */
    public Chargingstations selectChargingstationsByStationID(Long stationID);

    /**
     * 查询充电桩列表
     * 
     * @param chargingstations 充电桩
     * @return 充电桩集合
     */
    public List<Chargingstations> selectChargingstationsList(Chargingstations chargingstations);

    /**
     * 新增充电桩
     * 
     * @param chargingstations 充电桩
     * @return 结果
     */
    public int insertChargingstations(Chargingstations chargingstations);

    /**
     * 修改充电桩
     * 
     * @param chargingstations 充电桩
     * @return 结果
     */
    public int updateChargingstations(Chargingstations chargingstations);

    /**
     * 批量删除充电桩
     * 
     * @param stationIDs 需要删除的充电桩主键集合
     * @return 结果
     */
    public int deleteChargingstationsByStationIDs(Long[] stationIDs);

    /**
     * 删除充电桩信息
     * 
     * @param stationID 充电桩主键
     * @return 结果
     */
    public int deleteChargingstationsByStationID(Long stationID);
}
