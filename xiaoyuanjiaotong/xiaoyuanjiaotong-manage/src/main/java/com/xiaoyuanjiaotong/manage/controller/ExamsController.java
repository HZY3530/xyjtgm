package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.service.IExamsService;
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
import com.xiaoyuanjiaotong.manage.domain.Exams;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 题库题目Controller
 *
 * @author huhu
 * @date 2025-03-10
 */
@Api(tags = "题库题目Controller")
@RestController
@RequestMapping("/manage/exams")
public class ExamsController extends BaseController {
    @Autowired
    private IExamsService examsService;

    /**
     * 查询题库题目列表
     */
    @ApiOperation("查询题库题目列表")
    @PreAuthorize("@ss.hasPermi('manage:exams:list')")
    @GetMapping("/list")
    public TableDataInfo list(Exams exams) {
        startPage();
        List<Exams> list = examsService.selectExamsList(exams);
        return getDataTable(list);
    }

    /**
     * 导出题库题目列表
     */
    @ApiOperation("导出题库题目列表")
    @PreAuthorize("@ss.hasPermi('manage:exams:export')")
    @Log(title = "题库题目", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Exams exams) {
        List<Exams> list = examsService.selectExamsList(exams);
        ExcelUtil<Exams> util = new ExcelUtil<Exams>(Exams.class);
        util.exportExcel(response, list, "题库题目数据");
    }

    /**
     * 获取题库题目详细信息
     */
    @ApiOperation("获取题库题目详细信息")
    @PreAuthorize("@ss.hasPermi('manage:exams:query')")
    @GetMapping(value = "/{examId}")
    public AjaxResult getInfo(@PathVariable("examId") Long examId) {
        return success(examsService.selectExamsByExamId(examId));
    }

    /**
     * 新增题库题目
     */
    @ApiOperation("新增题库题目")
    @PreAuthorize("@ss.hasPermi('manage:exams:add')")
    @Log(title = "题库题目", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Exams exams) {
        return toAjax(examsService.insertExams(exams));
    }

    /**
     * 修改题库题目
     */
    @ApiOperation("修改题库题目")
    @PreAuthorize("@ss.hasPermi('manage:exams:edit')")
    @Log(title = "题库题目", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Exams exams) {
        return toAjax(examsService.updateExams(exams));
    }

    /**
     * 删除题库题目
     */
    @ApiOperation("删除题库题目")
    @PreAuthorize("@ss.hasPermi('manage:exams:remove')")
    @Log(title = "题库题目", businessType = BusinessType.DELETE)
    @DeleteMapping("/{examIds}")
    public AjaxResult remove(@PathVariable Long[] examIds) {
        return toAjax(examsService.deleteExamsByExamIds(examIds));
    }
}