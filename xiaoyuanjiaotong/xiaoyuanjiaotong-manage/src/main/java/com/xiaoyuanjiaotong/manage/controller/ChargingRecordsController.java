package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.service.IChargingRecordsService;
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
import com.xiaoyuanjiaotong.manage.domain.ChargingRecords;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 充电记录Controller
 *
 * @author huhu
 * @date 2025-03-10
 */
@Api(tags = "充电记录Controller")
@RestController
@RequestMapping("/manage/records")
public class ChargingRecordsController extends BaseController {
    @Autowired
    private IChargingRecordsService chargingRecordsService;

    /**
     * 查询充电记录列表
     */
    @ApiOperation("查询充电记录列表")
    @PreAuthorize("@ss.hasPermi('manage:records:list')")
    @GetMapping("/list")
    public TableDataInfo list(ChargingRecords chargingRecords) {
        startPage();
        List<ChargingRecords> list = chargingRecordsService.selectChargingRecordsList(chargingRecords);
        return getDataTable(list);
    }

    /**
     * 导出充电记录列表
     */
    @ApiOperation("导出充电记录列表")
    @PreAuthorize("@ss.hasPermi('manage:records:export')")
    @Log(title = "充电记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ChargingRecords chargingRecords) {
        List<ChargingRecords> list = chargingRecordsService.selectChargingRecordsList(chargingRecords);
        ExcelUtil<ChargingRecords> util = new ExcelUtil<ChargingRecords>(ChargingRecords.class);
        util.exportExcel(response, list, "充电记录数据");
    }

    /**
     * 获取充电记录详细信息
     */
    @ApiOperation("获取充电记录详细信息")
    @PreAuthorize("@ss.hasPermi('manage:records:query')")
    @GetMapping(value = "/{recordId}")
    public AjaxResult getInfo(@PathVariable("recordId") Long recordId) {
        return success(chargingRecordsService.selectChargingRecordsByRecordId(recordId));
    }

    /**
     * 新增充电记录
     */
    @ApiOperation("新增充电记录")
    @PreAuthorize("@ss.hasPermi('manage:records:add')")
    @Log(title = "充电记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ChargingRecords chargingRecords) {
        return toAjax(chargingRecordsService.insertChargingRecords(chargingRecords));
    }

    /**
     * 修改充电记录
     */
    @ApiOperation("修改充电记录")
    @PreAuthorize("@ss.hasPermi('manage:records:edit')")
    @Log(title = "充电记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ChargingRecords chargingRecords) {
        return toAjax(chargingRecordsService.updateChargingRecords(chargingRecords));
    }

    /**
     * 删除充电记录
     */
    @ApiOperation("删除充电记录")
    @PreAuthorize("@ss.hasPermi('manage:records:remove')")
    @Log(title = "充电记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{recordIds}")
    public AjaxResult remove(@PathVariable Long[] recordIds) {
        return toAjax(chargingRecordsService.deleteChargingRecordsByRecordIds(recordIds));
    }
}