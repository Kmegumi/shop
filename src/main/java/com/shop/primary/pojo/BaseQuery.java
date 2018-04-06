package com.shop.primary.pojo;

/**
 * Created by Dell on 2017/8/9.
 */
public class BaseQuery {

    private Integer pageNo;

    private Integer pageSize;

    private String name;

    private String startDate;

    private String endDate;

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
            return 1;
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

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getFirstResult(){
        return (this.getPageNo() - 1) * this.getPageSize();
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

    @Override
    public String toString() {
        return "BaseQuery{" +
                "pageNo=" + pageNo +
                ", pageSize=" + pageSize +
                ", name='" + name + '\'' +
                ", startDate='" + startDate + '\'' +
                ", endDate='" + endDate + '\'' +
                ", code='" + code + '\'' +
                ", orderByClause='" + orderByClause + '\'' +
                '}';
    }
}
