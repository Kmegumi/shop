package com.shop.primary.entity;

import com.shop.primary.enums.OrderStatusEnum;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;


@Entity
@Table(name = "goods_order", indexes = {@Index(name = "idx_userId",columnList = "customer_id"),
        @Index(columnList = "order_num", name = "uk_order_num", unique = true)
})
public class Order extends BaseEntity {

    @Column(name = "customer_id")
    private Long customerId;

    @Column(name = "goods_id")
    private Long goodsId;

    @ManyToOne(targetEntity = Goods.class, optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "goods_id", updatable=false, nullable = false, insertable = false)
    private Goods goods;

    @ManyToOne(targetEntity = Customer.class, optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id", updatable=false, nullable = false, insertable = false)
    private Customer customer;

    /**订单编号*/
    @Column(name = "order_num", length = 32)
    private String orderNum;

    /**订单状态*/
    @Enumerated(EnumType.STRING)
    @Column(name = "order_status", length = 30, nullable = false)
    private OrderStatusEnum orderStatusEnum;

    /**订单中规格数量*/
    @Column(name = "goods_num")
    private Integer goodsNum;

    /**商品价格*/
    @Column(name = "goods_money", columnDefinition = "decimal(10,2)")
    private BigDecimal goodsMoney;

    /**商品总价格*/
    @Column(name = "goods_total_money", columnDefinition = "decimal(10,2)")
    private BigDecimal goodsTotalMoney;

    /**订单留言*/
    @Column(name = "order_message")
    private String message;

    /**收货详情*/
    @Column(name = "shipping_detail")
    private String shippingDetail;

    /**付款时间*/
    @Column(name = "pay_time")
    private LocalDateTime payTime;

    public Long getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Long customerId) {
        this.customerId = customerId;
    }

    public Long getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Long goodsId) {
        this.goodsId = goodsId;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public OrderStatusEnum getOrderStatusEnum() {
        return orderStatusEnum;
    }

    public void setOrderStatusEnum(OrderStatusEnum orderStatusEnum) {
        this.orderStatusEnum = orderStatusEnum;
    }

    public Integer getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(Integer goodsNum) {
        this.goodsNum = goodsNum;
    }

    public BigDecimal getGoodsMoney() {
        return goodsMoney;
    }

    public void setGoodsMoney(BigDecimal goodsMoney) {
        this.goodsMoney = goodsMoney;
    }

    public BigDecimal getGoodsTotalMoney() {
        return goodsTotalMoney;
    }

    public void setGoodsTotalMoney(BigDecimal goodsTotalMoney) {
        this.goodsTotalMoney = goodsTotalMoney;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getShippingDetail() {
        return shippingDetail;
    }

    public void setShippingDetail(String shippingDetail) {
        this.shippingDetail = shippingDetail;
    }

    public LocalDateTime getPayTime() {
        return payTime;
    }

    public void setPayTime(LocalDateTime payTime) {
        this.payTime = payTime;
    }

    @Override
    public String toString() {
        return "Order{" +
                "customerId=" + customerId +
                ", goodsId=" + goodsId +
                ", orderNum='" + orderNum + '\'' +
                ", orderStatusEnum=" + orderStatusEnum +
                ", goodsNum=" + goodsNum +
                ", goodsMoney=" + goodsMoney +
                ", goodsTotalMoney=" + goodsTotalMoney +
                ", message='" + message + '\'' +
                ", shippingDetail='" + shippingDetail + '\'' +
                ", payTime=" + payTime +
                "} " + super.toString();
    }
}
