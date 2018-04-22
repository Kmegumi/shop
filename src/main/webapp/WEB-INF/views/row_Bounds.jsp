<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String path = request.getContextPath();%>
<div class="row">
    <div class="col-sm-6">
        <div class="dataTables_info" id="DataTables_Table_0_info" role="alert" aria-live="polite" aria-relevant="all">
            显示 ${page.totalElements > 0 ? page.number * page.size + 1 : 0} 到 ${page.number * page.size + page.numberOfElements } 项，共 ${page.totalElements} 项
        </div>
    </div>
    <div class="col-sm-6">
        <div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
            <ul class="pagination" id="round_ul">

            </ul>
        </div>
    </div>
</div>
<script src="<%=path %>/static/js/row_bound.js?v=2"></script>
<script>
    page_Num(${page.number}, ${page.totalPages});
</script>
