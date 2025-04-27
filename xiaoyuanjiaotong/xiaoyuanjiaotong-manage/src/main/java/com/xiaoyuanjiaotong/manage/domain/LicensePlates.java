package com.xiaoyuanjiaotong.manage.domain;

import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 车牌对象 license_plates
 *
 * @author huhu
 * @date 2025-03-10
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LicensePlates extends BaseEntity {
    private static final long serialVersionUID = 1L;
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
     * 用户
     */
    @Excel(name = "用户")
    private Long userId;
    /**
     * 用户
     */
    @Excel(name = "昵称")
    private String nickName;
    /**
     * 车辆类型
     */
    @Excel(name = "车辆类型")
    private String vehicleType;
    /**
     * 车牌分数
     */
    private int score;


}