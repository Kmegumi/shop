package com.shop.primary.controller;


import com.shop.core.common.BaseController;
import com.shop.primary.entity.Banner;
import com.shop.primary.entity.GoodsColumn;
import com.shop.primary.entity.User;
import com.shop.primary.pojo.query.AdminQuery;
import com.shop.primary.pojo.vo.ResultCodeVO;
import com.shop.primary.service.BannerService;
import com.shop.primary.service.ColumnService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("banner")
public class BannerController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(BannerController.class);

    @Autowired
    private BannerService bannerService;

    @RequestMapping(value = "list")
    public String adminList(AdminQuery adminQuery, ModelMap modelMap) {
        getLoginInfo();
        modelMap.addAttribute("page", bannerService.rowBound(adminQuery));
        modelMap.addAttribute("form", adminQuery);
        return "/banner/list";
    }

    @RequestMapping("add")
    public String add(Long id, ModelMap modelMap) {
        getLoginInfo();
        if (id != null) {
            Banner banner = bannerService.getById(id);
            modelMap.addAttribute("banner", banner);
        }
        return "banner/add";
    }

    @RequestMapping("saveOrUpdate")
    @ResponseBody
    public ResultCodeVO save(Banner banner){
        getLoginInfo();
        try {
            banner = bannerService.saveOrUpdate(banner);
        } catch (Exception e) {
            logger.error(banner.toString()+"_"+e.getMessage(), e);
        }
        if (banner == null) {
            return new ResultCodeVO("400", "保存失败");
        }
        return new ResultCodeVO("200", "保存成功");
    }


    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> deleteAdmin(Long id) {
        getLoginInfo();
        Map<String, String> map = new HashMap<>(4);
        try {
            bannerService.deleteById(id);
        } catch (Exception e) {
            logger.error(id == null ? "null":id .toString()+ "_"+e.getMessage(), e);
            map.put("code", "400");
            map.put("msg", "banner删除失败");
            return map;
        }
        map.put("code", "200");
        map.put("msg", "banner删除成功");
        return map;
    }
}
