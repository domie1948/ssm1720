package com.entity.view;

import com.entity.HuiyuanEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;

/**
 * 会员信息
 * 后端返回视图实体辅助类
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email
 * @date 2021-03-15
 */
@TableName("huiyuan")
public class HuiyuanView extends HuiyuanEntity implements Serializable {
    private static final long serialVersionUID = 1L;
		/**
		* 性别的值
		*/
		private String sexValue;
		/**
		* 政治面貌的值
		*/
		private String politicsValue;
		/**
		* 积分等级的值
		*/
		private String jifenValue;
		/**
		* 会员状态的值
		*/
		private String huiyuanValue;



	public HuiyuanView() {

	}

	public HuiyuanView(HuiyuanEntity huiyuanEntity) {
		try {
			BeanUtils.copyProperties(this, huiyuanEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
