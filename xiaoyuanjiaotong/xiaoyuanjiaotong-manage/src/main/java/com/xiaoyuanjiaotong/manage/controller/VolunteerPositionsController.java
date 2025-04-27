package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.service.IVolunteerPositionsService;
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
import com.xiaoyuanjiaotong.manage.domain.VolunteerPositions;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
    import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 志愿岗位Controller
 *
 * @author huhu
 * @date 2025-04-26
 */
@Api(tags = "志愿岗位Controller")
@RestController
@RequestMapping("/manage/positions")
public class VolunteerPositionsController extends BaseController {
    @Autowired
    private IVolunteerPositionsService volunteerPositionsService;

/**
 * 查询志愿岗位列表
 */
@ApiOperation("查询志愿岗位列表")
@PreAuthorize("@ss.hasPermi('manage:positions:list')")
@GetMapping("/list")
    public TableDataInfo list(VolunteerPositions volunteerPositions) {
        startPage();
        List<VolunteerPositions> list = volunteerPositionsService.selectVolunteerPositionsList(volunteerPositions);
        return getDataTable(list);
    }

    /**
     * 导出志愿岗位列表
     */
    @ApiOperation("导出志愿岗位列表")
    @PreAuthorize("@ss.hasPermi('manage:positions:export')")
    @Log(title = "志愿岗位", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, VolunteerPositions volunteerPositions) {
        List<VolunteerPositions> list = volunteerPositionsService.selectVolunteerPositionsList(volunteerPositions);
        ExcelUtil<VolunteerPositions> util = new ExcelUtil<VolunteerPositions>(VolunteerPositions. class);
        util.exportExcel(response, list, "志愿岗位数据");
    }

    /**
     * 获取志愿岗位详细信息
     */
    @ApiOperation("获取志愿岗位详细信息")
    @PreAuthorize("@ss.hasPermi('manage:positions:query')")
    @GetMapping(value = "/{volunteerPositionId}")
    public AjaxResult getInfo(@PathVariable("volunteerPositionId") Long volunteerPositionId) {
        return success(volunteerPositionsService.selectVolunteerPositionsByVolunteerPositionId(volunteerPositionId));
    }

    /**
     * 新增志愿岗位
     */
    @ApiOperation("新增志愿岗位")
    @PreAuthorize("@ss.hasPermi('manage:positions:add')")
    @Log(title = "志愿岗位", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody VolunteerPositions volunteerPositions) {
        return toAjax(volunteerPositionsService.insertVolunteerPositions(volunteerPositions));
    }

    /**
     * 修改志愿岗位
     */
    @ApiOperation("修改志愿岗位")
    @PreAuthorize("@ss.hasPermi('manage:positions:edit')")
    @Log(title = "志愿岗位", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody VolunteerPositions volunteerPositions) {
        return toAjax(volunteerPositionsService.updateVolunteerPositions(volunteerPositions));
    }

    /**
     * 删除志愿岗位
     */
    @ApiOperation("删除志愿岗位")
    @PreAuthorize("@ss.hasPermi('manage:positions:remove')")
    @Log(title = "志愿岗位", businessType = BusinessType.DELETE)
    @DeleteMapping("/{volunteerPositionIds}")
    public AjaxResult remove(@PathVariable Long[] volunteerPositionIds) {
        return toAjax(volunteerPositionsService.deleteVolunteerPositionsByVolunteerPositionIds(volunteerPositionIds));
    }
}