package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.service.ILicensePlatesService;
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
import com.xiaoyuanjiaotong.manage.domain.LicensePlates;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 车牌Controller
 *
 * @author huhu
 * @date 2025-03-10
 */
@Api(tags = "车牌Controller")
@RestController
@RequestMapping("/manage/plates")
public class LicensePlatesController extends BaseController {
    @Autowired
    private ILicensePlatesService licensePlatesService;

    /**
     * 查询车牌列表
     */
    @ApiOperation("查询车牌列表")
    @PreAuthorize("@ss.hasPermi('manage:plates:list')")
    @GetMapping("/list")
    public TableDataInfo list(LicensePlates licensePlates) {
        startPage();
        List<LicensePlates> list = licensePlatesService.selectLicensePlatesList(licensePlates);
        return getDataTable(list);
    }

    /**
     * 导出车牌列表
     */
    @ApiOperation("导出车牌列表")
    @PreAuthorize("@ss.hasPermi('manage:plates:export')")
    @Log(title = "车牌", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, LicensePlates licensePlates) {
        List<LicensePlates> list = licensePlatesService.selectLicensePlatesList(licensePlates);
        ExcelUtil<LicensePlates> util = new ExcelUtil<LicensePlates>(LicensePlates.class);
        util.exportExcel(response, list, "车牌数据");
    }

    /**
     * 获取车牌详细信息
     */
    @ApiOperation("获取车牌详细信息")
    @PreAuthorize("@ss.hasPermi('manage:plates:query')")
    @GetMapping(value = "/{plateId}")
    public AjaxResult getInfo(@PathVariable("plateId") Long plateId) {
        return success(licensePlatesService.selectLicensePlatesByPlateId(plateId));
    }

    /**
     * 新增车牌
     */
    @ApiOperation("新增车牌")
    @PreAuthorize("@ss.hasPermi('manage:plates:add')")
    @Log(title = "车牌", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody LicensePlates licensePlates) {
        return toAjax(licensePlatesService.insertLicensePlates(licensePlates));
    }

    /**
     * 修改车牌
     */
    @ApiOperation("修改车牌")
    @PreAuthorize("@ss.hasPermi('manage:plates:edit')")
    @Log(title = "车牌", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody LicensePlates licensePlates) {
        return toAjax(licensePlatesService.updateLicensePlates(licensePlates));
    }

    /**
     * 删除车牌
     */
    @ApiOperation("删除车牌")
    @PreAuthorize("@ss.hasPermi('manage:plates:remove')")
    @Log(title = "车牌", businessType = BusinessType.DELETE)
    @DeleteMapping("/{plateIds}")
    public AjaxResult remove(@PathVariable Long[] plateIds) {
        return toAjax(licensePlatesService.deleteLicensePlatesByPlateIds(plateIds));
    }
}