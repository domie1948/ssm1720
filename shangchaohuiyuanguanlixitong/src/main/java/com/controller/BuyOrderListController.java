package com.controller;


import java.text.SimpleDateFormat;
import com.alibaba.fastjson.JSONObject;
import java.util.*;
import org.springframework.beans.BeanUtils;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;
import com.service.TokenService;
import com.utils.StringUtil;
import java.lang.reflect.InvocationTargetException;

import com.service.DictionaryService;
import org.apache.commons.lang3.StringUtils;
import com.annotation.IgnoreAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import com.entity.BuyOrderListEntity;

import com.service.BuyOrderListService;
import com.entity.view.BuyOrderListView;
import com.service.BuyOrderService;
import com.entity.BuyOrderEntity;
import com.service.GoodsService;
import com.entity.GoodsEntity;
import com.utils.PageUtils;
import com.utils.R;

/**
 * 购买订单详情
 * 后端接口
 * @author
 * @email
 * @date 2021-03-15
*/
@RestController
@Controller
@RequestMapping("/buyOrderList")
public class BuyOrderListController {
    private static final Logger logger = LoggerFactory.getLogger(BuyOrderListController.class);

    @Autowired
    private BuyOrderListService buyOrderListService;


    @Autowired
    private TokenService tokenService;
    @Autowired
    private DictionaryService dictionaryService;


    //级联表service
    @Autowired
    private BuyOrderService buyOrderService;
    @Autowired
    private GoodsService goodsService;


    /**
    * 后端列表
    */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, HttpServletRequest request){
        logger.debug("page方法:,,Controller:{},,params:{}",this.getClass().getName(),JSONObject.toJSONString(params));
        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isNotEmpty(role) && "用户".equals(role)){
            params.put("yonghuId",request.getSession().getAttribute("userId"));
        }
        PageUtils page = buyOrderListService.queryPage(params);

        //字典表数据转换
        List<BuyOrderListView> list =(List<BuyOrderListView>)page.getList();
        for(BuyOrderListView c:list){
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(c);
        }
        return R.ok().put("data", page);
    }
    /**
    * 后端详情
    */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        logger.debug("info方法:,,Controller:{},,id:{}",this.getClass().getName(),id);
        BuyOrderListEntity buyOrderList = buyOrderListService.selectById(id);
        if(buyOrderList !=null){
            //entity转view
            BuyOrderListView view = new BuyOrderListView();
            BeanUtils.copyProperties( buyOrderList , view );//把实体数据重构到view中

            //级联表
            BuyOrderEntity buyOrder = buyOrderService.selectOne(new EntityWrapper<BuyOrderEntity>().eq("order_bianhao",buyOrderList.getBuyOrderId()));
            if(buyOrder != null){
                BeanUtils.copyProperties( buyOrder , view ,new String[]{ "id", "createDate"});//把级联的数据添加到view中,并排除id和创建时间字段
                view.setBuyOrderId(buyOrder.getOrderBianhao());
            }
            //级联表
            GoodsEntity goods = goodsService.selectById(buyOrderList.getGoodsId());
            if(goods != null){
                BeanUtils.copyProperties( goods , view ,new String[]{ "id", "createDate"});//把级联的数据添加到view中,并排除id和创建时间字段
                view.setGoodsId(goods.getId());
            }
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(view);
            return R.ok().put("data", view);
        }else {
            return R.error(511,"查不到数据");
        }

    }

    /**
    * 后端保存
    */
    @RequestMapping("/save")
    public R save(@RequestBody BuyOrderListEntity buyOrderList, HttpServletRequest request){
        logger.debug("save方法:,,Controller:{},,buyOrderList:{}",this.getClass().getName(),buyOrderList.toString());
        Wrapper<BuyOrderListEntity> queryWrapper = new EntityWrapper<BuyOrderListEntity>()
            .eq("buy_order_id", buyOrderList.getBuyOrderId())
            .eq("goods_id", buyOrderList.getGoodsId())
            .eq("order_number", buyOrderList.getOrderNumber())
            ;
        logger.info("sql语句:"+queryWrapper.getSqlSegment());
        BuyOrderListEntity buyOrderListEntity = buyOrderListService.selectOne(queryWrapper);
        if(buyOrderListEntity==null){
            buyOrderList.setCreateTime(new Date());
        //  String role = String.valueOf(request.getSession().getAttribute("role"));
        //  if("".equals(role)){
        //      buyOrderList.set
        //  }
            buyOrderListService.insert(buyOrderList);
            return R.ok();
        }else {
            return R.error(511,"表中有相同数据");
        }
    }

    /**
    * 修改
    */
    @RequestMapping("/update")
    public R update(@RequestBody BuyOrderListEntity buyOrderList, HttpServletRequest request){
        logger.debug("update方法:,,Controller:{},,buyOrderList:{}",this.getClass().getName(),buyOrderList.toString());
        //根据字段查询是否有相同数据
        Wrapper<BuyOrderListEntity> queryWrapper = new EntityWrapper<BuyOrderListEntity>()
            .notIn("id",buyOrderList.getId())
            .eq("buy_order_id", buyOrderList.getBuyOrderId())
            .eq("goods_id", buyOrderList.getGoodsId())
            .eq("order_number", buyOrderList.getOrderNumber())
            ;
        logger.info("sql语句:"+queryWrapper.getSqlSegment());
        BuyOrderListEntity buyOrderListEntity = buyOrderListService.selectOne(queryWrapper);
        if(buyOrderListEntity==null){
            //  String role = String.valueOf(request.getSession().getAttribute("role"));
            //  if("".equals(role)){
            //      buyOrderList.set
            //  }
            buyOrderListService.updateById(buyOrderList);//根据id更新
            return R.ok();
        }else {
            return R.error(511,"表中有相同数据");
        }
    }


    /**
    * 删除
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
        logger.debug("delete:,,Controller:{},,ids:{}",this.getClass().getName(),ids.toString());
        buyOrderListService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }


}

