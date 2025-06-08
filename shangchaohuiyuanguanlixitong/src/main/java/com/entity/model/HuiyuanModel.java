package com.entity.model;

import com.entity.HuiyuanEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import java.io.Serializable;


/**
 * 会员信息
 * 接收传参的实体类
 *（实际开发中配合移动端接口开发手动去掉些没用的字段， 后端一般用entity就够用了）
 * 取自ModelAndView 的model名称
 * @author 
 * @email
 * @date 2021-03-15
 */
public class HuiyuanModel implements Serializable {
    private static final long serialVersionUID = 1L;




    /**
     * 主键
     */
    private Integer id;


    /**
     * 姓名
     */
    private String huiyuanName;


    /**
     * 手机号
     */
    private String huiyuanPhone;


    /**
     * 身份证号
     */
    private String huiyuanIdNumber;


    /**
     * 性别
     */
    private Integer sexTypes;


    /**
     * 照片
     */
    private String huiyuanPhoto;


    /**
     * 民族
     */
    private String nation;


    /**
     * 政治面貌
     */
    private Integer politicsTypes;


    /**
     * 籍贯
     */
    private String birthplace;


    /**
     * 积分
     */
    private Integer jifen;


    /**
     * 积分等级
     */
    private Integer jifenTypes;


    /**
     * 会员状态
     */
    private Integer huiyuanTypes;


    /**
     * 创建时间
     */
    @JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
    private Date createTime;


    /**
	 * 获取：主键
	 */
    public Integer getId() {
        return id;
    }


    /**
	 * 设置：主键
	 */
    public void setId(Integer id) {
        this.id = id;
    }
    /**
	 * 获取：姓名
	 */
    public String getHuiyuanName() {
        return huiyuanName;
    }


    /**
	 * 设置：姓名
	 */
    public void setHuiyuanName(String huiyuanName) {
        this.huiyuanName = huiyuanName;
    }
    /**
	 * 获取：手机号
	 */
    public String getHuiyuanPhone() {
        return huiyuanPhone;
    }


    /**
	 * 设置：手机号
	 */
    public void setHuiyuanPhone(String huiyuanPhone) {
        this.huiyuanPhone = huiyuanPhone;
    }
    /**
	 * 获取：身份证号
	 */
    public String getHuiyuanIdNumber() {
        return huiyuanIdNumber;
    }


    /**
	 * 设置：身份证号
	 */
    public void setHuiyuanIdNumber(String huiyuanIdNumber) {
        this.huiyuanIdNumber = huiyuanIdNumber;
    }
    /**
	 * 获取：性别
	 */
    public Integer getSexTypes() {
        return sexTypes;
    }


    /**
	 * 设置：性别
	 */
    public void setSexTypes(Integer sexTypes) {
        this.sexTypes = sexTypes;
    }
    /**
	 * 获取：照片
	 */
    public String getHuiyuanPhoto() {
        return huiyuanPhoto;
    }


    /**
	 * 设置：照片
	 */
    public void setHuiyuanPhoto(String huiyuanPhoto) {
        this.huiyuanPhoto = huiyuanPhoto;
    }
    /**
	 * 获取：民族
	 */
    public String getNation() {
        return nation;
    }


    /**
	 * 设置：民族
	 */
    public void setNation(String nation) {
        this.nation = nation;
    }
    /**
	 * 获取：政治面貌
	 */
    public Integer getPoliticsTypes() {
        return politicsTypes;
    }


    /**
	 * 设置：政治面貌
	 */
    public void setPoliticsTypes(Integer politicsTypes) {
        this.politicsTypes = politicsTypes;
    }
    /**
	 * 获取：籍贯
	 */
    public String getBirthplace() {
        return birthplace;
    }


    /**
	 * 设置：籍贯
	 */
    public void setBirthplace(String birthplace) {
        this.birthplace = birthplace;
    }
    /**
	 * 获取：积分
	 */
    public Integer getJifen() {
        return jifen;
    }


    /**
	 * 设置：积分
	 */
    public void setJifen(Integer jifen) {
        this.jifen = jifen;
    }
    /**
	 * 获取：积分等级
	 */
    public Integer getJifenTypes() {
        return jifenTypes;
    }


    /**
	 * 设置：积分等级
	 */
    public void setJifenTypes(Integer jifenTypes) {
        this.jifenTypes = jifenTypes;
    }
    /**
	 * 获取：会员状态
	 */
    public Integer getHuiyuanTypes() {
        return huiyuanTypes;
    }


    /**
	 * 设置：会员状态
	 */
    public void setHuiyuanTypes(Integer huiyuanTypes) {
        this.huiyuanTypes = huiyuanTypes;
    }
    /**
	 * 获取：创建时间
	 */
    public Date getCreateTime() {
        return createTime;
    }


    /**
	 * 设置：创建时间
	 */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    }
