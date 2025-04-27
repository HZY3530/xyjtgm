package com.xiaoyuanjiaotong.manage.service;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.Exams;
import org.apache.ibatis.annotations.Select;

/**
 * 题库题目Service接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface IExamsService 
{
    /**
     * 查询题库题目
     * 
     * @param examId 题库题目主键
     * @return 题库题目
     */
    public Exams selectExamsByExamId(Long examId);

    /**
     * 查询题库题目列表
     * 
     * @param exams 题库题目
     * @return 题库题目集合
     */
    public List<Exams> selectExamsList(Exams exams);

    /**
     * 新增题库题目
     * 
     * @param exams 题库题目
     * @return 结果
     */
    public int insertExams(Exams exams);

    /**
     * 修改题库题目
     * 
     * @param exams 题库题目
     * @return 结果
     */
    public int updateExams(Exams exams);

    /**
     * 批量删除题库题目
     * 
     * @param examIds 需要删除的题库题目主键集合
     * @return 结果
     */
    public int deleteExamsByExamIds(Long[] examIds);

    /**
     * 删除题库题目信息
     * 
     * @param examId 题库题目主键
     * @return 结果
     */
    public int deleteExamsByExamId(Long examId);

}
