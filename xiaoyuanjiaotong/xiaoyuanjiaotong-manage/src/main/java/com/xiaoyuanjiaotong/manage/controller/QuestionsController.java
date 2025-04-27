package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.util.QusetionExcel;
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
import com.xiaoyuanjiaotong.manage.domain.Questions;
import com.xiaoyuanjiaotong.manage.service.IQuestionsService;
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.multipart.MultipartFile;

/**
 * 题库Controller
 *
 * @author huhu
 * @date 2025-03-10
 */
@Api(tags = "题库Controller")
@RestController
@RequestMapping("/manage/questions")
public class QuestionsController extends BaseController {
    @Autowired
    private IQuestionsService questionsService;

    /**
     * 查询题库列表
     */
    @ApiOperation("查询题库列表")
    @PreAuthorize("@ss.hasPermi('manage:questions:list')")
    @GetMapping("/list")
    public TableDataInfo list(Questions questions) {
        startPage();
        List<Questions> list = questionsService.selectQuestionsList(questions);
        System.out.println(list);
        return getDataTable(list);
    }
    /**
     * 导出商品管理列表
     */
    @ApiOperation("导出题库列表")
    @PreAuthorize("@ss.hasPermi('manage:questions:export')")
    @Log(title = "题库", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Questions questions) {
        List<Questions> list = questionsService.selectQuestionsList(questions);
        ExcelUtil<Questions> util = new ExcelUtil<Questions>(Questions.class);

        util.exportExcel(response, list, "题库数据");
    }

    @PostMapping("/import")
    public AjaxResult importData(MultipartFile file) throws Exception {
        List<Questions> questionsList = QusetionExcel.importExcel("", file.getInputStream(), 0);
        questionsService.insertListQuestions(questionsList);
        return AjaxResult.success("导入成功");
    }
    /**
     * 获取题库详细信息
     */
    @ApiOperation("获取题库详细信息")
    @PreAuthorize("@ss.hasPermi('manage:questions:query')")
    @GetMapping(value = "/{questionId}")
    public AjaxResult getInfo(@PathVariable("questionId") Long questionId) {
        return success(questionsService.selectQuestionsByQuestionId(questionId));
    }

    /**
     * 新增题库
     */
    @ApiOperation("新增题库")
    @PreAuthorize("@ss.hasPermi('manage:questions:add')")
    @Log(title = "题库", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Questions questions) {
        return toAjax(questionsService.insertQuestions(questions));
    }

    /**
     * 修改题库
     */
    @ApiOperation("修改题库")
    @PreAuthorize("@ss.hasPermi('manage:questions:edit')")
    @Log(title = "题库", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Questions questions) {
        return toAjax(questionsService.updateQuestions(questions));
    }

    /**
     * 删除题库
     */
    @ApiOperation("删除题库")
    @PreAuthorize("@ss.hasPermi('manage:questions:remove')")
    @Log(title = "题库", businessType = BusinessType.DELETE)
    @DeleteMapping("/{questionIds}")
    public AjaxResult remove(@PathVariable Long[] questionIds) {
        return toAjax(questionsService.deleteQuestionsByQuestionIds(questionIds));
    }
}