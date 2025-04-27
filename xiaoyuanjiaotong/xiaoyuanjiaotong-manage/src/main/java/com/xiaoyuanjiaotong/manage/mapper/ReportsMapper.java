package com.xiaoyuanjiaotong.manage.mapper;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.Reports;

/**
 * 举报信息Mapper接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface ReportsMapper 
{
    /**
     * 查询举报信息
     * 
     * @param reportId 举报信息主键
     * @return 举报信息
     */
    public Reports selectReportsByReportId(Long reportId);

    /**
     * 查询举报信息列表
     * 
     * @param reports 举报信息
     * @return 举报信息集合
     */
    public List<Reports> selectReportsList(Reports reports);

    /**
     * 新增举报信息
     * 
     * @param reports 举报信息
     * @return 结果
     */
    public int insertReports(Reports reports);

    /**
     * 修改举报信息
     * 
     * @param reports 举报信息
     * @return 结果
     */
    public int updateReports(Reports reports);

    /**
     * 删除举报信息
     * 
     * @param reportId 举报信息主键
     * @return 结果
     */
    public int deleteReportsByReportId(Long reportId);

    /**
     * 批量删除举报信息
     * 
     * @param reportIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteReportsByReportIds(Long[] reportIds);
}
