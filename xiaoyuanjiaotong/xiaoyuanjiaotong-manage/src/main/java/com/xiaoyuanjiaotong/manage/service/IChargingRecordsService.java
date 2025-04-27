package com.xiaoyuanjiaotong.manage.service;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.ChargingRecords;

/**
 * 充电记录Service接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface IChargingRecordsService 
{
    /**
     * 查询充电记录
     * 
     * @param recordId 充电记录主键
     * @return 充电记录
     */
    public ChargingRecords selectChargingRecordsByRecordId(Long recordId);

    /**
     * 查询充电记录列表
     * 
     * @param chargingRecords 充电记录
     * @return 充电记录集合
     */
    public List<ChargingRecords> selectChargingRecordsList(ChargingRecords chargingRecords);

    /**
     * 新增充电记录
     * 
     * @param chargingRecords 充电记录
     * @return 结果
     */
    public int insertChargingRecords(ChargingRecords chargingRecords);

    /**
     * 修改充电记录
     * 
     * @param chargingRecords 充电记录
     * @return 结果
     */
    public int updateChargingRecords(ChargingRecords chargingRecords);

    /**
     * 批量删除充电记录
     * 
     * @param recordIds 需要删除的充电记录主键集合
     * @return 结果
     */
    public int deleteChargingRecordsByRecordIds(Long[] recordIds);

    /**
     * 删除充电记录信息
     * 
     * @param recordId 充电记录主键
     * @return 结果
     */
    public int deleteChargingRecordsByRecordId(Long recordId);
}
