package com.shop.primary.pojo.vo;

import java.util.List;

/**
 * Created by Dell on 2017/8/9.
 */
public class RowBoundVO<T> {

    private Integer pageNo;
    private Integer pageSize;
    private Integer firstResult;
    private Integer totalCount;
    private Integer totalPageNum;
    private List<T> list;


    public RowBoundVO() {
    }


    public RowBoundVO(Integer pageNo, Integer pageSize, Integer firstResult, Integer totalCount, Integer totalPageNum) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.firstResult = firstResult;
        this.totalCount = totalCount;
        this.totalPageNum = totalPageNum;
    }

    public RowBoundVO(Integer pageNo, Integer pageSize, Integer totalCount, Integer totalPageNum, Integer firstResult, List<T> list) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.totalPageNum = totalPageNum;
        this.firstResult = firstResult;
        this.list = list;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public Integer getTotalPageNum() {
        return totalPageNum;
    }

    public Integer getFirstResult() {
        return firstResult;
    }

    public List<T> getList() {
        return list;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public void setFirstResult(Integer firstResult) {
        this.firstResult = firstResult;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    public void setTotalPageNum(Integer totalPageNum) {
        this.totalPageNum = totalPageNum;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
