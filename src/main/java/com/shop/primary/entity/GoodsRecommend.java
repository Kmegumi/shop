package com.shop.primary.entity;

import javax.persistence.*;

@Entity
@Table(name = "goods_recommend")
public class GoodsRecommend extends BaseEntity {

    @Column(name = "goods_id", unique = true)
    private Long goodsId;

    /**推荐商品*/
    @ManyToOne(targetEntity = Goods.class, optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "goods_id", updatable = false, insertable = false)
    private Goods goods;

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

    @Override
    public String toString() {
        return "GoodsRecommend{" +
                "goodsId=" + goodsId +
                "} " + super.toString();
    }
}
