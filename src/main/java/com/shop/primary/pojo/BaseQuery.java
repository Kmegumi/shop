package com.shop.primary.pojo;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.time.LocalDateTime;

public class BaseQuery {

    private Integer pageNo;

    private Integer pageSize;

    private String name;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private String code;

    private String orderByClause;

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public Integer getPageNo() {
        if (pageNo == null) {
            return 0;
        }
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        if (pageSize == null) {
            return 10;
        }
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Long getFirstResult(){
        return (this.getPageNo() - 1L) * this.getPageSize();
    }

    public String getLimit(){
        return new StringBuilder("limit ")
                .append(this.getFirstResult())
                .append(",")
                .append(this.getPageSize())
                .toString();
    }

    public String getLimitWithOrder(String orderByClause){
        return new StringBuilder(orderByClause)
                .append(" limit ")
                .append(this.getFirstResult())
                .append(",")
                .append(this.getPageSize())
                .toString();
    }

    public Pageable getPageable(){
        return new PageRequest(getPageNo(), getPageSize());
    }

    @Override
    public String toString() {
        return "BaseQuery{" +
                "pageNo=" + pageNo +
                ", pageSize=" + pageSize +
                ", name='" + name + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", code='" + code + '\'' +
                ", orderByClause='" + orderByClause + '\'' +
                '}';
    }
}
