package com.dao;

import com.entity.BuyOrderEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.BuyOrderView;

/**
 * 购买订单 Dao 接口
 *
 * @author 
 * @since 2021-03-15
 */
public interface BuyOrderDao extends BaseMapper<BuyOrderEntity> {

   List<BuyOrderView> selectListView(Pagination page,@Param("params")Map<String,Object> params);

}
