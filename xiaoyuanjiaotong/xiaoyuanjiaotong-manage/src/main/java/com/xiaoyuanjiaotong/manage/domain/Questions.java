package com.xiaoyuanjiaotong.manage.domain;

import java.util.List;

import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.HeadFontStyle;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;

/**
 * 题库对象 questions
 *
 * @author huhu
 * @date 2025-03-10
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ExcelIgnoreUnannotated// 注解表示在导出Excel时，忽略没有被任何注解标记的字段
@ColumnWidth(16)// 注解用于设置列的宽度
@HeadRowHeight(14)// 注解用于设置表头行的高度
@HeadFontStyle(fontHeightInPoints = 11)// 注解用于设置表头的字体样式
public class Questions extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 问题ID
     */
    private Long questionId;
    /**
     * 问题
     */
    @Excel(name = "题目")
    private String questionContent;
    /**
     * 答案
     */
    @Excel(name = "答案")
    private String answer;
    /**
     * 问题类型
     */
    @Excel(name = "问题类型")
    private String category;
    /**
     * 题库题目信息
     */
    @Excel(name = "选项列表")
    private List<Exams> examsList;

}