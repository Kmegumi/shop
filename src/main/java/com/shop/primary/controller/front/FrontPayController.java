package com.shop.primary.controller.front;

import com.shop.core.common.BaseController;
import com.shop.core.exception.ServiceException;
import com.shop.primary.entity.Customer;
import com.shop.primary.entity.Order;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.OrderService;
import com.shop.primary.service.PayService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Objects;

@Controller
@RequestMapping(value = "/front")
public class FrontPayController extends BaseController {

    private static final Logger logger = LoggerFactory.getLogger(FrontPayController.class);

    @Autowired
    private OrderService orderService;
    @Autowired
    private PayService payService;

    @RequestMapping(value = "payNow")
    @ResponseBody
    public ResultCodeVO payNow(String orderNum){
        Customer customer = getCustomerInfo();
        Order order = null;
        try {
            order = orderService.findByOrderNum(orderNum);
        } catch (Exception e) {
            logger.error(orderNum+"_"+e.getMessage(), e);
        }
        if (order == null) {
            return new ResultCodeVO("400", "付款失败");
        }
        if (!Objects.equals(order.getCustomerId(), customer.getId())) {
            return new ResultCodeVO("400", "付款失败, 他人订单");
        }
        try {
            payService.payOrder(order, customer.getId());
        } catch (ServiceException e) {
          return new ResultCodeVO("400", e.getMessage());
        } catch (Exception e) {
            logger.error(order.toString()+"_"+e.getMessage(), e);
            return new ResultCodeVO("400", "付款失败");
        }
        return new ResultCodeVO("200", order.getOrderNum());
    }


}
