package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.service.IReportsService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.xiaoyuanjiaotong.common.annotation.Log;
import com.xiaoyuanjiaotong.common.core.controller.BaseController;
import com.xiaoyuanjiaotong.common.core.domain.AjaxResult;
import com.xiaoyuanjiaotong.common.enums.BusinessType;
import com.xiaoyuanjiaotong.manage.domain.Reports;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 举报信息Controller
 *
 * @author huhu
 * @date 2025-03-10
 */
@Api(tags = "举报信息Controller")
@RestController
@RequestMapping("/manage/reports")
public class ReportsController extends BaseController {
    @Autowired
    private IReportsService reportsService;

    /**
     * 查询举报信息列表
     */
    @ApiOperation("查询举报信息列表")
    @PreAuthorize("@ss.hasPermi('manage:reports:list')")
    @GetMapping("/list")
    public TableDataInfo list(Reports reports) {
        startPage();
        List<Reports> list = reportsService.selectReportsList(reports);
        return getDataTable(list);
    }

    /**
     * 导出举报信息列表
     */
    @ApiOperation("导出举报信息列表")
    @PreAuthorize("@ss.hasPermi('manage:reports:export')")
    @Log(title = "举报信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Reports reports) {
        List<Reports> list = reportsService.selectReportsList(reports);
        ExcelUtil<Reports> util = new ExcelUtil<Reports>(Reports.class);
        util.exportExcel(response, list, "举报信息数据");
    }

    /**
     * 获取举报信息详细信息
     */
    @ApiOperation("获取举报信息详细信息")
    @PreAuthorize("@ss.hasPermi('manage:reports:query')")
    @GetMapping(value = "/{reportId}")
    public AjaxResult getInfo(@PathVariable("reportId") Long reportId) {
        return success(reportsService.selectReportsByReportId(reportId));
    }

    /**
     * 新增举报信息
     */
    @ApiOperation("新增举报信息")
    @PreAuthorize("@ss.hasPermi('manage:reports:add')")
    @Log(title = "举报信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Reports reports) {
        return toAjax(reportsService.insertReports(reports));
    }

    /**
     * 修改举报信息
     */
    @ApiOperation("修改举报信息")
    @PreAuthorize("@ss.hasPermi('manage:reports:edit')")
    @Log(title = "举报信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Reports reports) {
        return toAjax(reportsService.updateReports(reports));
    }

    /**
     * 删除举报信息
     */
    @ApiOperation("删除举报信息")
    @PreAuthorize("@ss.hasPermi('manage:reports:remove')")
    @Log(title = "举报信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{reportIds}")
    public AjaxResult remove(@PathVariable Long[] reportIds) {
        return toAjax(reportsService.deleteReportsByReportIds(reportIds));
    }
}