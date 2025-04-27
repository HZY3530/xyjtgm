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
 * 充电桩对象 chargingstations
 *
 * @author huhu
 * @date 2025-04-26
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Chargingstations extends BaseEntity {
    private static final long serialVersionUID = 1L;
    /**
     * id
     */
    private Long stationID;
    /**
     * 名字
     */
    @Excel(name = "名字")
    private String stationName;
    /**
     * 位置
     */
    @Excel(name = "位置")
    private String location;
    /**
     * 安装时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "安装时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date installDate;
    /**
     * 费用
     */
    @Excel(name = "费用")
    private BigDecimal feeStandard;
}