package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;
import com.xiaoyuanjiaotong.common.utils.DateUtils;
import com.xiaoyuanjiaotong.manage.mapper.LicensePlatesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.domain.LicensePlates;
import com.xiaoyuanjiaotong.manage.service.ILicensePlatesService;

/**
 * 车牌Service业务层处理
 * 
 * @author huhu
 * @date 2025-03-10
 */
@Service
public class LicensePlatesServiceImpl implements ILicensePlatesService 
{
    @Autowired
    private LicensePlatesMapper licensePlatesMapper;

    /**
     * 查询车牌
     * 
     * @param plateId 车牌主键
     * @return 车牌
     */
    @Override
    public LicensePlates selectLicensePlatesByPlateId(Long plateId)
    {
        return licensePlatesMapper.selectLicensePlatesByPlateId(plateId);
    }

    /**
     * 查询车牌列表
     * 
     * @param licensePlates 车牌
     * @return 车牌
     */
    @Override
    public List<LicensePlates> selectLicensePlatesList(LicensePlates licensePlates)
    {
        return licensePlatesMapper.selectLicensePlatesList(licensePlates);
    }

    /**
     * 新增车牌
     * 
     * @param licensePlates 车牌
     * @return 结果
     */
    @Override
    public int insertLicensePlates(LicensePlates licensePlates)
    {
        licensePlates.setCreateTime(DateUtils.getNowDate());
        return licensePlatesMapper.insertLicensePlates(licensePlates);
    }

    /**
     * 修改车牌
     * 
     * @param licensePlates 车牌
     * @return 结果
     */
    @Override
    public int updateLicensePlates(LicensePlates licensePlates)
    {
        licensePlates.setUpdateTime(DateUtils.getNowDate());
        return licensePlatesMapper.updateLicensePlates(licensePlates);
    }

    /**
     * 批量删除车牌
     * 
     * @param plateIds 需要删除的车牌主键
     * @return 结果
     */
    @Override
    public int deleteLicensePlatesByPlateIds(Long[] plateIds)
    {
        return licensePlatesMapper.deleteLicensePlatesByPlateIds(plateIds);
    }

    /**
     * 删除车牌信息
     * 
     * @param plateId 车牌主键
     * @return 结果
     */
    @Override
    public int deleteLicensePlatesByPlateId(Long plateId)
    {
        return licensePlatesMapper.deleteLicensePlatesByPlateId(plateId);
    }
}
