package com.xiaoyuanjiaotong.manage.domain;

import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 举报信息对象 reports
 *
 * @author huhu
 * @date 2025-03-10
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Reports extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 举报记录ID
     */
    private Long reportId;
    /**
     * 举报人ID
     */
    @Excel(name = "举报人ID")
    private Long userId;
    /**
     * 用户
     */
    @Excel(name = "昵称")
    private String nickName;
    /**
     * 违规车牌ID
     */
    @Excel(name = "违规车牌ID")
    private Long plateId;
    /**
     * 车牌号
     */
    @Excel(name = "车牌号")
    private String plateNumber;
    /**
     * 举报内容
     */
    @Excel(name = "举报内容")
    private String reportContent;
    /**
     * 处理状态
     */
    @Excel(name = "处理状态")
    private String status;
    /**
     * 处理状态
     */
    @Excel(name = "分值")
    private int score;
}