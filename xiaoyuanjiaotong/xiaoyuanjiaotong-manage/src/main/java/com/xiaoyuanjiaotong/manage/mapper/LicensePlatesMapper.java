package com.xiaoyuanjiaotong.manage.mapper;

import java.util.List;
import com.xiaoyuanjiaotong.manage.domain.LicensePlates;
import org.apache.ibatis.annotations.Update;

/**
 * 车牌Mapper接口
 * 
 * @author huhu
 * @date 2025-03-10
 */
public interface LicensePlatesMapper 
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
     * 删除车牌
     * 
     * @param plateId 车牌主键
     * @return 结果
     */
    public int deleteLicensePlatesByPlateId(Long plateId);

    /**
     * 批量删除车牌
     * 
     * @param plateIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteLicensePlatesByPlateIds(Long[] plateIds);
}
