package com.xiaoyuanjiaotong.manage.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;

import com.xiaoyuanjiaotong.manage.domain.Score;
import com.xiaoyuanjiaotong.manage.service.IScoreService;
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
import com.xiaoyuanjiaotong.common.utils.poi.ExcelUtil;
    import com.xiaoyuanjiaotong.common.core.page.TableDataInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

/**
 * 学法考试分数Controller
 *
 * @author huhu
 * @date 2025-04-26
 */
@Api(tags = "学法考试分数Controller")
@RestController
@RequestMapping("/manage/score")
public class ScoreController extends BaseController {
    @Autowired
    private IScoreService scoreService;

/**
 * 查询学法考试分数列表
 */
@ApiOperation("查询学法考试分数列表")
@PreAuthorize("@ss.hasPermi('manage:score:list')")
@GetMapping("/list")
    public TableDataInfo list(Score score) {
        startPage();
        List<Score> list = scoreService.selectScoreList(score);
        return getDataTable(list);
    }

    /**
     * 导出学法考试分数列表
     */
    @ApiOperation("导出学法考试分数列表")
    @PreAuthorize("@ss.hasPermi('manage:score:export')")
    @Log(title = "学法考试分数", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Score score) {
        List<Score> list = scoreService.selectScoreList(score);
        ExcelUtil<Score> util = new ExcelUtil<Score>(Score. class);
        util.exportExcel(response, list, "学法考试分数数据");
    }

    /**
     * 获取学法考试分数详细信息
     */
    @ApiOperation("获取学法考试分数详细信息")
    @PreAuthorize("@ss.hasPermi('manage:score:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        return success(scoreService.selectScoreById(id));
    }

    /**
     * 新增学法考试分数
     */
    @ApiOperation("新增学法考试分数")
    @PreAuthorize("@ss.hasPermi('manage:score:add')")
    @Log(title = "学法考试分数", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Score score) {
        return toAjax(scoreService.insertScore(score));
    }

    /**
     * 修改学法考试分数
     */
    @ApiOperation("修改学法考试分数")
    @PreAuthorize("@ss.hasPermi('manage:score:edit')")
    @Log(title = "学法考试分数", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Score score) {
        return toAjax(scoreService.updateScore(score));
    }

    /**
     * 删除学法考试分数
     */
    @ApiOperation("删除学法考试分数")
    @PreAuthorize("@ss.hasPermi('manage:score:remove')")
    @Log(title = "学法考试分数", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(scoreService.deleteScoreByIds(ids));
    }
}