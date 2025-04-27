package com.xiaoyuanjiaotong.manage.service;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.Questions;

/**
 * 题库Service接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface IQuestionsService 
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
     * 批量删除题库
     * 
     * @param questionIds 需要删除的题库主键集合
     * @return 结果
     */
    public int deleteQuestionsByQuestionIds(Long[] questionIds);

    /**
     * 删除题库信息
     * 
     * @param questionId 题库主键
     * @return 结果
     */
    public int deleteQuestionsByQuestionId(Long questionId);

    int insertListQuestions(List<Questions> questionsList);
}
