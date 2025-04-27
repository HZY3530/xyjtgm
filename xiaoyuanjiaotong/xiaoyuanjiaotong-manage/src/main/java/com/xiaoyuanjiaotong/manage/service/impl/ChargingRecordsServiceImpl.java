package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;
import com.xiaoyuanjiaotong.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.mapper.ChargingRecordsMapper;
import com.xiaoyuanjiaotong.manage.domain.ChargingRecords;
import com.xiaoyuanjiaotong.manage.service.IChargingRecordsService;

/**
 * 充电记录Service业务层处理
 * 
 * @author huhu
 * @date 2025-03-10
 */
@Service
public class ChargingRecordsServiceImpl implements IChargingRecordsService 
{
    @Autowired
    private ChargingRecordsMapper chargingRecordsMapper;

    /**
     * 查询充电记录
     * 
     * @param recordId 充电记录主键
     * @return 充电记录
     */
    @Override
    public ChargingRecords selectChargingRecordsByRecordId(Long recordId)
    {
        return chargingRecordsMapper.selectChargingRecordsByRecordId(recordId);
    }

    /**
     * 查询充电记录列表
     * 
     * @param chargingRecords 充电记录
     * @return 充电记录
     */
    @Override
    public List<ChargingRecords> selectChargingRecordsList(ChargingRecords chargingRecords)
    {
        return chargingRecordsMapper.selectChargingRecordsList(chargingRecords);
    }

    /**
     * 新增充电记录
     * 
     * @param chargingRecords 充电记录
     * @return 结果
     */
    @Override
    public int insertChargingRecords(ChargingRecords chargingRecords)
    {
        chargingRecords.setCreateTime(DateUtils.getNowDate());
        return chargingRecordsMapper.insertChargingRecords(chargingRecords);
    }

    /**
     * 修改充电记录
     * 
     * @param chargingRecords 充电记录
     * @return 结果
     */
    @Override
    public int updateChargingRecords(ChargingRecords chargingRecords)
    {
        chargingRecords.setUpdateTime(DateUtils.getNowDate());
        return chargingRecordsMapper.updateChargingRecords(chargingRecords);
    }

    /**
     * 批量删除充电记录
     * 
     * @param recordIds 需要删除的充电记录主键
     * @return 结果
     */
    @Override
    public int deleteChargingRecordsByRecordIds(Long[] recordIds)
    {
        return chargingRecordsMapper.deleteChargingRecordsByRecordIds(recordIds);
    }

    /**
     * 删除充电记录信息
     * 
     * @param recordId 充电记录主键
     * @return 结果
     */
    @Override
    public int deleteChargingRecordsByRecordId(Long recordId)
    {
        return chargingRecordsMapper.deleteChargingRecordsByRecordId(recordId);
    }
}
