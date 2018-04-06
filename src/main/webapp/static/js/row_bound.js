function getActive(index) {
    var html = '';
    html += '<li class="paginate_button active" aria-controls="DataTables_Table_0" tabindex="0" >';
    html += '<a type="button">'+ index +'</a>';
    html += '</li>';
    return html;
}

function getNoActive(index) {
    var html = '';
    html += '<li class="paginate_button" aria-controls="DataTables_Table_0" tabindex="0" onclick="pageNum(' + index + ')">';
    html += '<a type="button">'+ index +'</a>';
    html += '</li>';
    return html;
}
function getMany() {
    var html = '';
    html += '<li class="footable-page active">';
    html += '<a>';
    html += '...'
    html += '</a>';
    html += '</li>';
    return html;
}


function page_Num(pageNum, pageCount) {
    var html = '';
    if (pageNum < 2) {
        html += '<li class="paginate_button previous disabled" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous" >';
        html += '<a type="button">首页</a>';
        html += '</li>';
        html += '<li class="paginate_button previous disabled" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous" >';
        html += '<a type="button">上一页</a>';
        html += '</li>';
    }
    else {
        var index = parseInt(pageNum - 1);
        html += '<li class="paginate_button previous" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous" onclick="pageFirst()">';
        html += '<a type="button">首页</a>';
        html += '</li>';
        html += '<li class="paginate_button previous" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous" onclick="pageTop()">';
        html += '<a type="button">上一页</a>';
        html += '</li>';
    }
    if (pageNum < 4 && pageCount > 5) {
        for (var i = 0; i < pageCount;i++) {
            var index = i + 1;
            if (index == pageNum) {
                html += getActive(index);
            } else {
                html += getNoActive(index);
            }
            if (index > 4 ){
                html += getMany();
                flag = 1;
                break;
            }
        }
    } else if (pageNum < 4 && pageCount < 6){
        for (var i = 0; i < pageCount;i++) {
            var index = i + 1;
            if (index == pageNum) {
                html += getActive(index);
            } else {
                html += getNoActive(index);
            }
        }
    } else if (pageNum > 3 && pageNum < 6 && pageCount > 8) {
        var max = pageNum + 2;
        for (var i = 0; i < pageCount;i++) {
            var index = i + 1;
            if (index == pageNum) {
                html += getActive(index);
            } else {
                html += getNoActive(index);
            }
            if (index >= max){
                html += getMany();
                break;
            }
        }
    } else if (pageNum > 3 && pageNum < 6 && pageCount < 9) {
        var max = pageNum + 2;
        for (var i = 0; i < pageCount;i++) {
            var index = i + 1;
            if (index == pageNum) {
                html += getActive(index);
            } else {
                html += getNoActive(index);
            }
            if (index >= max && max < pageCount){
                html += getMany();
                break;
            }
        }
    } else if (pageNum >= 6 && pageCount < 9) {
        for (var i = 0; i < pageCount;i++) {
            var index = i + 1;
            if (index == pageNum) {
                html += getActive(index);
            } else {
                html += getNoActive(index);
            }
        }
    }else if (pageNum >= 6 && pageCount > 8) {
        html += '<li class="paginate_button" onclick="pageNum(1)">';
        html += '<a>1</a>';
        html += '</li>';
        html += '<li class="paginate_button" onclick="pageNum(2)">';
        html += '<a>2</a>';
        html += '</li>';
        html += getMany();
        var pageCha = pageCount - pageNum;
        var pageStart = 0;
        if (pageCha < 2) {
            pageStart = pageCount - 4;
        } else {
            pageStart = pageNum - 2;
        }
        for (var i = 0;i < 5; i++) {
            if (pageStart == pageNum) {
                html += getActive(pageStart);
            } else {
                html += getNoActive(pageStart);
            }
            pageStart = pageStart + 1;
        }
        if (pageCha > 2){
            html += getMany();
        }
    }

    if (pageNum == pageCount || pageCount == 0) {
        html += '<li class="paginate_button previous disabled" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous">';
        html += '<a type="button">下一页</a>';
        html += '</li>';
        html += '<li class="paginate_button previous disabled" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous">';
        html += '<a>末页</a>';
        html += '</li>';
    }
    else {
        html += '<li class="paginate_button previous" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous" onclick="pageXia()">';
        html += '<a type="button">下一页</a>';
        html += '</li>';
        html += '<li class="paginate_button previous" aria-controls="DataTables_Table_0" tabindex="0" id="DataTables_Table_0_previous" onclick="pageEnd('+ pageCount +')">';
        html += '<a>末页</a>';
        html += '</li>';
    }
    document.getElementById('round_ul').innerHTML =  html;
}

function pageFirst() {
    $("#pageNo").val(1);
    $('#formPage').submit();
}
function pageTop(){
    $("#pageNo").val(parseInt($("#pageNo").val() - 1));
    $('#formPage').submit();
}
function pageXia(){
    $("#pageNo").val(parseInt($("#pageNo").val()) + 1);
    $('#formPage').submit();
}
function pageEnd(end) {
    $("#pageNo").val(end);
    $('#formPage').submit();
}
function pageNum(num){
    $("#pageNo").val(num);
    $('#formPage').submit();
}