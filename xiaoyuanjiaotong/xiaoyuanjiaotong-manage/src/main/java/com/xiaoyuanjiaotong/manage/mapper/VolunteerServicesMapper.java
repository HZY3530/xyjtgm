package com.xiaoyuanjiaotong.manage.mapper;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.VolunteerServices;

/**
 * 志愿信息Mapper接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface VolunteerServicesMapper 
{
    /**
     * 查询志愿信息
     * 
     * @param serviceId 志愿信息主键
     * @return 志愿信息
     */
    public VolunteerServices selectVolunteerServicesByServiceId(Long serviceId);

    /**
     * 查询志愿信息列表
     * 
     * @param volunteerServices 志愿信息
     * @return 志愿信息集合
     */
    public List<VolunteerServices> selectVolunteerServicesList(VolunteerServices volunteerServices);

    /**
     * 新增志愿信息
     * 
     * @param volunteerServices 志愿信息
     * @return 结果
     */
    public int insertVolunteerServices(VolunteerServices volunteerServices);

    /**
     * 修改志愿信息
     * 
     * @param volunteerServices 志愿信息
     * @return 结果
     */
    public int updateVolunteerServices(VolunteerServices volunteerServices);

    /**
     * 删除志愿信息
     * 
     * @param serviceId 志愿信息主键
     * @return 结果
     */
    public int deleteVolunteerServicesByServiceId(Long serviceId);

    /**
     * 批量删除志愿信息
     * 
     * @param serviceIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteVolunteerServicesByServiceIds(Long[] serviceIds);
}
