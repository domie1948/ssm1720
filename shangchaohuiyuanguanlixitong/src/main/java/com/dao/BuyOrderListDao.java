package com.dao;

import com.entity.BuyOrderListEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.BuyOrderListView;

/**
 * 购买订单详情 Dao 接口
 *
 * @author 
 * @since 2021-03-15
 */
public interface BuyOrderListDao extends BaseMapper<BuyOrderListEntity> {

   List<BuyOrderListView> selectListView(Pagination page,@Param("params")Map<String,Object> params);

}
