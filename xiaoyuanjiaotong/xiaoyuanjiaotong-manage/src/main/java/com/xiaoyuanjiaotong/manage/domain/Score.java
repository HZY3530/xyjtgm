package com.xiaoyuanjiaotong.manage.domain;

import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 学法考试分数对象 score
 *
 * @author huhu
 * @date 2025-04-26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Score extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * id
     */
    private Long id;
    /**
     * 用户名
     */
    private Long userId;
    @Excel(name = "用户名")
    private String nickName;
    /**
     * 分数
     */
    @Excel(name = "分数")
    private Long score;
    /**
     * 分数
     */
    @Excel(name = "创建时间")
    private Date createtime;
}