<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="<%=path%>/static/pdms/js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="<%=path%>/static/pdms/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path%>/static/pdms/js/bootstrap.min.js?v=3.3.5"></script>
<script src="<%=path%>/static/pdms/js/plugins/jeditable/jquery.jeditable.js"></script>
<script src="<%=path%>/static/pdms/js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="<%=path%>/static/pdms/js/plugins/dataTables/dataTables.bootstrap.js"></script>
<script src="<%=path%>/static/pdms/js/content.min.js?v=1.0.0"></script>