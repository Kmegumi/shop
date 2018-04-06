package com.shop.core.utils;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;


public class NumUtil {
    private static final int DEF_DIV_SCALE = 8; //这个类不能实例化


    public static String createDateNo() {
        StringBuilder stringBuilder = new StringBuilder(DateUtils.getOrderFormat());
        stringBuilder.append(getRandomNumber(8));
        return stringBuilder.toString();
    }

    /**
     * 得到n位长度的随机数
     * @param n 随机数的长度
     * @return 返回  n位的随机整数
     */
    public static Integer getRandomNumber(Integer n){
        Integer temp = 0;
        Integer min = (int) Math.pow(10, n-1);
        Integer max = (int) Math.pow(10, n);
        Random rand = new Random();
        while(true){
            temp = rand.nextInt(max);
            if(temp >= min)
                break;
        }
        return temp;
    }

    //格式化成2位小数
    public static String format(Double d){
        return new DecimalFormat("########0.00").format(d);
    }
    public static String format(String s){
        return new DecimalFormat("########0.00").format(Double.parseDouble(s));
    }
    //格式化成指定格式
    public static String format(Double d,String demo){
        return new DecimalFormat("########"+demo).format(d);
    }
    public static String formatZero(String s,String demo){
        return new DecimalFormat("########"+demo).format(Double.parseDouble(s));
    }
    public static String formatBase(Double d){
        if(d == null){
            return "0.00";
        }
        if(d == 0.0){
            return "0.00";
        }
        NumberFormat numberFormat = NumberFormat.getNumberInstance();
        numberFormat.setGroupingUsed(false);
        numberFormat.setMaximumFractionDigits(15);
        return numberFormat.format(d);
    }
    public static Double formatD(Double d,Integer i){
        BigDecimal bg = new BigDecimal(d.toString());
        return bg.setScale(i, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static Double addOfDouble(Double... ds) {
        Double t = 0.0;
        for (Double d : ds) {
            BigDecimal b1 = new BigDecimal(t.toString());
            BigDecimal b2 = new BigDecimal(d.toString());
            t = b1.add(b2).doubleValue();
        }
        return t;
    }

    public static Double subtractOfDouble(Double a,Double b) {
        Double t = 0.0;
        BigDecimal b1 = new BigDecimal(a.toString());
        BigDecimal b2 = new BigDecimal(b.toString());
        t = b1.subtract(b2).doubleValue();
        return t;
    }

    /**
     * 提供精确的乘法运算。
     * @param v1 被乘数
     * @param v2 乘数
     * @return 两个参数的积
     */
    public static double mul(double v1,double v2){
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.multiply(b2).doubleValue();
    }
    /**
     * 提供（相对）精确的除法运算，当发生除不尽的情况时，精确到
     * 小数点以后10位，以后的数字四舍五入。
     * @param v1 被除数
     * @param v2 除数
     * @return 两个参数的商
     */
    public static double div(double v1,double v2){
        return div(v1,v2,DEF_DIV_SCALE);
    }
    /**
     * 提供（相对）精确的除法运算。当发生除不尽的情况时，由scale参数指
     * 定精度，以后的数字四舍五入。
     * @param v1 被除数
     * @param v2 除数
     * @param scale 表示表示需要精确到小数点以后几位。
     * @return 两个参数的商
     */
    public static double div(double v1,double v2,int scale){
        if(scale<0){
            throw new IllegalArgumentException(
                    "The scale must be a positive integer or zero");
        }
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.divide(b2,scale,BigDecimal.ROUND_HALF_UP).doubleValue();
    }
    /**
     * 提供精确的小数位四舍五入处理。
     * @param v 需要四舍五入的数字
     * @param scale 小数点后保留几位
     * @return 四舍五入后的结果
     */
    public static double round(double v,int scale){
        if(scale<0){
            throw new IllegalArgumentException("The scale must be a positive integer or zero");
        }
        BigDecimal b = new BigDecimal(Double.toString(v));
        BigDecimal one = new BigDecimal("1");
        return b.divide(one,scale,BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static List<Integer> stringToArr(String text) {
        List<Integer> list = new ArrayList<Integer>();
        if (text != null) {
            String[] arr = text.split(",");
            for(String one : arr) {
                if (!"".equals(one)) {
                    try {
                        list.add(Integer.valueOf(one));
                    }catch (NumberFormatException e) {
                        continue;
                    }
                }
            }
        }
        return list;
    }

    public static String getUUID() {
        return UUID.randomUUID().toString();
    }
}
