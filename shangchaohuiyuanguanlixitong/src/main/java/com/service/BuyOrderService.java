package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.BuyOrderEntity;
import java.util.Map;

/**
 * 购买订单 服务类
 * @author 
 * @since 2021-03-15
 */
public interface BuyOrderService extends IService<BuyOrderEntity> {

    /**
    * @param params 查询参数
    * @return 带分页的查询出来的数据
    */
     PageUtils queryPage(Map<String, Object> params);

}