package com.shop.core.utils;

import com.shop.core.exception.ServiceException;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * JDK8时间操作新类
 *
 * @author yuweilun
 * @date 2017/8/14
 */
public class DateUtils {

    private final static DateTimeFormatter FORMAT_ONE = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    private final static DateTimeFormatter FORMAT_TWO = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    private final static DateTimeFormatter ORDER_FORMAT = DateTimeFormatter.ofPattern("yyMMdd");

    private DateUtils(){

    }



    /**********************************************Instant 等使用********************************************************/



    /****↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓格式化时间字符串方法↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓***/




    /**
     * @return 系统当前时间格式化成系统默认时区yyMMdd 的字符串
     * */
    public static String getOrderFormat() {
        return getDateFormat(Instant.now());
    }



    /**
     * @param instant 根据需求调整的时间点
     * @return 根据instant格式化成系统默认时区yyMMdd 的字符串
     * */
    public static String getDateFormat(Instant instant) {
        if (instant == null) {
            return null;
        }
        return ORDER_FORMAT.format(getLocalDateTimeFromInstant(instant));
    }



    /**
     * @param instant 根据需求调整的时间点
     * @return 根据instant格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    public static String formatDate(Instant instant){

        if (instant != null) {
            ZonedDateTime zonedDateTime = instant.atZone(ZoneId.systemDefault());
            return FORMAT_ONE.format(zonedDateTime);
        }
        return null;
    }



    /**
     * @return 系统当前时间格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    public static String formatDateNow(){
        return formatDate(Instant.now());
    }



    /**
     * @return 系统当前时间格式化成系统默认时区yyyy-MM-dd的字符串
     * */
    public static String getCurrentDayString(){
        return getDayString(Instant.now());
    }



    /**
     * @param instant 需要格式化的时间
     * @return 系统当前时间格式化成系统默认时区yyyy-MM-dd的字符串
     * */
    public static String getDayString(Instant instant){
        if(instant != null) {
            ZonedDateTime zonedDateTime = instant.atZone(ZoneId.systemDefault());
            return FORMAT_TWO.format(zonedDateTime);
        }
        return null;
    }



    /**
     * @param instant 根据需求调整的时间点
     * @return 根据instant获取instant当天开始时间
     * 格式化成东系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    public static String formatDateStart(Instant instant){
        String dayTime = getDayString(instant);
        if (dayTime == null) {
            return null;
        }
        return new StringBuilder(dayTime)
                .append(" 00:00:00").toString();
    }



    /**
     * @return 系统当前时间所在当天的开始时间
     * 格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    public static String formatTodayStart(){
        return formatDateStart(Instant.now());
    }



    /**
     * @param instant 根据需求调整的时间点
     * @return 根据instant获取instant当天结束时间
     * 格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    public static String formatDateEnd(Instant instant){
        String dayTime = getDayString(instant);
        if (dayTime == null) {
            return null;
        }
        return new StringBuilder(dayTime)
                .append(" 23:59:59").toString();
    }



    /**
     * @return 系统当前时间所在当天的结束时间
     * 格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    public static String formatTodayEnd(){
        return formatDateStart(Instant.now());
    }


    /**
     * @param instant 根据需求调整的时间点
     * @param pattern 合法的时间格式
     * @return 将instant格式化成系统默认时区 pattern 格式 的字符串
     * */
    public static String formatDateOfPattern(Instant instant, String pattern){
        if (instant != null && pattern != null) {
            ZonedDateTime zonedDateTime = instant.atZone(ZoneId.systemDefault());
            return DateTimeFormatter.ofPattern(pattern).format(zonedDateTime);
        }
        return null;
    }



    /**
     * @param pattern 合法的时间格式
     * @return 将当前时间点格式化成东八区 pattern 格式 的字符串
     * */
    public static String formatDateOfPatternNow(String pattern){
        return formatDateOfPattern(Instant.now(), pattern);
    }



    /****↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑格式化时间字符串方法↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑***/




    /****↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓根据参数返回时间对象方法↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓***/
    /**
     * @param text yyyy-MM-dd HH:mm:ss格式的字符串
     * @return 根据text字符串生成的Instant时间对象
     * */
    public static Instant parseDateToInstant(CharSequence text){
        return parseDate(text).atZone(ZoneId.systemDefault()).toInstant();
    }



    /**
     * @param text yyyy-MM-dd HH:mm:ss格式的字符串
     * @return 根据text字符串生成的本地时间对象
     * */
    public static LocalDateTime parseDate(CharSequence text){
        if (text == null) {
            return null;
        }
        return LocalDateTime.from(FORMAT_ONE.parse(text));
    }



    /**
     * @param text 时间格式的字符串
     * @param pattern text对应的时间格式的字符串
     * @return 根据text字符串生成的Instant时间对象
     * */
    public static Instant parseDateToInstant(CharSequence text, String pattern){
        return parseDate(text, pattern).atZone(ZoneId.systemDefault()).toInstant();
    }




    /**
     * @param text 时间格式的字符串
     * @param pattern text对应的时间格式的字符串
     * @return 根据text字符串生成的本地时间对象
     * */
    public static LocalDateTime parseDate(CharSequence text, String pattern){
        return LocalDateTime.from(DateTimeFormatter.ofPattern(pattern).parse(text));
    }



    /**
     * @param year 合法的年份
     * @param month 合法的月份
     * @return 生成year年month月的Instant对象
     * */
    public static Instant getInstantByYearAndMonth(int year, int month) {
        return getLocalDateByYearAndMonth(year, month).atZone(ZoneId.systemDefault()).toInstant();
    }



    /**
     * @param year 合法的年份
     * @param month 合法的月份
     * @return 生成year年month月的LocalDateTime对象
     * */
    public static LocalDateTime getLocalDateByYearAndMonth(int year, int month) {
        return LocalDateTime.of(year, month, 1, 0 ,0);
    }




    /**
     * @param instant 时间对象
     * @param milliseconds 需要增加的毫秒数
     * @return 增加毫秒数后的Instant对象
     * */
    public static Instant addMillisecond(Instant instant, long milliseconds) {
        if (instant == null) {
            return null;
        }
        return instant.plusMillis(milliseconds);
    }



    /**
     * @param instant 时间对象
     * @param seconds 需要增加的秒数
     * @return 增加秒数后的Instant对象
     * */
    public static Instant addSecond(Instant instant, long seconds) {
        if (instant == null) {
            return null;
        }
        return instant.plusSeconds(seconds);
    }



    /**
     * @param instant 时间对象
     * @param minutes 需要增加的分钟数
     * @return 增加分钟数后的Instant对象
     * */
    public static Instant addMinute(Instant instant, long minutes) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(
                getLocalDateTimeFromInstant(instant).plusMinutes(minutes));
    }



    /**
     * @param instant 时间对象
     * @param hours 需要增加的小时数
     * @return 增加小时数后的Instant对象
     * */
    public static Instant addHour(Instant instant, long hours) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(
                getLocalDateTimeFromInstant(instant).plusHours(hours));
    }



    /**
     * @param instant 时间对象
     * @param days 需要增加的天数
     * @return 增加天数后的Instant对象
     * */
    public static Instant addDay(Instant instant, long days) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(
                getLocalDateTimeFromInstant(instant).plusDays(days));
    }



    /**
     * @param instant 时间对象
     * @param months 需要增加的月份数
     * @return 增加月份数后的Instant对象
     * */
    public static Instant addMonth(Instant instant, int months) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(
                getLocalDateTimeFromInstant(instant).plusMonths(months));
    }



    /**
     * @param instant 时间对象
     * @param years 需要增加的年数
     * @return 增加年数后的Instant对象
     * */
    public static Instant addYear(Instant instant, int years) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(
                getLocalDateTimeFromInstant(instant).plusYears(years));
    }




    /**
     * @param instant 时间对象
     * @return 返回 instant 所在月份的第一天
     * */
    public static Instant getFirstDateOfMonth(Instant instant) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(
                getLocalDateTimeFromInstant(instant).withDayOfMonth(1));
    }



    /**
     * @param instant 时间对象
     * @return 返回 instant 所在年份的第一天
     * */
    public static Instant getFirstDateOfYear(Instant instant) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(
                getLocalDateTimeFromInstant(instant).withDayOfYear(1));
    }



    /**
     * @param instant 时间对象
     * @return 返回 instant 所在月份的最后一天
     * */
    public static Instant getLastDateOfMonth(Instant instant) {
        if (instant == null) {
            return null;
        }
        return getInstantFromLocalDateTime(getLastDateOfMonthForLocalTime(instant));
    }


    /**
     * @param instant 时间对象
     * @return 返回 instant 所在月份的最后一天的LocalDateTime对象
     * */
    public static LocalDateTime getLastDateOfMonthForLocalTime(Instant instant) {
        if (instant == null) {
            return null;
        }
        LocalDateTime localDateTime = getLocalDateTimeFromInstant(instant);
        if (localDateTime == null) {
            return null;
        }
        return localDateTime.plusMonths(1).minusDays(localDateTime.getDayOfMonth());
    }



    /**
     * @param instant 时间对象
     * @return 指定默认时区之后的LocalDateTime
     * */
    public static LocalDateTime getLocalDateTimeFromInstant(Instant instant) {
        if (instant == null) {
            return null;
        }
        return LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
    }


    /**
     * @param localDateTime 时间对象
     * @return 指定默认时区之后的instant
     * */
    public static Instant getInstantFromLocalDateTime(LocalDateTime localDateTime) {
        if (localDateTime == null) {
            return null;
        }
        return localDateTime.atZone(ZoneId.systemDefault()).toInstant();
    }


    /**
     * @param instant 时间对象
     * @return 指定默认时区之后的LocalDate
     * */
    public static LocalDate getLocalDateFromInstant(Instant instant) {
        if (instant == null) {
            return null;
        }
        return getLocalDateTimeFromInstant(instant).toLocalDate();
    }





    /****↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑根据参数返回时间对象方法↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑***/



    /****↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓时间比较计算数值类方法↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓***/

    /**
     * @param year 合法的年份
     * @param month 合法的月份
     * @return 指定年份中指定月份的天数
     * */
    public static int getMonthLastDay(int year, int month){
        LocalDateTime localDateTime = LocalDateTime.of(year, month, 1, 0, 0);
        localDateTime = localDateTime.minusMonths(-1).minusDays(1);
        return localDateTime.getDayOfMonth();
    }



    /**
     * @param instant 时间对象
     * @return 返回 instant 所在月份的总天数
     * */
    public static int getDayOfMonth(Instant instant) {
        if (instant == null) {
            return -1;
        }
        return getLastDateOfMonthForLocalTime(instant).getDayOfMonth();
    }



    /**
     * @param instant1 时间对象1
     * @param instant2 时间对象2
     * @return 时间对象1比对象2早返回true，对象1比对象2晚或相等返回false(比较到天)
     * */
    public static boolean beforeDay(Instant instant1, Instant instant2) {
        if (instant1 == null || instant2 == null) {
            throw new ServiceException("缺少比较的时间对象");
        }
        LocalDate localDate1 = getLocalDateFromInstant(instant1);
        LocalDate localDate2 = getLocalDateFromInstant(instant2);
        return localDate1.isBefore(localDate2);
    }



    /**
     * @param instant1 时间对象1
     * @param instant2 时间对象2
     * @return 时间对象1比对象2早返回true，对象1比对象2晚或相等返回false(比较到秒)
     * */
    public static boolean beforeSeconds(Instant instant1, Instant instant2) {
        if (instant1 == null || instant2 == null) {
            throw new ServiceException("缺少比较的时间对象");
        }
        LocalDateTime localDateTime1 = getLocalDateTimeFromInstant(instant1);
        LocalDateTime localDateTime2 = getLocalDateTimeFromInstant(instant2);
        if (localDateTime1.getYear() < localDateTime2.getYear()) {
            return true;
        }
        if (localDateTime1.getYear() == localDateTime2.getYear()) {
            if (localDateTime1.getDayOfYear() < localDateTime2.getDayOfYear()) {
                return true;
            }
            if (localDateTime1.getDayOfYear() == localDateTime2.getDayOfYear()) {
                if (localDateTime1.getHour() < localDateTime2.getHour()) {
                    return true;
                }
                if (localDateTime1.getHour() == localDateTime2.getHour()) {
                    if (localDateTime1.getMinute() < localDateTime2.getMinute()) {
                        return true;
                    }
                    if (localDateTime1.getMinute() == localDateTime2.getMinute()) {
                        if (localDateTime1.getSecond() < localDateTime2.getSecond()) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }



    /**
     * @param instant1 时间对象1
     * @param instant2 时间对象2
     * @return 时间对象1比对象2晚返回true，对象1比对象2早或相等返回false(比较到天)
     * */
    public static boolean afterDay(Instant instant1, Instant instant2) {
        if (instant1 == null || instant2 == null) {
            throw new ServiceException("缺少比较的时间对象");
        }
        LocalDate localDate1 = getLocalDateFromInstant(instant1);
        LocalDate localDate2 = getLocalDateFromInstant(instant2);
        return localDate1.isAfter(localDate2);
    }



    /**
     * @param instant1 时间对象1
     * @param instant2 时间对象2
     * @return 时间对象1比对象2晚返回true，对象1比对象2早或相等返回false(比较到秒)
     * */
    public static boolean afterSeconds(Instant instant1, Instant instant2) {
        if (instant1 == null || instant2 == null) {
            throw new ServiceException("缺少比较的时间对象");
        }
        LocalDateTime localDateTime1 = getLocalDateTimeFromInstant(instant1);
        LocalDateTime localDateTime2 = getLocalDateTimeFromInstant(instant2);
        if (localDateTime1.getYear() > localDateTime2.getYear()) {
            return true;
        }
        if (localDateTime1.getYear() == localDateTime2.getYear()) {
            if (localDateTime1.getDayOfYear() > localDateTime2.getDayOfYear()) {
                return true;
            }
            if (localDateTime1.getDayOfYear() == localDateTime2.getDayOfYear()) {
                if (localDateTime1.getHour() > localDateTime2.getHour()) {
                    return true;
                }
                if (localDateTime1.getHour() == localDateTime2.getHour()) {
                    if (localDateTime1.getMinute() > localDateTime2.getMinute()) {
                        return true;
                    }
                    if (localDateTime1.getMinute() == localDateTime2.getMinute()) {
                        if (localDateTime1.getSecond() > localDateTime2.getSecond()) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }

    /**
     * @param instant1 时间对象1
     * @param instant2 时间对象2
     * @return 时间对象1和对象2同一天返回true，其他返回false(比较到天)
     * */
    public static boolean equalDay(Instant instant1, Instant instant2) {
        if (instant1 == null || instant2 == null) {
            throw new ServiceException("缺少比较的时间对象");
        }
        LocalDate localDate1 = getLocalDateFromInstant(instant1);
        LocalDate localDate2 = getLocalDateFromInstant(instant2);
        return localDate1.equals(localDate2);
    }




    /**
     * @param startTime 开始时间对象
     * @param endTime 结束时间对象
     * @return 返回开始时间和结束时间之间的时间期间对象
     * */
    public static Period getIntervalDays(Instant startTime, Instant endTime) {
        if (startTime == null || endTime == null) {
            return null;
        }
        LocalDate localDate1 = getLocalDateFromInstant(startTime);
        LocalDate localDate2 = getLocalDateFromInstant(endTime);
        return Period.between(localDate1, localDate2);
    }






    /**********************************************Date保留 使用********************************************************/



    /**
     * @param date 时间点
     * @return 根据date格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    @Deprecated
    public static String formatDate(Date date) {
        return formatDate(date.toInstant());
    }



    /**
     * @param date 时间点
     * @return 根据date获取date当天开始时间
     * 格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    @Deprecated
    public static String formatDateStart(Date date){
        return formatDateStart(date.toInstant());
    }



    /**
     * @param date 需要格式化的时间
     * @return 系统当前时间格式化成系统默认时区yyyy-MM-dd的字符串
     * */
    @Deprecated
    public static String getDayString(Date date){
        if(date != null) {
            return getDayString(date.toInstant());
        }
        return null;
    }



    /**
     * @param date 时间点
     * @return 根据date获取date当天结束时间
     * 格式化成系统默认时区yyyy-MM-dd HH:mm:ss 的字符串
     * */
    @Deprecated
    public static String formatDateEnd(Date date){
        return formatDateEnd(date.toInstant());
    }



    /**
     * @param date 时间点
     * @param pattern 合法的时间格式
     * @return 将instant格式化成系统默认时区 pattern 格式 的字符串
     * */
    @Deprecated
    public static String formatDateOfPattern(Date date, String pattern){
        return formatDateOfPattern(date.toInstant(), pattern);
    }



    /**
     * @param text yyyy-MM-dd HH:mm:ss格式的字符串
     * @return 根据text字符串生成的Date时间对象
     * */
    @Deprecated
    public static Date parseDateToDate(CharSequence text){
        return Date.from(parseDateToInstant(text));
    }



    /**
     * @param text 时间格式的字符串
     * @param pattern text对应的时间格式的字符串
     * @return 根据text字符串生成的Date时间对象
     * */
    @Deprecated
    public static Date parseDateToDate(CharSequence text, String pattern){
        return Date.from(parseDateToInstant(text, pattern));
    }



    /**
     * @param year 合法的年份
     * @param month 合法的月份
     * @return 生成year年month月的Date对象
     * */
    @Deprecated
    public static Date getDateByYearAndMonth(int year, int month) {
        return Date.from(getInstantByYearAndMonth(year, month));
    }



    /**
     * Util类test
     * */
    public static void main(String[] args) {
        /*System.out.println(DateUtils.formatDate(new Date()));
        System.out.println(DateUtils.formatDate(Instant.now()));
        System.out.println(DateUtils.formatDateNow());
        System.out.println(DateUtils.formatDateStart(new Date()));
        System.out.println(DateUtils.formatDateStart(Instant.now()));
        System.out.println(DateUtils.formatTodayStart());
        System.out.println(DateUtils.formatDateEnd(new Date()));
        System.out.println(DateUtils.formatDateEnd(Instant.now()));
        System.out.println(DateUtils.formatTodayEnd());
        System.out.println(DateUtils.formatDateOfPattern(new Date(), "yyyy-MM-dd"));
        System.out.println(DateUtils.formatDateOfPattern(Instant.now(), "yyyy-MM-dd"));
        System.out.println(DateUtils.formatDateOfPatternNow("yyyy-MM-dd"));
        System.out.println(DateUtils.parseDate("2017-08-15 17:20:00"));
        System.out.println(DateUtils.parseDateToInstant("2017-08-15 17:20:00"));
        System.out.println(DateUtils.parseDateToDate("2017-08-15 17:20:00"));
        System.out.println(DateUtils.parseDate("2017/08/15 17:20:00", "yyyy/MM/dd HH:mm:ss"));
        System.out.println(DateUtils.parseDateToInstant("2017/08/15 17:20:00", "yyyy/MM/dd HH:mm:ss"));
        System.out.println(DateUtils.parseDateToDate("2017/08/15 17:20:00", "yyyy/MM/dd HH:mm:ss"));
        System.out.println(DateUtils.getMonthLastDay(1995,3));
        System.out.println(DateUtils.getLocalDateByYearAndMonth(1995,3));
        System.out.println(DateUtils.getInstantByYearAndMonth(1995,3));
        System.out.println(DateUtils.getDateByYearAndMonth(1995,3));*/
    }
}
