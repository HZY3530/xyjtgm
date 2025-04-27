package com.xiaoyuanjiaotong.manage.service;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.LicensePlates;

/**
 * 车牌Service接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface ILicensePlatesService 
{
    /**
     * 查询车牌
     * 
     * @param plateId 车牌主键
     * @return 车牌
     */
    public LicensePlates selectLicensePlatesByPlateId(Long plateId);

    /**
     * 查询车牌列表
     * 
     * @param licensePlates 车牌
     * @return 车牌集合
     */
    public List<LicensePlates> selectLicensePlatesList(LicensePlates licensePlates);

    /**
     * 新增车牌
     * 
     * @param licensePlates 车牌
     * @return 结果
     */
    public int insertLicensePlates(LicensePlates licensePlates);

    /**
     * 修改车牌
     * 
     * @param licensePlates 车牌
     * @return 结果
     */
    public int updateLicensePlates(LicensePlates licensePlates);

    /**
     * 批量删除车牌
     * 
     * @param plateIds 需要删除的车牌主键集合
     * @return 结果
     */
    public int deleteLicensePlatesByPlateIds(Long[] plateIds);

    /**
     * 删除车牌信息
     * 
     * @param plateId 车牌主键
     * @return 结果
     */
    public int deleteLicensePlatesByPlateId(Long plateId);
}
