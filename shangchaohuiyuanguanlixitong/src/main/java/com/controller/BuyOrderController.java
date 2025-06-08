package com.controller;


import java.text.SimpleDateFormat;
import com.alibaba.fastjson.JSONObject;
import java.util.*;

import com.entity.*;
import com.service.*;
import org.springframework.beans.BeanUtils;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;

import com.utils.StringUtil;
import java.lang.reflect.InvocationTargetException;

import org.apache.commons.lang3.StringUtils;
import com.annotation.IgnoreAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import com.entity.view.BuyOrderView;
import com.utils.PageUtils;
import com.utils.R;

/**
 * 购买订单
 * 后端接口
 * @author
 * @email
 * @date 2021-03-15
*/
@RestController
@Controller
@RequestMapping("/buyOrder")
public class BuyOrderController {
    private static final Logger logger = LoggerFactory.getLogger(BuyOrderController.class);

    @Autowired
    private BuyOrderService buyOrderService;


    @Autowired
    private TokenService tokenService;
    @Autowired
    private DictionaryService dictionaryService;


    //级联表service
    @Autowired
    private HuiyuanService huiyuanService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private BuyOrderListService buyOrderListService;
//    @Autowired
//    private YonghuService yonghuService;


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
        PageUtils page = buyOrderService.queryPage(params);

        //字典表数据转换
        List<BuyOrderView> list =(List<BuyOrderView>)page.getList();
        for(BuyOrderView c:list){
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
        BuyOrderEntity buyOrder = buyOrderService.selectById(id);
        if(buyOrder !=null){
            //entity转view
            BuyOrderView view = new BuyOrderView();
            BeanUtils.copyProperties( buyOrder , view );//把实体数据重构到view中

            //级联表
            HuiyuanEntity huiyuan = huiyuanService.selectById(buyOrder.getHuiyuanId());
            if(huiyuan != null){
                BeanUtils.copyProperties( huiyuan , view ,new String[]{ "id", "createDate"});//把级联的数据添加到view中,并排除id和创建时间字段
                view.setHuiyuanId(huiyuan.getId());
            }
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(view);
            return R.ok().put("data", view);
        }else {
            return R.error(511,"查不到数据");
        }

    }

    /**
     * 购买商品
     */
    @RequestMapping("/buyOrder")
    public R outGoods(@RequestBody  Map<String, Object> params,HttpServletRequest request){
        logger.debug("buyOrder方法:,,Controller:{},,params:{}",this.getClass().getName(),JSONObject.toJSONString(params));

        String role = String.valueOf(request.getSession().getAttribute("role"));

        Date d = new Date();
        if("用户".equals(role)){
            Map<String, Integer> map = (Map<String, Integer>) params.get("map");
            Set<String> strings = map.keySet();
            List<GoodsEntity> list = goodsService.selectBatchIds(strings);
            Double originalMoneySum =0.0;
            for(GoodsEntity g:list ){
                Integer goodsNumber = g.getGoodsNumber();
                Integer buyNumber = map.get(String.valueOf(g.getId()));
                if(goodsNumber - buyNumber <0){
                    return R.error(g.getGoodsName()+"的购买数量不能超过库存数量");
                }
                g.setGoodsNumber(goodsNumber - buyNumber);
                originalMoneySum+=(g.getDanjia() * buyNumber);
            }


            HuiyuanEntity huiyuanEntity = huiyuanService.selectById(1);
            if(huiyuanEntity == null){
                return R.error("查不到此会员");
            }else{
                // 更新会员信息
                Integer oldJifen = huiyuanEntity.getJifen();
                Double ceil = Math.ceil(originalMoneySum / 10);
                Integer newJifen = oldJifen + ceil.intValue();
                huiyuanEntity.setJifen(newJifen);
                if(newJifen>10000){
                    huiyuanEntity.setJifenTypes(1);//钻石会员
                }else if(newJifen>1000){
                    huiyuanEntity.setJifenTypes(2);//黄金会员
                }else if(newJifen>100){
                    huiyuanEntity.setJifenTypes(3);//白银会员
                }else{
                    huiyuanEntity.setJifenTypes(4);//青铜会员
                }
                huiyuanService.updateById(huiyuanEntity);

                // 新增订单信息
                BuyOrderEntity buyOrder = new BuyOrderEntity();
                buyOrder.setOriginalMoney(originalMoneySum);
                Integer jifenTypes = huiyuanEntity.getJifenTypes();
                if(jifenTypes == 1 ){
                    buyOrder.setDiscountMoney(originalMoneySum * 0.8);
                }else if(jifenTypes == 2 ){
                    buyOrder.setDiscountMoney(originalMoneySum * 0.85);
                }else if(jifenTypes == 3 ){
                    buyOrder.setDiscountMoney(originalMoneySum * 0.9);
                }else if(jifenTypes == 4 ){
                    buyOrder.setDiscountMoney(originalMoneySum * 0.95);
                }
                String bianhao = String.valueOf(d.getTime() + (int) (Math.random() * 6));
                buyOrder.setOrderBianhao(bianhao);
                buyOrder.setCaozuoName(String.valueOf(request.getSession().getAttribute("username")));
                buyOrder.setCaozuoTable("yonghu");
                buyOrder.setHuiyuanId(huiyuanEntity.getId());
                buyOrder.setInsertTime(d);
                buyOrder.setCreateTime(d);
                buyOrderService.insert(buyOrder);

                //新增订单详情信息
                ArrayList<BuyOrderListEntity> l = new ArrayList<>();
                for(String s:strings){
                    BuyOrderListEntity buyOrderListEntity = new BuyOrderListEntity();
                    buyOrderListEntity.setCreateTime(d);
                    buyOrderListEntity.setBuyOrderId(bianhao);
                    buyOrderListEntity.setGoodsId(Integer.valueOf(s));
                    buyOrderListEntity.setOrderNumber(map.get(s));
                    buyOrderListEntity.setCreateTime(d);
                    l.add(buyOrderListEntity);
                }
                buyOrderListService.insertBatch(l);
                goodsService.updateBatchById(list);

            }
        }else{
            return R.error("您没有权限操作订单");
        }
        return R.ok();
    }
    /**
    * 删除
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
        logger.debug("delete:,,Controller:{},,ids:{}",this.getClass().getName(),ids.toString());
        List<BuyOrderEntity> list = buyOrderService.selectList(new EntityWrapper<BuyOrderEntity>().in("id", ids));
        buyOrderService.deleteBatchIds(Arrays.asList(ids));
        List<String> BuyOrderIds = new ArrayList<>();
        for(BuyOrderEntity order:list){
            BuyOrderIds.add(order.getOrderBianhao());
        }
        if(BuyOrderIds != null && BuyOrderIds.size()>0){
            buyOrderListService.delete(new EntityWrapper<BuyOrderListEntity>().in("buy_order_id", BuyOrderIds));
        }
        return R.ok();
    }


}

