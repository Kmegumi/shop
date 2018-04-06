package com.shop.core.common;

import com.shop.core.exception.DAOException;
import com.shop.core.utils.PageUtils;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.RowBoundVO;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import javax.annotation.Resource;
import java.util.List;


public class BaseDao<T> extends SqlSessionDaoSupport {

    @Resource
    @Override
    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        super.setSqlSessionFactory(sqlSessionFactory);
    }

    protected RowBoundVO<T> findPage(String countSqlMapper, String ListSqlMapper, AdminQuery adminQuery) {

        int totalCount = this.getSqlSession().selectOne(countSqlMapper, adminQuery);

        RowBoundVO<T> rowBoundVO = PageUtils.getRowBoundVO(adminQuery, totalCount);
        if (rowBoundVO == null) {
            return null;
        }
        List<T> list = null;
        try {
            list = this.getSqlSession().selectList(ListSqlMapper, adminQuery);
        } catch (Exception e) {
            throw new DAOException(e);
        }
        rowBoundVO.setList(list);
        return rowBoundVO;
    }



}
