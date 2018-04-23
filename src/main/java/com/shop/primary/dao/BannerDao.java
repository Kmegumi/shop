package com.shop.primary.dao;

import com.shop.primary.entity.Banner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface BannerDao extends JpaRepository<Banner, Long>, JpaSpecificationExecutor {
}
