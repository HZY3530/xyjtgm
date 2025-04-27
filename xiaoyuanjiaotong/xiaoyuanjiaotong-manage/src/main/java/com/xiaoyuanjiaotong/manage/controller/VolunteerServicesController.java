package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.service.IVolunteerServicesService;
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
import com.xiaoyuanjiaotong.manage.domain.VolunteerServices;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 志愿信息Controller
 *
 * @author huhu
 * @date 2025-03-10
 */
@Api(tags = "志愿信息Controller")
@RestController
@RequestMapping("/manage/services")
public class VolunteerServicesController extends BaseController {
    @Autowired
    private IVolunteerServicesService volunteerServicesService;

    /**
     * 查询志愿信息列表
     */
    @ApiOperation("查询志愿信息列表")
    @PreAuthorize("@ss.hasPermi('manage:services:list')")
    @GetMapping("/list")
    public TableDataInfo list(VolunteerServices volunteerServices) {
        startPage();
        List<VolunteerServices> list = volunteerServicesService.selectVolunteerServicesList(volunteerServices);
        return getDataTable(list);
    }

    /**
     * 导出志愿信息列表
     */
    @ApiOperation("导出志愿信息列表")
    @PreAuthorize("@ss.hasPermi('manage:services:export')")
    @Log(title = "志愿信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, VolunteerServices volunteerServices) {
        List<VolunteerServices> list = volunteerServicesService.selectVolunteerServicesList(volunteerServices);
        ExcelUtil<VolunteerServices> util = new ExcelUtil<VolunteerServices>(VolunteerServices.class);
        util.exportExcel(response, list, "志愿信息数据");
    }

    /**
     * 获取志愿信息详细信息
     */
    @ApiOperation("获取志愿信息详细信息")
    @PreAuthorize("@ss.hasPermi('manage:services:query')")
    @GetMapping(value = "/{serviceId}")
    public AjaxResult getInfo(@PathVariable("serviceId") Long serviceId) {
        return success(volunteerServicesService.selectVolunteerServicesByServiceId(serviceId));
    }

    /**
     * 新增志愿信息
     */
    @ApiOperation("新增志愿信息")
    @PreAuthorize("@ss.hasPermi('manage:services:add')")
    @Log(title = "志愿信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody VolunteerServices volunteerServices) {
        return toAjax(volunteerServicesService.insertVolunteerServices(volunteerServices));
    }

    /**
     * 修改志愿信息
     */
    @ApiOperation("修改志愿信息")
    @PreAuthorize("@ss.hasPermi('manage:services:edit')")
    @Log(title = "志愿信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody VolunteerServices volunteerServices) {
        return toAjax(volunteerServicesService.updateVolunteerServices(volunteerServices));
    }

    /**
     * 删除志愿信息
     */
    @ApiOperation("删除志愿信息")
    @PreAuthorize("@ss.hasPermi('manage:services:remove')")
    @Log(title = "志愿信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{serviceIds}")
    public AjaxResult remove(@PathVariable Long[] serviceIds) {
        return toAjax(volunteerServicesService.deleteVolunteerServicesByServiceIds(serviceIds));
    }
}