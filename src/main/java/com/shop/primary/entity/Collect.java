package com.shop.primary.entity;

import javax.persistence.*;


@Entity
@Table(name = "collect", indexes = {@Index(name = "idx_customerId",columnList = "customer_id")})
public class Collect extends BaseEntity {

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

    @Override
    public String toString() {
        return "Collect{" +
                "customerId=" + customerId +
                ", goodsId=" + goodsId +
                "} " + super.toString();
    }
}
