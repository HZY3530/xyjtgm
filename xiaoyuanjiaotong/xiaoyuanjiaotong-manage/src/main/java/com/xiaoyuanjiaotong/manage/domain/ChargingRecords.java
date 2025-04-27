package com.xiaoyuanjiaotong.manage.domain;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.xiaoyuanjiaotong.common.annotation.Excel;
import com.xiaoyuanjiaotong.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 充电记录对象 charging_records
 *
 * @author huhu
 * @date 2025-03-10
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChargingRecords extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * 记录ID
     */
    private Long recordId;
    /**
     * 用户ID
     */
    @Excel(name = "用户ID")
    private Long userId;
    /**
     * 用户ID
     */
    @Excel(name = "用户昵称")
    private String nickName;
    /**
     * 车牌ID
     */
    @Excel(name = "车牌ID")
    private Long plateId;
    /**
     * 车牌ID
     */
    @Excel(name = "车牌号")
    private String plateNumber;
    /**
     * 结束时间
     */
    @JsonFormat(pattern =  "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat =  "yyyy-MM-dd HH:mm:ss")
    private Date endTime;
    /**
     * 费用
     */
    @Excel(name = "费用")
    private BigDecimal fee;
    /**
     * 处理状态
     */
    @Excel(name = "处理状态")
    private String status;
}