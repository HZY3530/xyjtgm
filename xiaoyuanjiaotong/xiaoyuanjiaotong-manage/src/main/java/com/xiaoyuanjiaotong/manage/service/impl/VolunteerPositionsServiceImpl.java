package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;

import com.xiaoyuanjiaotong.manage.mapper.VolunteerPositionsMapper;
import com.xiaoyuanjiaotong.manage.service.IVolunteerPositionsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.domain.VolunteerPositions;

/**
 * 志愿岗位Service业务层处理
 * 
 * @author huhu
 * @date 2025-04-26
 */
@Service
public class VolunteerPositionsServiceImpl implements IVolunteerPositionsService
{
    @Autowired
    private VolunteerPositionsMapper volunteerPositionsMapper;

    /**
     * 查询志愿岗位
     * 
     * @param volunteerPositionId 志愿岗位主键
     * @return 志愿岗位
     */
    @Override
    public VolunteerPositions selectVolunteerPositionsByVolunteerPositionId(Long volunteerPositionId)
    {
        return volunteerPositionsMapper.selectVolunteerPositionsByVolunteerPositionId(volunteerPositionId);
    }

    /**
     * 查询志愿岗位列表
     * 
     * @param volunteerPositions 志愿岗位
     * @return 志愿岗位
     */
    @Override
    public List<VolunteerPositions> selectVolunteerPositionsList(VolunteerPositions volunteerPositions)
    {
        return volunteerPositionsMapper.selectVolunteerPositionsList(volunteerPositions);
    }

    /**
     * 新增志愿岗位
     * 
     * @param volunteerPositions 志愿岗位
     * @return 结果
     */
    @Override
    public int insertVolunteerPositions(VolunteerPositions volunteerPositions)
    {
        return volunteerPositionsMapper.insertVolunteerPositions(volunteerPositions);
    }

    /**
     * 修改志愿岗位
     * 
     * @param volunteerPositions 志愿岗位
     * @return 结果
     */
    @Override
    public int updateVolunteerPositions(VolunteerPositions volunteerPositions)
    {
        return volunteerPositionsMapper.updateVolunteerPositions(volunteerPositions);
    }

    /**
     * 批量删除志愿岗位
     * 
     * @param volunteerPositionIds 需要删除的志愿岗位主键
     * @return 结果
     */
    @Override
    public int deleteVolunteerPositionsByVolunteerPositionIds(Long[] volunteerPositionIds)
    {
        return volunteerPositionsMapper.deleteVolunteerPositionsByVolunteerPositionIds(volunteerPositionIds);
    }

    /**
     * 删除志愿岗位信息
     * 
     * @param volunteerPositionId 志愿岗位主键
     * @return 结果
     */
    @Override
    public int deleteVolunteerPositionsByVolunteerPositionId(Long volunteerPositionId)
    {
        return volunteerPositionsMapper.deleteVolunteerPositionsByVolunteerPositionId(volunteerPositionId);
    }
}
