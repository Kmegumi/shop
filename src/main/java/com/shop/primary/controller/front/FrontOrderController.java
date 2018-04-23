package com.shop.primary.controller.front;

import com.shop.core.common.BaseController;
import com.shop.core.exception.ServiceException;
import com.shop.core.utils.NumUtil;
import com.shop.primary.entity.Customer;
import com.shop.primary.entity.Goods;
import com.shop.primary.entity.Order;
import com.shop.primary.enums.OrderStatusEnum;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.GoodsService;
import com.shop.primary.service.OrderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;

@RequestMapping(value = "/front")
@Controller
public class FrontOrderController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(FrontOrderController.class);

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private OrderService orderService;

    @RequestMapping("checkOrder")
    public String checkOrder(Long goodsId, Integer goodsNum, ModelMap modelMap){
        checkCustomerInfo();
        Goods goods = goodsService.getById(goodsId);
        if (goods == null) {
            return "redirect:/rest/front/notExists";
        }
        modelMap.addAttribute("goods", goods);
        modelMap.addAttribute("goodsNum", goodsNum);
        return "front/order/checkOrder";
    }

    @RequestMapping("submitOrder")
    @ResponseBody
    public ResultCodeVO submitOrder(Order order) {
        Customer customer = checkCustomerInfo();
        order.setCustomerId(customer.getId());
        Goods goods = goodsService.getById(order.getGoodsId());
        if (order.getGoodsNum() > goods.getSortNum()) {
            return new ResultCodeVO("400", "库存不足");
        }
        order.setGoodsMoney(goods.getGoodsPrice());
        order.setOrderStatusEnum(OrderStatusEnum.PAY_WAIT);
        order.setGoodsTotalMoney(goods.getGoodsPrice().multiply(new BigDecimal(order.getGoodsNum())));
        order.setOrderNum(NumUtil.createDateNo());
        try {
            order = orderService.createOrder(order);
        } catch (ServiceException e) {
            return new ResultCodeVO("400", e.getMessage());
        } catch (Exception e) {
            logger.error(order.toString() + "_" + e.getMessage(), e);
            return new ResultCodeVO("400", "未知错误！");
        }
        return new ResultCodeVO("200", order.getOrderNum());
    }

    @RequestMapping("orderDetail")
    public String orderDetail(String orderNum, ModelMap modelMap){
        checkCustomerInfo();
        modelMap.addAttribute("order", orderService.findByOrderNum(orderNum));
        return "front/order/orderDetail";
    }

    @RequestMapping(value = "cancelOrder")
    @ResponseBody
    public ResultCodeVO cancelOrder(Long orderId, String cancelCause){
        checkCustomerInfo();
        try {
            Order order = orderService.getById(orderId);
            order.setOrderStatusEnum(OrderStatusEnum.CLOSE);
            order.setCancelMessage(cancelCause);
            orderService.update(order);
            return ResultCodeVO.LOGIN_SUCCESS;
        } catch (Exception e) {
            logger.error(orderId+"_"+cancelCause+"_"+e.getMessage(), e);
        }
        return new ResultCodeVO("400", "取消失败");
    }

}
