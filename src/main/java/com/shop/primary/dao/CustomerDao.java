package com.shop.primary.dao;

import com.shop.primary.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerDao extends JpaRepository<Customer, Long>, JpaSpecificationExecutor {

    Customer findByMobile(String mobole);

}
