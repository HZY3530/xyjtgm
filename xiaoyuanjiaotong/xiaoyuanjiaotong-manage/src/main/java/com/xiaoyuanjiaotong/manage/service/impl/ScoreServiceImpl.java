package com.xiaoyuanjiaotong.manage.service.impl;

import java.util.List;

import com.xiaoyuanjiaotong.manage.mapper.ScoreMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoyuanjiaotong.manage.domain.Score;
import com.xiaoyuanjiaotong.manage.service.IScoreService;

/**
 * 学法考试分数Service业务层处理
 * 
 * @author huhu
 * @date 2025-04-26
 */
@Service
public class ScoreServiceImpl implements IScoreService 
{
    @Autowired
    private ScoreMapper scoreMapper;

    /**
     * 查询学法考试分数
     * 
     * @param id 学法考试分数主键
     * @return 学法考试分数
     */
    @Override
    public Score selectScoreById(Long id)
    {
        return scoreMapper.selectScoreById(id);
    }

    /**
     * 查询学法考试分数列表
     * 
     * @param score 学法考试分数
     * @return 学法考试分数
     */
    @Override
    public List<Score> selectScoreList(Score score)
    {
        return scoreMapper.selectScoreList(score);
    }

    /**
     * 新增学法考试分数
     * 
     * @param score 学法考试分数
     * @return 结果
     */
    @Override
    public int insertScore(Score score)
    {
        return scoreMapper.insertScore(score);
    }

    /**
     * 修改学法考试分数
     * 
     * @param score 学法考试分数
     * @return 结果
     */
    @Override
    public int updateScore(Score score)
    {
        return scoreMapper.updateScore(score);
    }

    /**
     * 批量删除学法考试分数
     * 
     * @param ids 需要删除的学法考试分数主键
     * @return 结果
     */
    @Override
    public int deleteScoreByIds(Long[] ids)
    {
        return scoreMapper.deleteScoreByIds(ids);
    }

    /**
     * 删除学法考试分数信息
     * 
     * @param id 学法考试分数主键
     * @return 结果
     */
    @Override
    public int deleteScoreById(Long id)
    {
        return scoreMapper.deleteScoreById(id);
    }
}
