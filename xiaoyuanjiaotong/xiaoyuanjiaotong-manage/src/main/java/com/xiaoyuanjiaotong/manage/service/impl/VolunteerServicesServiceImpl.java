package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;
import com.xiaoyuanjiaotong.common.utils.DateUtils;
import com.xiaoyuanjiaotong.manage.mapper.LicensePlatesMapper;
import com.xiaoyuanjiaotong.manage.mapper.VolunteerServicesMapper;
import com.xiaoyuanjiaotong.manage.domain.LicensePlates;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.domain.VolunteerServices;
import com.xiaoyuanjiaotong.manage.service.IVolunteerServicesService;

/**
 * 志愿信息Service业务层处理
 * 
 * @author huhu
 * @date 2025-03-10
 */
@Service
public class VolunteerServicesServiceImpl implements IVolunteerServicesService 
{
    @Autowired
    private VolunteerServicesMapper volunteerServicesMapper;
    @Autowired
    private LicensePlatesMapper licensePlatesMapper;

    /**
     * 查询志愿信息
     * 
     * @param serviceId 志愿信息主键
     * @return 志愿信息
     */
    @Override
    public VolunteerServices selectVolunteerServicesByServiceId(Long serviceId)
    {
        return volunteerServicesMapper.selectVolunteerServicesByServiceId(serviceId);
    }

    /**
     * 查询志愿信息列表
     * 
     * @param volunteerServices 志愿信息
     * @return 志愿信息
     */
    @Override
    public List<VolunteerServices> selectVolunteerServicesList(VolunteerServices volunteerServices)
    {
        return volunteerServicesMapper.selectVolunteerServicesList(volunteerServices);
    }

    /**
     * 新增志愿信息
     * 
     * @param volunteerServices 志愿信息
     * @return 结果
     */
    @Override
    public int insertVolunteerServices(VolunteerServices volunteerServices)
    {
        volunteerServices.setCreateTime(DateUtils.getNowDate());
        return volunteerServicesMapper.insertVolunteerServices(volunteerServices);
    }

    /**
     * 修改志愿信息
     * 
     * @param volunteerServices 志愿信息
     * @return 结果
     */
    @Override
    public int updateVolunteerServices(VolunteerServices volunteerServices)
    {
        volunteerServices.setUpdateTime(DateUtils.getNowDate());
        if(volunteerServices.getStatus().equals("已处理")){
            LicensePlates licensePlates=new LicensePlates();
            licensePlates.setPlateId(volunteerServices.getPlateId());
            int score =licensePlatesMapper.selectLicensePlatesByPlateId(volunteerServices.getPlateId()).getScore();
            licensePlates.setScore(Math.min(score + volunteerServices.getScore(), 12));
            licensePlatesMapper.updateLicensePlates(licensePlates);
        }
        return volunteerServicesMapper.updateVolunteerServices(volunteerServices);
    }

    /**
     * 批量删除志愿信息
     * 
     * @param serviceIds 需要删除的志愿信息主键
     * @return 结果
     */
    @Override
    public int deleteVolunteerServicesByServiceIds(Long[] serviceIds)
    {
        return volunteerServicesMapper.deleteVolunteerServicesByServiceIds(serviceIds);
    }

    /**
     * 删除志愿信息信息
     * 
     * @param serviceId 志愿信息主键
     * @return 结果
     */
    @Override
    public int deleteVolunteerServicesByServiceId(Long serviceId)
    {
        return volunteerServicesMapper.deleteVolunteerServicesByServiceId(serviceId);
    }
}
