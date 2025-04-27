package com.xiaoyuanjiaotong.manage.mapper;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.Questions;
import com.xiaoyuanjiaotong.manage.domain.Exams;

/**
 * 题库Mapper接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface QuestionsMapper 
{
    /**
     * 查询题库
     * 
     * @param questionId 题库主键
     * @return 题库
     */
    public Questions selectQuestionsByQuestionId(Long questionId);

    /**
     * 查询题库列表
     * 
     * @param questions 题库
     * @return 题库集合
     */
    public List<Questions> selectQuestionsList(Questions questions);

    /**
     * 新增题库
     * 
     * @param questions 题库
     * @return 结果
     */
    public int insertQuestions(Questions questions);

    /**
     * 修改题库
     * 
     * @param questions 题库
     * @return 结果
     */
    public int updateQuestions(Questions questions);

    /**
     * 删除题库
     * 
     * @param questionId 题库主键
     * @return 结果
     */
    public int deleteQuestionsByQuestionId(Long questionId);

    /**
     * 批量删除题库
     * 
     * @param questionIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteQuestionsByQuestionIds(Long[] questionIds);

    /**
     * 批量删除题库题目
     * 
     * @param questionIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamsByQuestionIds(Long[] questionIds);
    
    /**
     * 批量新增题库题目
     * 
     * @param examsList 题库题目列表
     * @return 结果
     */
    public int batchExams(List<Exams> examsList);

    public List<Exams> selectExamsList(Long questionId);
    

    /**
     * 通过题库主键删除题库题目信息
     * 
     * @param questionId 题库ID
     * @return 结果
     */
    public int deleteExamsByQuestionId(Long questionId);
}
