package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.service.IChargingstationsService;
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
import com.xiaoyuanjiaotong.manage.domain.Chargingstations;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
    import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 充电桩Controller
 *
 * @author huhu
 * @date 2025-04-26
 */
@Api(tags = "充电桩Controller")
@RestController
@RequestMapping("/manage/chargingstations")
public class ChargingstationsController extends BaseController {
    @Autowired
    private IChargingstationsService chargingstationsService;

/**
 * 查询充电桩列表
 */
@ApiOperation("查询充电桩列表")
@PreAuthorize("@ss.hasPermi('manage:chargingstations:list')")
@GetMapping("/list")
    public TableDataInfo list(Chargingstations chargingstations) {
        startPage();
        List<Chargingstations> list = chargingstationsService.selectChargingstationsList(chargingstations);
        return getDataTable(list);
    }

    /**
     * 导出充电桩列表
     */
    @ApiOperation("导出充电桩列表")
    @PreAuthorize("@ss.hasPermi('manage:chargingstations:export')")
    @Log(title = "充电桩", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Chargingstations chargingstations) {
        List<Chargingstations> list = chargingstationsService.selectChargingstationsList(chargingstations);
        ExcelUtil<Chargingstations> util = new ExcelUtil<Chargingstations>(Chargingstations. class);
        util.exportExcel(response, list, "充电桩数据");
    }

    /**
     * 获取充电桩详细信息
     */
    @ApiOperation("获取充电桩详细信息")
    @PreAuthorize("@ss.hasPermi('manage:chargingstations:query')")
    @GetMapping(value = "/{stationID}")
    public AjaxResult getInfo(@PathVariable("stationID") Long stationID) {
        return success(chargingstationsService.selectChargingstationsByStationID(stationID));
    }

    /**
     * 新增充电桩
     */
    @ApiOperation("新增充电桩")
    @PreAuthorize("@ss.hasPermi('manage:chargingstations:add')")
    @Log(title = "充电桩", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Chargingstations chargingstations) {
        return toAjax(chargingstationsService.insertChargingstations(chargingstations));
    }

    /**
     * 修改充电桩
     */
    @ApiOperation("修改充电桩")
    @PreAuthorize("@ss.hasPermi('manage:chargingstations:edit')")
    @Log(title = "充电桩", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Chargingstations chargingstations) {
        return toAjax(chargingstationsService.updateChargingstations(chargingstations));
    }

    /**
     * 删除充电桩
     */
    @ApiOperation("删除充电桩")
    @PreAuthorize("@ss.hasPermi('manage:chargingstations:remove')")
    @Log(title = "充电桩", businessType = BusinessType.DELETE)
    @DeleteMapping("/{stationIDs}")
    public AjaxResult remove(@PathVariable Long[] stationIDs) {
        return toAjax(chargingstationsService.deleteChargingstationsByStationIDs(stationIDs));
    }
}