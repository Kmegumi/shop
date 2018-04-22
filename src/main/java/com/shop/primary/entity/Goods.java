package com.shop.primary.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.time.LocalDateTime;

@Entity
@Table(name = "goods")
public class Goods extends BaseEntity {

    @Column(name = "column_id")
    private Long columnId;

    @ManyToOne(targetEntity= GoodsColumn.class ,fetch = FetchType.LAZY)
    @JoinColumn(name="column_id", updatable=false, insertable=false)
    private GoodsColumn goodsColumn;

    @Column(name = "goods_code")
    private String goodsCode;

    @Column(name = "goods_name")
    private String goodsName;

    @Column(name = "goods_intro")
    private String goodsIntro;

    @Column(name = "goods_img")
    private String goodsImg;

    @Column(name = "goods_price")
    private BigDecimal goodsPrice;

    @Column(name = "goods_stock")
    private Integer goodsStock;

    @Column(name = "start_time")
    @JSONField(format = "yyyy/MM/dd HH:mm")
    private LocalDateTime startTime;

    @Column(name = "sort_num")
    private Integer sortNum;

    @Column(name = "goods_info")
    private String goodsInfo;

    @Column(name = "create_user_id")
    private Long createUserId;

    @Column(name = "last_update_user_id")
    private Long lastUpdateUserId;

    @ManyToOne(targetEntity=User.class ,fetch = FetchType.LAZY)
    @JoinColumn(name="create_user_id", updatable=false, insertable=false)
    private User createUser;

    @ManyToOne(targetEntity=User.class,cascade= CascadeType.REFRESH,fetch = FetchType.LAZY)
    @JoinColumn(name="last_update_user_id", updatable = false, insertable = false)
    private User lastUpdateUser;

    public Long getColumnId() {
        return columnId;
    }

    public void setColumnId(Long columnId) {
        this.columnId = columnId;
    }

    public GoodsColumn getGoodsColumn() {
        return goodsColumn;
    }

    public void setGoodsColumn(GoodsColumn goodsColumn) {
        this.goodsColumn = goodsColumn;
    }

    public String getGoodsCode() {
        return goodsCode;
    }

    public void setGoodsCode(String goodsCode) {
        this.goodsCode = goodsCode;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsIntro() {
        return goodsIntro;
    }

    public void setGoodsIntro(String goodsIntro) {
        this.goodsIntro = goodsIntro;
    }

    public String getGoodsImg() {
        return goodsImg;
    }

    public void setGoodsImg(String goodsImg) {
        this.goodsImg = goodsImg;
    }

    public BigDecimal getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(BigDecimal goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public Integer getGoodsStock() {
        return goodsStock;
    }

    public void setGoodsStock(Integer goodsStock) {
        this.goodsStock = goodsStock;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    public String getGoodsInfo() {
        return goodsInfo;
    }

    public String getEncoderGoodsInfo(){
        try {
            return URLEncoder.encode(goodsInfo, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return "";
        }
    }

    public void setGoodsInfo(String goodsInfo) {
        this.goodsInfo = goodsInfo;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public Long getLastUpdateUserId() {
        return lastUpdateUserId;
    }

    public void setLastUpdateUserId(Long lastUpdateUserId) {
        this.lastUpdateUserId = lastUpdateUserId;
    }

    public User getCreateUser() {
        return createUser;
    }

    public void setCreateUser(User createUser) {
        this.createUser = createUser;
    }

    public User getLastUpdateUser() {
        return lastUpdateUser;
    }

    public void setLastUpdateUser(User lastUpdateUser) {
        this.lastUpdateUser = lastUpdateUser;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "columnId=" + columnId +
                ", goodsCode='" + goodsCode + '\'' +
                ", goodsName='" + goodsName + '\'' +
                ", goodsIntro='" + goodsIntro + '\'' +
                ", goodsImg='" + goodsImg + '\'' +
                ", goodsPrice=" + goodsPrice +
                ", goodsStock=" + goodsStock +
                ", startTime=" + startTime +
                ", sortNum=" + sortNum +
                ", goodsInfo='" + goodsInfo + '\'' +
                ", createUserId=" + createUserId +
                ", lastUpdateUserId=" + lastUpdateUserId +
                "} " + super.toString();
    }
}