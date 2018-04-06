<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% String path=request.getContextPath();%>
<c:choose>
    <c:when test="${dome != null}">
        <div class="row">
            <div class="col-sm-6">
                <div class="dataTables_info" id="DataTables_Table_0_info" role="alert" aria-live="polite" aria-relevant="all">显示 ${dome.firstResult + 1} 到 ${dome.firstResult+dome.list.size()}  项，共 ${dome.totalCount} 项</div>
            </div>
            <div class="col-sm-6">
                <div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
                    <ul class="pagination" id="round_ul">

                    </ul>
                </div>
            </div>
        </div>
        <script src="<%=path %>/static/js/row_bound.js"></script>
        <script>
            page_Num(${dome.pageNo},${dome.totalPageNum});
        </script>
    </c:when>
    <c:otherwise>
        <div class="row">
            <div class="col-sm-6">
                <div class="dataTables_info" id="DataTables_Table_0_info" role="alert" aria-live="polite" aria-relevant="all">显示 0 到 0 项，共 0 项</div>
            </div>
            <div class="col-sm-6">
                <div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
                    <ul class="pagination" id="round_ul">

                    </ul>
                </div>
            </div>
        </div>
        <script src="<%=path %>/static/js/row_bound.js"></script>
        <script>
            page_Num(1,1);
        </script>
    </c:otherwise>
</c:choose>
