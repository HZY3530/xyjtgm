package com.xiaoyuanjiaotong.manage.service;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.VolunteerPositions;

/**
 * 志愿岗位Service接口
 * 
 * @author huhu
 * @date 2025-04-26
 */
public interface IVolunteerPositionsService 
{
    /**
     * 查询志愿岗位
     * 
     * @param volunteerPositionId 志愿岗位主键
     * @return 志愿岗位
     */
    public VolunteerPositions selectVolunteerPositionsByVolunteerPositionId(Long volunteerPositionId);

    /**
     * 查询志愿岗位列表
     * 
     * @param volunteerPositions 志愿岗位
     * @return 志愿岗位集合
     */
    public List<VolunteerPositions> selectVolunteerPositionsList(VolunteerPositions volunteerPositions);

    /**
     * 新增志愿岗位
     * 
     * @param volunteerPositions 志愿岗位
     * @return 结果
     */
    public int insertVolunteerPositions(VolunteerPositions volunteerPositions);

    /**
     * 修改志愿岗位
     * 
     * @param volunteerPositions 志愿岗位
     * @return 结果
     */
    public int updateVolunteerPositions(VolunteerPositions volunteerPositions);

    /**
     * 批量删除志愿岗位
     * 
     * @param volunteerPositionIds 需要删除的志愿岗位主键集合
     * @return 结果
     */
    public int deleteVolunteerPositionsByVolunteerPositionIds(Long[] volunteerPositionIds);

    /**
     * 删除志愿岗位信息
     * 
     * @param volunteerPositionId 志愿岗位主键
     * @return 结果
     */
    public int deleteVolunteerPositionsByVolunteerPositionId(Long volunteerPositionId);
}
