package com.shop.primary.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * 上传文件的类型枚举
 * Created with IntelliJ IDEA.
 * User: wuyou
 * Date: 13-7-8
 * Time: 上午9:04
 * To change this template use File | Settings | File Templates.
 */
public enum UploadFileTypeEnum {
    PIC("图片",".gif; .jpg; .jpeg; .png",""),
    TXT("文本文档",".txt","http://static.shands.cn/icon/file/text.png"),
    EXCEL("excel",".xls; .xlsx","http://static.shands.cn/icon/file/xlsx_mac.png"),
    WORD("word",".doc; .docx","http://static.shands.cn/icon/file/docx_mac.png"),
    CSV("csv"," .csv","http://static.shands.cn/icon/file/text.png");

    private String description;
    private String extName;
    private String pic;


    public static UploadFileTypeEnum checkByExt(String d){
       for(UploadFileTypeEnum u : getList()){
           String[] tt = u.extName.split(";");
           if(tt.length>0){
               for(String t : tt){
                   if(t.trim().equals(d.toLowerCase().trim())){
                       return u;
                   }
               }
           }
       }
       return null;
    }

    public static List<UploadFileTypeEnum> getList(){
        List<UploadFileTypeEnum> demoList = new ArrayList<UploadFileTypeEnum>();
        for(UploadFileTypeEnum demo : UploadFileTypeEnum.values()){
            demoList.add(demo);
        }
        return demoList;
    }

    private UploadFileTypeEnum(String description, String extName, String pic) {
        this.description = description;
        this.extName = extName;
        this.pic = pic;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getExtName() {
        return extName;
    }

    public void setExtName(String extName) {
        this.extName = extName;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }
}
