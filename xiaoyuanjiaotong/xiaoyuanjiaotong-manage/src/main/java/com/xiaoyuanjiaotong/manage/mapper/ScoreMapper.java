package com.xiaoyuanjiaotong.manage.mapper;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.Score;

/**
 * 学法考试分数Mapper接口
 * 
 * @author huhu
 * @date 2025-04-26
 */
public interface ScoreMapper 
{
    /**
     * 查询学法考试分数
     * 
     * @param id 学法考试分数主键
     * @return 学法考试分数
     */
    public Score selectScoreById(Long id);

    /**
     * 查询学法考试分数列表
     * 
     * @param score 学法考试分数
     * @return 学法考试分数集合
     */
    public List<Score> selectScoreList(Score score);

    /**
     * 新增学法考试分数
     * 
     * @param score 学法考试分数
     * @return 结果
     */
    public int insertScore(Score score);

    /**
     * 修改学法考试分数
     * 
     * @param score 学法考试分数
     * @return 结果
     */
    public int updateScore(Score score);

    /**
     * 删除学法考试分数
     * 
     * @param id 学法考试分数主键
     * @return 结果
     */
    public int deleteScoreById(Long id);

    /**
     * 批量删除学法考试分数
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteScoreByIds(Long[] ids);
}
