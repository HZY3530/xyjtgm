package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;
import com.xiaoyuanjiaotong.common.utils.DateUtils;
import com.xiaoyuanjiaotong.manage.mapper.LicensePlatesMapper;
import com.xiaoyuanjiaotong.manage.mapper.ReportsMapper;
import com.xiaoyuanjiaotong.manage.service.IReportsService;
import com.xiaoyuanjiaotong.manage.domain.LicensePlates;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.domain.Reports;

/**
 * 举报信息Service业务层处理
 * 
 * @author huhu
 * @date 2025-03-10
 */
@Service
public class ReportsServiceImpl implements IReportsService
{
    @Autowired
    private ReportsMapper reportsMapper;
    @Autowired
    private LicensePlatesMapper licensePlatesMapper;

    /**
     * 查询举报信息
     * 
     * @param reportId 举报信息主键
     * @return 举报信息
     */
    @Override
    public Reports selectReportsByReportId(Long reportId)
    {
        return reportsMapper.selectReportsByReportId(reportId);
    }

    /**
     * 查询举报信息列表
     * 
     * @param reports 举报信息
     * @return 举报信息
     */
    @Override
    public List<Reports> selectReportsList(Reports reports)
    {
        return reportsMapper.selectReportsList(reports);
    }

    /**
     * 新增举报信息
     * 
     * @param reports 举报信息
     * @return 结果
     */
    @Override
    public int insertReports(Reports reports)
    {
        reports.setCreateTime(DateUtils.getNowDate());
        reports.setStatus("未处理");
        return reportsMapper.insertReports(reports);
    }

    /**
     * 修改举报信息
     * 
     * @param reports 举报信息
     * @return 结果
     */
    @Override
    public int updateReports(Reports reports)
    {
        reports.setUpdateTime(DateUtils.getNowDate());
        if(reports.getStatus().equals("已处理")){
            LicensePlates licensePlates=new LicensePlates();
            licensePlates.setPlateId(reports.getPlateId());
            int score =licensePlatesMapper.selectLicensePlatesByPlateId(reports.getPlateId()).getScore();
            licensePlates.setScore(Math.max(score - reports.getScore(), 0));
            licensePlatesMapper.updateLicensePlates(licensePlates);
        }
        return reportsMapper.updateReports(reports);
    }

    /**
     * 批量删除举报信息
     * 
     * @param reportIds 需要删除的举报信息主键
     * @return 结果
     */
    @Override
    public int deleteReportsByReportIds(Long[] reportIds)
    {
        return reportsMapper.deleteReportsByReportIds(reportIds);
    }

    /**
     * 删除举报信息信息
     * 
     * @param reportId 举报信息主键
     * @return 结果
     */
    @Override
    public int deleteReportsByReportId(Long reportId)
    {
        return reportsMapper.deleteReportsByReportId(reportId);
    }
}
