package com.xiaoyuanjiaotong.manage.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 志愿岗位对象 volunteer_positions
 *
 * @author huhu
 * @date 2025-04-26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VolunteerPositions extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 志愿岗位ID
     */
    private Long volunteerPositionId;
    /**
     * 岗位类型
     */
    @Excel(name = "岗位类型")
    private String positionType;
    /**
     * 志愿地点
     */
    @Excel(name = "志愿地点")
    private String volunteerLocation;
    /**
     * 工作内容
     */
    @Excel(name = "工作内容")
    private String jobContent;
    /**
     * 截止时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "截止时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date deadline;
    /**
     * 当前人数
     */
    @Excel(name = "当前人数")
    private Long currentNumber;
    /**
     * 所需人数
     */
    @Excel(name = "所需人数")
    private Long requiredNumber;
    /**
     * 岗位状态
     */
    @Excel(name = "岗位状态")
    private String positionStatus;
}