package com.shop.primary.pojo.vo;

import java.util.List;

/**
 * Created by Dell on 2017/8/9.
 */
public class RowBoundVO<T> {

    private Long pageNo;
    private Long pageSize;
    private Long firstResult;
    private Long totalCount;
    private Long totalPageNum;
    private List<T> list;


    public RowBoundVO() {
    }


    public RowBoundVO(Long pageNo, Long pageSize, Long firstResult, Long totalCount, Long totalPageNum) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.firstResult = firstResult;
        this.totalCount = totalCount;
        this.totalPageNum = totalPageNum;
    }

    public RowBoundVO(Long pageNo, Long pageSize, Long totalCount, Long totalPageNum, Long firstResult, List<T> list) {
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.totalPageNum = totalPageNum;
        this.firstResult = firstResult;
        this.list = list;
    }

    public Long getPageNo() {
        return pageNo;
    }

    public Long getPageSize() {
        return pageSize;
    }

    public Long getTotalCount() {
        return totalCount;
    }

    public Long getTotalPageNum() {
        return totalPageNum;
    }

    public Long getFirstResult() {
        return firstResult;
    }

    public List<T> getList() {
        return list;
    }

    public void setPageNo(Long pageNo) {
        this.pageNo = pageNo;
    }

    public void setPageSize(Long pageSize) {
        this.pageSize = pageSize;
    }

    public void setFirstResult(Long firstResult) {
        this.firstResult = firstResult;
    }

    public void setTotalCount(Long totalCount) {
        this.totalCount = totalCount;
    }

    public void setTotalPageNum(Long totalPageNum) {
        this.totalPageNum = totalPageNum;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
