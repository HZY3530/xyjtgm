package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;

import com.xiaoyuanjiaotong.manage.mapper.ChargingstationsMapper;
import com.xiaoyuanjiaotong.manage.service.IChargingstationsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.domain.Chargingstations;

/**
 * 充电桩Service业务层处理
 * 
 * @author huhu
 * @date 2025-04-26
 */
@Service
public class ChargingstationsServiceImpl implements IChargingstationsService
{
    @Autowired
    private ChargingstationsMapper chargingstationsMapper;

    /**
     * 查询充电桩
     * 
     * @param stationID 充电桩主键
     * @return 充电桩
     */
    @Override
    public Chargingstations selectChargingstationsByStationID(Long stationID)
    {
        return chargingstationsMapper.selectChargingstationsByStationID(stationID);
    }

    /**
     * 查询充电桩列表
     * 
     * @param chargingstations 充电桩
     * @return 充电桩
     */
    @Override
    public List<Chargingstations> selectChargingstationsList(Chargingstations chargingstations)
    {
        return chargingstationsMapper.selectChargingstationsList(chargingstations);
    }

    /**
     * 新增充电桩
     * 
     * @param chargingstations 充电桩
     * @return 结果
     */
    @Override
    public int insertChargingstations(Chargingstations chargingstations)
    {
        return chargingstationsMapper.insertChargingstations(chargingstations);
    }

    /**
     * 修改充电桩
     * 
     * @param chargingstations 充电桩
     * @return 结果
     */
    @Override
    public int updateChargingstations(Chargingstations chargingstations)
    {
        return chargingstationsMapper.updateChargingstations(chargingstations);
    }

    /**
     * 批量删除充电桩
     * 
     * @param stationIDs 需要删除的充电桩主键
     * @return 结果
     */
    @Override
    public int deleteChargingstationsByStationIDs(Long[] stationIDs)
    {
        return chargingstationsMapper.deleteChargingstationsByStationIDs(stationIDs);
    }

    /**
     * 删除充电桩信息
     * 
     * @param stationID 充电桩主键
     * @return 结果
     */
    @Override
    public int deleteChargingstationsByStationID(Long stationID)
    {
        return chargingstationsMapper.deleteChargingstationsByStationID(stationID);
    }
}
