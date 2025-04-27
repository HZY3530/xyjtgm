package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;

import com.xiaoyuanjiaotong.manage.mapper.ExamsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.domain.Exams;
import com.xiaoyuanjiaotong.manage.service.IExamsService;

/**
 * 题库题目Service业务层处理
 * 
 * @author huhu
 * @date 2025-03-10
 */
@Service
public class ExamsServiceImpl implements IExamsService 
{
    @Autowired
    private ExamsMapper examsMapper;

    /**
     * 查询题库题目
     * 
     * @param examId 题库题目主键
     * @return 题库题目
     */
    @Override
    public Exams selectExamsByExamId(Long examId)
    {
        return examsMapper.selectExamsByExamId(examId);
    }

    /**
     * 查询题库题目列表
     * 
     * @param exams 题库题目
     * @return 题库题目
     */
    @Override
    public List<Exams> selectExamsList(Exams exams)
    {
        return examsMapper.selectExamsList(exams);
    }

    /**
     * 新增题库题目
     * 
     * @param exams 题库题目
     * @return 结果
     */
    @Override
    public int insertExams(Exams exams)
    {
        return examsMapper.insertExams(exams);
    }

    /**
     * 修改题库题目
     * 
     * @param exams 题库题目
     * @return 结果
     */
    @Override
    public int updateExams(Exams exams)
    {
        return examsMapper.updateExams(exams);
    }

    /**
     * 批量删除题库题目
     * 
     * @param examIds 需要删除的题库题目主键
     * @return 结果
     */
    @Override
    public int deleteExamsByExamIds(Long[] examIds)
    {
        return examsMapper.deleteExamsByExamIds(examIds);
    }

    /**
     * 删除题库题目信息
     * 
     * @param examId 题库题目主键
     * @return 结果
     */
    @Override
    public int deleteExamsByExamId(Long examId)
    {
        return examsMapper.deleteExamsByExamId(examId);
    }
}
