package com.service.impl;

import com.utils.StringUtil;
import org.springframework.stereotype.Service;
import java.lang.reflect.Field;
import java.util.*;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import com.utils.PageUtils;
import com.utils.Query;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;

import com.dao.BuyOrderDao;
import com.entity.BuyOrderEntity;
import com.service.BuyOrderService;
import com.entity.view.BuyOrderView;

/**
 * 购买订单 服务实现类
 * @author 
 * @since 2021-03-15
 */
@Service("buyOrderService")
@Transactional
public class BuyOrderServiceImpl extends ServiceImpl<BuyOrderDao, BuyOrderEntity> implements BuyOrderService {

    @Override
    public PageUtils queryPage(Map<String,Object> params) {
        if(params != null && (params.get("limit") == null || params.get("page") == null)){
            params.put("page","1");
            params.put("limit","10");
        }
        Page<BuyOrderView> page =new Query<BuyOrderView>(params).getPage();
        page.setRecords(baseMapper.selectListView(page,params));
        return new PageUtils(page);
    }


}
