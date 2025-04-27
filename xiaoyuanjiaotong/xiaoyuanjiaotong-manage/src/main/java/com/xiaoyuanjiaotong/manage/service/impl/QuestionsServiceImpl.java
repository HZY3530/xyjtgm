package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;

import com.xiaoyuanjiaotong.manage.mapper.QuestionsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import com.xiaoyuanjiaotong.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import com.xiaoyuanjiaotong.manage.domain.Exams;
import com.xiaoyuanjiaotong.manage.domain.Questions;
import com.xiaoyuanjiaotong.manage.service.IQuestionsService;

/**
 * 题库Service业务层处理
 * 
 * @author huhu
 * @date 2025-03-10
 */
@Service
public class QuestionsServiceImpl implements IQuestionsService 
{
    @Autowired
    private QuestionsMapper questionsMapper;

    /**
     * 查询题库
     * 
     * @param questionId 题库主键
     * @return 题库
     */
    @Override
    public Questions selectQuestionsByQuestionId(Long questionId)
    {
        return questionsMapper.selectQuestionsByQuestionId(questionId);
    }

    /**
     * 查询题库列表
     * 
     * @param questions 题库
     * @return 题库
     */
    @Override
    public List<Questions> selectQuestionsList(Questions questions)
    {
        List<Questions> list=questionsMapper.selectQuestionsList(questions);
        for (Questions question : list) {
            List<Exams> examsList = questionsMapper.selectExamsList(question.getQuestionId());
            System.out.println(examsList);
            question.setExamsList(examsList);
        }
        return list;
    }

    /**
     * 新增题库
     * 
     * @param questions 题库
     * @return 结果
     */
    @Transactional
    @Override
    public int insertQuestions(Questions questions)
    {
        int rows = questionsMapper.insertQuestions(questions);
        insertExams(questions);
        return rows;
    }
    /**
     * 批量新增商品管理
     * @param  questionsList
     * @return 结果
     */
    /**
     * 批量新增题库
     * @param questionsList 题库列表
     * @return 结果
     */
    @Override
    public int insertListQuestions(List<Questions> questionsList) {
        int totalRows = 0;
        for (Questions questions : questionsList) {
            int rows = questionsMapper.insertQuestions(questions);
            insertExams(questions);
            totalRows += rows;
        }
        return totalRows;
    }


    /**
     * 修改题库
     * 
     * @param questions 题库
     * @return 结果
     */
    @Transactional
    @Override
    public int updateQuestions(Questions questions)
    {
        questionsMapper.deleteExamsByQuestionId(questions.getQuestionId());
        insertExams(questions);
        return questionsMapper.updateQuestions(questions);
    }

    /**
     * 批量删除题库
     * 
     * @param questionIds 需要删除的题库主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteQuestionsByQuestionIds(Long[] questionIds)
    {
        questionsMapper.deleteExamsByQuestionIds(questionIds);
        return questionsMapper.deleteQuestionsByQuestionIds(questionIds);
    }

    /**
     * 删除题库信息
     * 
     * @param questionId 题库主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteQuestionsByQuestionId(Long questionId)
    {
        questionsMapper.deleteExamsByQuestionId(questionId);
        return questionsMapper.deleteQuestionsByQuestionId(questionId);
    }

    /**
     * 新增题库题目信息
     * 
     * @param questions 题库对象
     */
    public void insertExams(Questions questions)
    {
        List<Exams> examsList = questions.getExamsList();
        Long questionId = questions.getQuestionId();
        if (StringUtils.isNotNull(examsList))
        {
            List<Exams> list = new ArrayList<Exams>();
            for (Exams exams : examsList)
            {
                exams.setQuestionId(questionId);
                list.add(exams);
            }
            if (list.size() > 0)
            {
                questionsMapper.batchExams(list);
            }
        }
    }
}
