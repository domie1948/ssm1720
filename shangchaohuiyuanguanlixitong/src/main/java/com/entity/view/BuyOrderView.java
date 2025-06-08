package com.entity.view;

import com.entity.BuyOrderEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;

/**
 * 购买订单
 * 后端返回视图实体辅助类
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email
 * @date 2021-03-15
 */
@TableName("buy_order")
public class BuyOrderView extends BuyOrderEntity implements Serializable {
    private static final long serialVersionUID = 1L;



		//级联表 huiyuan
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
				* 性别的值
				*/
				private String sexValue;
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
				* 政治面貌的值
				*/
				private String politicsValue;
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
				* 积分等级的值
				*/
				private String jifenValue;
			/**
			* 会员状态
			*/
			private Integer huiyuanTypes;
				/**
				* 会员状态的值
				*/
				private String huiyuanValue;

	public BuyOrderView() {

	}

	public BuyOrderView(BuyOrderEntity buyOrderEntity) {
		try {
			BeanUtils.copyProperties(this, buyOrderEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}















				//级联表的get和set huiyuan
					/**
					* 获取： 姓名
					*/
					public String getHuiyuanName() {
						return huiyuanName;
					}
					/**
					* 设置： 姓名
					*/
					public void setHuiyuanName(String huiyuanName) {
						this.huiyuanName = huiyuanName;
					}
					/**
					* 获取： 手机号
					*/
					public String getHuiyuanPhone() {
						return huiyuanPhone;
					}
					/**
					* 设置： 手机号
					*/
					public void setHuiyuanPhone(String huiyuanPhone) {
						this.huiyuanPhone = huiyuanPhone;
					}
					/**
					* 获取： 身份证号
					*/
					public String getHuiyuanIdNumber() {
						return huiyuanIdNumber;
					}
					/**
					* 设置： 身份证号
					*/
					public void setHuiyuanIdNumber(String huiyuanIdNumber) {
						this.huiyuanIdNumber = huiyuanIdNumber;
					}
					/**
					* 获取： 性别
					*/
					public Integer getSexTypes() {
						return sexTypes;
					}
					/**
					* 设置： 性别
					*/
					public void setSexTypes(Integer sexTypes) {
						this.sexTypes = sexTypes;
					}


						/**
						* 获取： 性别的值
						*/
						public String getSexValue() {
							return sexValue;
						}
						/**
						* 设置： 性别的值
						*/
						public void setSexValue(String sexValue) {
							this.sexValue = sexValue;
						}
					/**
					* 获取： 照片
					*/
					public String getHuiyuanPhoto() {
						return huiyuanPhoto;
					}
					/**
					* 设置： 照片
					*/
					public void setHuiyuanPhoto(String huiyuanPhoto) {
						this.huiyuanPhoto = huiyuanPhoto;
					}
					/**
					* 获取： 民族
					*/
					public String getNation() {
						return nation;
					}
					/**
					* 设置： 民族
					*/
					public void setNation(String nation) {
						this.nation = nation;
					}
					/**
					* 获取： 政治面貌
					*/
					public Integer getPoliticsTypes() {
						return politicsTypes;
					}
					/**
					* 设置： 政治面貌
					*/
					public void setPoliticsTypes(Integer politicsTypes) {
						this.politicsTypes = politicsTypes;
					}


						/**
						* 获取： 政治面貌的值
						*/
						public String getPoliticsValue() {
							return politicsValue;
						}
						/**
						* 设置： 政治面貌的值
						*/
						public void setPoliticsValue(String politicsValue) {
							this.politicsValue = politicsValue;
						}
					/**
					* 获取： 籍贯
					*/
					public String getBirthplace() {
						return birthplace;
					}
					/**
					* 设置： 籍贯
					*/
					public void setBirthplace(String birthplace) {
						this.birthplace = birthplace;
					}
					/**
					* 获取： 积分
					*/
					public Integer getJifen() {
						return jifen;
					}
					/**
					* 设置： 积分
					*/
					public void setJifen(Integer jifen) {
						this.jifen = jifen;
					}
					/**
					* 获取： 积分等级
					*/
					public Integer getJifenTypes() {
						return jifenTypes;
					}
					/**
					* 设置： 积分等级
					*/
					public void setJifenTypes(Integer jifenTypes) {
						this.jifenTypes = jifenTypes;
					}


						/**
						* 获取： 积分等级的值
						*/
						public String getJifenValue() {
							return jifenValue;
						}
						/**
						* 设置： 积分等级的值
						*/
						public void setJifenValue(String jifenValue) {
							this.jifenValue = jifenValue;
						}
					/**
					* 获取： 会员状态
					*/
					public Integer getHuiyuanTypes() {
						return huiyuanTypes;
					}
					/**
					* 设置： 会员状态
					*/
					public void setHuiyuanTypes(Integer huiyuanTypes) {
						this.huiyuanTypes = huiyuanTypes;
					}


						/**
						* 获取： 会员状态的值
						*/
						public String getHuiyuanValue() {
							return huiyuanValue;
						}
						/**
						* 设置： 会员状态的值
						*/
						public void setHuiyuanValue(String huiyuanValue) {
							this.huiyuanValue = huiyuanValue;
						}




}
