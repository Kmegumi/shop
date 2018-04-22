package com.shop.primary.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Table(name = "goods_column")
@Entity
public class GoodsColumn extends BaseEntity {

    @Column(name = "column_name")
    private String columnName;

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    @Override
    public String toString() {
        return "GoodsColumn{" +
                "columnName='" + columnName + '\'' +
                "} " + super.toString();
    }
}