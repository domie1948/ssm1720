package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.BuyOrderListEntity;
import java.util.Map;

/**
 * 购买订单详情 服务类
 * @author 
 * @since 2021-03-15
 */
public interface BuyOrderListService extends IService<BuyOrderListEntity> {

    /**
    * @param params 查询参数
    * @return 带分页的查询出来的数据
    */
     PageUtils queryPage(Map<String, Object> params);

}