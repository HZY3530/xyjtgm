package com.xiaoyuanjiaotong.manage.domain;

import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 志愿信息对象 volunteer_services
 *
 * @author huhu
 * @date 2025-03-10
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VolunteerServices extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 志愿ID
     */
    private Long serviceId;
    /**
     * 志愿者ID
     */
    @Excel(name = "志愿者ID")
    private Long userId;
    /**
     * 用户
     */
    @Excel(name = "昵称")
    private String nickName;
    /**
     * 车牌id
     */
    private Long plateId;
    /**
     * 车牌号
     */
    @Excel(name = "车牌号")
    private String plateNumber;
    /**
     * 志愿地点
     */
    @Excel(name = "志愿地点")
    private String serviceLocation;
    /**
     * 描述
     */
    @Excel(name = "描述")
    private String description;
    /**
     * 处理状态
     */
    @Excel(name = "处理状态")
    private String status;
    /**
     * 加分分数
     */
    private int score;
}