package com.xiaoyuanjiaotong.manage.domain;

import com.alibaba.excel.annotation.ExcelProperty;
import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 题库题目对象 exams
 *
 * @author huhu
 * @date 2025-03-10
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Exams extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 题库题目ID
     */
    private Long examId;
    /**
     * 问题ID
     */
    private Long questionId;
    /**
     * 题库问题内容
     */
    @Excel(name = "选项")
    private String examContent;
}