<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">


<head>
    <%@ include file="../../static/head.jsp" %>
    <!-- font-awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>

</style>
<body>



<%-- 用户购买商品列表 --%>
<div class="modal fade" id="buyOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <%-- 模态框标题--%>
            <div class="modal-header">
                <h5 class="modal-title" id="modal-title">订单列表</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%-- 模态框内容 --%>
            <div class="modal-body">
                <div class="col-sm-12">
                    <label class="col-sm-10">
                        商品:
                        <select id="goodsSelect" name="goodsSelect"
                                class="selectpicker form-control"  data-live-search="true"
                                title="请选择" data-header="请选择" data-size="5">
                        </select>
                    </label>
                    <label class="col-sm-1">
                        <button onclick="addBuyOrderOne()" type="button" class="btn btn-success 修改">添加</button>
                    </label>
                    <div class="row">
                        <div class="form-group col-md-6">
                            会员:
                            <select id="huiyuanSelect" name="huiyuanSelect"
                                    class="selectpicker form-control"  data-live-search="true"
                                    title="请选择" data-header="请选择" data-size="5">
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label>姓名</label>
                            <input id="huiyuanName" name="huiyuanName" class="form-control"
                                   v-model="ruleForm.huiyuanName" readonly>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>手机号</label>
                            <input id="huiyuanPhone" name="huiyuanPhone" class="form-control"
                                   v-model="ruleForm.huiyuanPhone" readonly>
                        </div>
                        <div class="form-group col-md-6">
                            <label>身份证号</label>
                            <input id="huiyuanIdNumber" name="huiyuanIdNumber" class="form-control"
                                   v-model="ruleForm.huiyuanIdNumber" readonly>
                        </div>
                    </div>
                </div>
                <%-- 添加物资 --%>
                <table id="buyOrder" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th >物资名称</th>
                        <th >库存</th>
                        <th >单价</th>
                        <th >购买数量</th>
                        <th >单位</th>
                        <th >总价</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="buyOrderTbody">
                    </tbody>
                </table>
                    <div style="margin-left: 330px">
                        <div>
                            <font size="3" color="#a9a9a9"><s>原总价:<font><span id="buyOriginalMoney"></span></font></s></font>
                        </div>
                        <div>
                            <font size="4" color="red">折后价:<font><span id="buyDiscountMoney"></span></font></font>
                        </div>
                    </div>



            </div>
            <%-- 模态框按钮 --%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="submitBuyOrder()" class="btn btn-primary">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<%-- 查看订单详情--%>
<div class="modal fade" id="buyOrderListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <%-- 模态框标题--%>
            <div class="modal-header">
                <h5 class="modal-title" id="modal-list-title">订单详情列表</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%-- 模态框内容 --%>
            <div class="modal-body">
                <%-- 查出当前订单的订单详情 --%>
                <table id="buyOrderList" class="table table-bordered table-striped">
                    <thead>
                    <tr>
                        <th >商品名称</th>
                        <th >操作数量</th>
                        <th >单价</th>
                        <th >总价</th>
                        <th >单位</th>
                    </tr>
                    </thead>
                    <tbody id="buyOrderListTbody">
                    </tbody>
                </table>
                <div style="margin-left: 330px">
                    <div>
                        <font size="3" color="#a9a9a9"><s>原总价:<font><span id="originalMoney"></span></font></s></font>
                    </div>
                    <div>
                        <font size="4" color="red">折后价:<font><span id="discountMoney"></span></font></font>
                    </div>
                </div>
            </div>
            <%-- 模态框按钮 --%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>



<!-- Pre Loader -->
<div class="loading">
    <div class="spinner">
        <div class="double-bounce1"></div>
        <div class="double-bounce2"></div>
    </div>
</div>
<!--/Pre Loader -->
<div class="wrapper">
    <!-- Page Content -->
    <div id="content">
        <!-- Top Navigation -->
        <%@ include file="../../static/topNav.jsp" %>
        <!-- Menu -->
        <div class="container menu-nav">
            <nav class="navbar navbar-expand-lg lochana-bg text-white">
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="ti-menu text-white"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul id="navUl" class="navbar-nav mr-auto">
                    </ul>
                </div>
            </nav>
        </div>
        <!-- /Menu -->
        <!-- Breadcrumb -->
        <!-- Page Title -->
        <div class="container mt-0">
            <div class="row breadcrumb-bar">
                <div class="col-md-6">
                    <h3 class="block-title">购买订单管理</h3>
                </div>
                <div class="col-md-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <span class="ti-home"></span>
                            </a>
                        </li>
                        <li class="breadcrumb-item">购买订单管理</li>
                        <li class="breadcrumb-item active">购买订单列表</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /Page Title -->

        <!-- /Breadcrumb -->
        <!-- Main Content -->
        <div class="container">

            <div class="row">
                <!-- Widget Item -->
                <div class="col-md-12">
                    <div class="widget-area-2 lochana-box-shadow">
                        <h3 class="widget-title">购买订单列表</h3>
                        <div class="table-responsive mb-3">
                            <div class="col-sm-12">
                                                                 
                                        <label>
                                            订单编号
                                            <input type="text" id="orderBianhaoSearch" style="width: 140px;" class="form-control form-control-sm"
                                                   placeholder="订单编号" aria-controls="tableId">
                                        </label>
                                 
                                        <label>
                                            操作人姓名
                                            <input type="text" id="caozuoNameSearch" style="width: 140px;" class="form-control form-control-sm"
                                                   placeholder="操作人姓名" aria-controls="tableId">
                                        </label>
                                                                                                                                 
                                            <label>
                                                折后价
                                                <input type="text" id="discountMoneyStartSearch" style="width: 100px;" onchange="discountMoneyChickValue(this)"   class="form-control " placeholder="开始" aria-controls="tableId">
                                            </label>
                                                -
                                            <label>
                                                <input type="text" id="discountMoneyEndSearch" style="width: 100px;" onchange="discountMoneyChickValue(this)"     class="form-control" placeholder="结束" aria-controls="tableId">
                                            </label>
                                 
                                        <label>
                                            订单添加时间
                                            <input type="datetime-local" id="insertTimeStartSearch" style="width: 190px;" class="form-control " placeholder="开始" aria-controls="tableId">
                                        </label>
                                            -
                                        <label>
                                            <input type="datetime-local" id="insertTimeEndSearch" style="width: 190px;"  class="form-control" placeholder="结束" aria-controls="tableId">
                                        </label>
                                
                                                                                                 
                                            <label>
                                                姓名
                                                <input type="text" id="huiyuanNameSearch"  style="width: 120px;" class="form-control form-control-sm"
                                                       placeholder="姓名" aria-controls="tableId">
                                            </label>
                                                 
                                            <label>
                                                手机号
                                                <input type="text" id="huiyuanPhoneSearch"  style="width: 120px;" class="form-control form-control-sm"
                                                       placeholder="手机号" aria-controls="tableId">
                                            </label>
                                                 
                                            <label>
                                                身份证号
                                                <input type="text" id="huiyuanIdNumberSearch"  style="width: 120px;" class="form-control form-control-sm"
                                                       placeholder="身份证号" aria-controls="tableId">
                                            </label>

                                <button onclick="search()" type="button" class="btn btn-primary">查询</button>
                                <%--<button onclick="add()" type="button" class="btn btn-success 新增">添加</button>--%>
                                <button onclick="addBuyOrder()" type="button" class="btn btn-success 修改">新增订单</button>
                                <button onclick="graph()" type="button" class="btn btn-success 报表">报表</button>
                                <button onclick="deleteMore()" type="button" class="btn btn-danger 删除">批量删除</button>
                            </div>
                            <table id="tableId" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th class="no-sort" style="min-width: 35px;">
                                        <div class="custom-control custom-checkbox">
                                            <input class="custom-control-input" type="checkbox" id="select-all"
                                                   onclick="chooseAll()">
                                            <label class="custom-control-label" for="select-all"></label>
                                        </div>
                                    </th>

                                    <th >姓名</th>
                                    <th >手机号</th>
                                    <th >身份证号</th>
                                    <th >订单编号</th>
                                    <th >操作人姓名</th>
                                    <th >原总价</th>
                                    <th >折后价</th>
                                    <th >订单添加时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="thisTbody">
                                </tbody>
                            </table>
                            <div class="col-md-6 col-sm-3">
                                <div class="dataTables_length" id="tableId_length">

                                    <select name="tableId_length" aria-controls="tableId" id="selectPageSize"
                                            onchange="changePageSize()">
                                        <option value="10">10</option>
                                        <option value="25">25</option>
                                        <option value="50">50</option>
                                        <option value="100">100</option>
                                    </select>
                                    条 每页

                                </div>
                            </div>
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-end">
                                    <li class="page-item" id="tableId_previous" onclick="pageNumChange('pre')">
                                        <a class="page-link" href="#" tabindex="-1">上一页</a>
                                    </li>

                                    <li class="page-item" id="tableId_next" onclick="pageNumChange('next')">
                                        <a class="page-link" href="#">下一页</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <!-- /Widget Item -->
            </div>
        </div>
        <!-- /Main Content -->

    </div>
    <!-- /Page Content -->
</div>
<!-- Back to Top -->
<a id="back-to-top" href="#" class="back-to-top">
    <span class="ti-angle-up"></span>
</a>
<!-- /Back to Top -->
<%@ include file="../../static/foot.jsp" %>
<script language="javascript" type="text/javascript"
        src="${pageContext.request.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" charset="utf-8"
        src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js">
</script><script type="text/javascript" charset="utf-8"
                 src="${pageContext.request.contextPath}/resources/js/bootstrap-select.js"></script>

<script>
    <%@ include file="../../utils/menu.jsp"%>
            <%@ include file="../../static/setMenu.js"%>
            <%@ include file="../../utils/baseUrl.jsp"%>
            <%@ include file="../../static/getRoleButtons.js"%>
            <%@ include file="../../static/crossBtnControl.js"%>
    var tableName = "buyOrder";
    var pageType = "list";
    var searchForm = {key: ""};
    var pageIndex = 1;
    var pageSize = 10;
    var totalPage = 0;
    var dataList = [];
    var sortColumn = '';
    var sortOrder = '';
    var ids = [];
    var checkAll = false;

     var sexTypesOptions = [];
     var jifenTypesOptions = [];
     var huiyuanTypesOptions = [];
     var goodsOptions = [];
     var huiyuanOptions = [];
     var huiyuan = null;


    function init() {
        // 满足条件渲染提醒接口
    }

    // 改变每页记录条数
    function changePageSize() {
        var selection = document.getElementById('selectPageSize');
        var index = selection.selectedIndex;
        pageSize = selection.options[index].value;
        getDataList();
    }



    // 查询
    function search() {
        searchForm = {key: ""};

        <!-- 级联表的级联字典表 -->
                                         
                        //姓名
        var huiyuanNameSearchInput = $('#huiyuanNameSearch');
        if( huiyuanNameSearchInput != null){
            if (huiyuanNameSearchInput.val() != null && huiyuanNameSearchInput.val() != '') {
                searchForm.huiyuanName = $('#huiyuanNameSearch').val();
            }
        }
                     
                        //手机号
        var huiyuanPhoneSearchInput = $('#huiyuanPhoneSearch');
        if( huiyuanPhoneSearchInput != null){
            if (huiyuanPhoneSearchInput.val() != null && huiyuanPhoneSearchInput.val() != '') {
                searchForm.huiyuanPhone = $('#huiyuanPhoneSearch').val();
            }
        }
                     
                        //身份证号
        var huiyuanIdNumberSearchInput = $('#huiyuanIdNumberSearch');
        if( huiyuanIdNumberSearchInput != null){
            if (huiyuanIdNumberSearchInput.val() != null && huiyuanIdNumberSearchInput.val() != '') {
                searchForm.huiyuanIdNumber = $('#huiyuanIdNumberSearch').val();
            }
        }
                     
        var sexTypesSelectSearchInput = document.getElementById("sexTypesSelectSearch");
        if(sexTypesSelectSearchInput != null){
            var sexTypesIndex = sexTypesSelectSearchInput.selectedIndex;
            if( sexTypesIndex  != 0){
                searchForm.sexTypes = document.getElementById("sexTypesSelectSearch").options[sexTypesIndex].value;
            }
        }
                                                                                                     
                            //积分
        var jifenStartSearchInput = $('#jifenStartSearch');
        if(jifenStartSearchInput != null){
            var jifenStartSearchValue = jifenStartSearchInput.val();
            if( jifenStartSearchValue  != 0){
                searchForm.jifenStart = jifenStartSearchValue;
            }
        }
        var jifenEndSearchInput = $('#jifenEndSearch');
        if(jifenEndSearchInput != null){
            var jifenEndSearchValue = jifenEndSearchInput.val();
            if( jifenEndSearchValue  != 0){
                searchForm.jifenEnd = jifenEndSearchValue;
            }
        }
                     
        var jifenTypesSelectSearchInput = document.getElementById("jifenTypesSelectSearch");
        if(jifenTypesSelectSearchInput != null){
            var jifenTypesIndex = jifenTypesSelectSearchInput.selectedIndex;
            if( jifenTypesIndex  != 0){
                searchForm.jifenTypes = document.getElementById("jifenTypesSelectSearch").options[jifenTypesIndex].value;
            }
        }
                     
        var huiyuanTypesSelectSearchInput = document.getElementById("huiyuanTypesSelectSearch");
        if(huiyuanTypesSelectSearchInput != null){
            var huiyuanTypesIndex = huiyuanTypesSelectSearchInput.selectedIndex;
            if( huiyuanTypesIndex  != 0){
                searchForm.huiyuanTypes = document.getElementById("huiyuanTypesSelectSearch").options[huiyuanTypesIndex].value;
            }
        }
    <!-- 本表的查询条件 -->

         
        //订单编号
        var orderBianhaoSearchInput = $('#orderBianhaoSearch');
        if( orderBianhaoSearchInput != null){
            if (orderBianhaoSearchInput.val() != null && orderBianhaoSearchInput.val() != '') {
                searchForm.orderBianhao = $('#orderBianhaoSearch').val();
            }
        }
     
        //操作人姓名
        var caozuoNameSearchInput = $('#caozuoNameSearch');
        if( caozuoNameSearchInput != null){
            if (caozuoNameSearchInput.val() != null && caozuoNameSearchInput.val() != '') {
                searchForm.caozuoName = $('#caozuoNameSearch').val();
            }
        }
                 
            //折后价
        var discountMoneyStartSearchInput = $('#discountMoneyStartSearch');
        if(discountMoneyStartSearchInput != null){
            var discountMoneyStartSearchValue = discountMoneyStartSearchInput.val();
            if( discountMoneyStartSearchValue  != 0){
                searchForm.discountMoneyStart = discountMoneyStartSearchValue;
            }
        }
        var discountMoneyEndSearchInput = $('#discountMoneyEndSearch');
        if(discountMoneyEndSearchInput != null){
            var discountMoneyEndSearchValue = discountMoneyEndSearchInput.val();
            if( discountMoneyEndSearchValue  != 0){
                searchForm.discountMoneyEnd = discountMoneyEndSearchValue;
            }
        }
     
        var insertTimeStartSearch = $('#insertTimeStartSearch');
        if( insertTimeStartSearch != null){
            if (insertTimeStartSearch.val() != null && insertTimeStartSearch.val() != '') {
                searchForm.insertTimeStart = $('#insertTimeStartSearch').val();
            }
        }
        var insertTimeEndSearch = $('#insertTimeEndSearch');
        if( insertTimeEndSearch != null){
            if (insertTimeEndSearch.val() != null && insertTimeEndSearch.val() != '') {
                searchForm.insertTimeEnd = $('#insertTimeEndSearch').val();
            }
        }
            getDataList();
    }

    // 获取数据列表
    function getDataList() {
        http("buyOrder/page", "GET", {
            page: pageIndex,
            limit: pageSize,
            sort: sortColumn,
            order: sortOrder,
            //本表的
            orderBianhao: searchForm.orderBianhao,
            caozuoName: searchForm.caozuoName,
            discountMoneyStart: searchForm.discountMoneyStart,
            discountMoneyEnd: searchForm.discountMoneyEnd,
            insertTimeStart: searchForm.insertTimeStart,
            insertTimeEnd: searchForm.insertTimeEnd,
            //级联表的
                        huiyuanName: searchForm.huiyuanName,
                        huiyuanPhone: searchForm.huiyuanPhone,
                        huiyuanIdNumber: searchForm.huiyuanIdNumber,
                        sexTypes: searchForm.sexTypes,
            jifenStart: searchForm.jifenStart,
                                jifenEnd: searchForm.jifenEnd,
                        jifenTypes: searchForm.jifenTypes,
                        huiyuanTypes: searchForm.huiyuanTypes,


    }, (res) => {
            if(res.code == 0)
            {
                clear();
                $("#thisTbody").html("");
                dataList = res.data.list;
                totalPage = res.data.totalPage;
                //var tbody = document.getElementById('tbMain');
                for (var i = 0; i < dataList.length; i++) { //遍历一下表格数据  
                    var trow = setDataRow(dataList[i], i); //定义一个方法,返回tr数据 
                    $('#thisTbody').append(trow);
                }
                pagination(); //渲染翻页组件
                getRoleButtons();// 权限按钮控制
            }
        })
        ;
    }

    // 渲染表格数据
    function setDataRow(item, number) {
        //创建行 
        var row = document.createElement('tr');
        row.setAttribute('class', 'useOnce');
        //创建勾选框
        var checkbox = document.createElement('td');
        var checkboxDiv = document.createElement('div');
        checkboxDiv.setAttribute("class", "custom-control custom-checkbox");
        var checkboxInput = document.createElement('input');
        checkboxInput.setAttribute("class", "custom-control-input");
        checkboxInput.setAttribute("type", "checkbox");
        checkboxInput.setAttribute('name', 'chk');
        checkboxInput.setAttribute('value', item.id);
        checkboxInput.setAttribute("id", number);
        checkboxDiv.appendChild(checkboxInput);
        var checkboxLabel = document.createElement('label');
        checkboxLabel.setAttribute("class", "custom-control-label");
        checkboxLabel.setAttribute("for", number);
        checkboxDiv.appendChild(checkboxLabel);
        checkbox.appendChild(checkboxDiv);
        row.appendChild(checkbox)


                //姓名
        var huiyuanNameCell = document.createElement('td');
        huiyuanNameCell.innerHTML = item.huiyuanName;
        row.appendChild(huiyuanNameCell);


                //手机号
        var huiyuanPhoneCell = document.createElement('td');
        huiyuanPhoneCell.innerHTML = item.huiyuanPhone;
        row.appendChild(huiyuanPhoneCell);


                //身份证号
        var huiyuanIdNumberCell = document.createElement('td');
        huiyuanIdNumberCell.innerHTML = item.huiyuanIdNumber;
        row.appendChild(huiyuanIdNumberCell);



        //订单编号
        var orderBianhaoCell = document.createElement('td');
        orderBianhaoCell.innerHTML = item.orderBianhao;
        row.appendChild(orderBianhaoCell);


        //操作人姓名
        var caozuoNameCell = document.createElement('td');
        caozuoNameCell.innerHTML = item.caozuoName;
        row.appendChild(caozuoNameCell);


        //原总价
        var originalMoneyCell = document.createElement('td');
        originalMoneyCell.innerHTML = item.originalMoney;
        row.appendChild(originalMoneyCell);


        //折后价
        var discountMoneyCell = document.createElement('td');
        discountMoneyCell.innerHTML = item.discountMoney;
        row.appendChild(discountMoneyCell);


        //订单添加时间
        var insertTimeCell = document.createElement('td');
        insertTimeCell.innerHTML = item.insertTime;
        row.appendChild(insertTimeCell);



        //每行按钮
        var btnGroup = document.createElement('td');

        // //详情按钮
        // var detailBtn = document.createElement('button');
        // var detailAttr = "detail(" + item.id + ')';
        // detailBtn.setAttribute("type", "button");
        // detailBtn.setAttribute("class", "btn btn-info btn-sm 查看");
        // detailBtn.setAttribute("onclick", detailAttr);
        // detailBtn.innerHTML = "查看"
        // btnGroup.appendChild(detailBtn)
        // //修改按钮
        // var editBtn = document.createElement('button');
        // var editAttr = 'edit(' + item.id + ')';
        // editBtn.setAttribute("type", "button");
        // editBtn.setAttribute("class", "btn btn-warning btn-sm 修改");
        // editBtn.setAttribute("onclick", editAttr);
        // editBtn.innerHTML = "修改"
        // btnGroup.appendChild(editBtn)

        //查看订单详情
        var detailListBtn = document.createElement('button');
        var detailListAttr = "detailList(" + item.id+')';
        detailListBtn.setAttribute("type", "button");
        detailListBtn.setAttribute("class", "btn btn-info btn-sm 查看");
        detailListBtn.setAttribute("onclick", detailListAttr);
        detailListBtn.innerHTML = "查看详情"
        btnGroup.appendChild(detailListBtn);
        //删除按钮
        var deleteBtn = document.createElement('button');
        var deleteAttr = 'remove(' + item.id + ')';
        deleteBtn.setAttribute("type", "button");
        deleteBtn.setAttribute("class", "btn btn-danger btn-sm 删除");
        deleteBtn.setAttribute("onclick", deleteAttr);
        deleteBtn.innerHTML = "删除"
        btnGroup.appendChild(deleteBtn);

        row.appendChild(btnGroup)
        return row;
    }


        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        // 整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            /*if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }*/
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }

        //整数
        function discountMoneyChickValue(e){
            var this_val = e.value || 0;
            if(this_val == 0){
                e.value = "";
                alert("0不允许输入");
                return false;
            }
            var reg=/^[0-9]*$/;
            if(!reg.test(this_val)){
                e.value = "";
                alert("输入不合法");
                return false;
            }
        }


    // 翻页
    function pageNumChange(val) {
        if (val == 'pre') {
            pageIndex--;
        } else if (val == 'next') {
            pageIndex++;
        } else {
            pageIndex = val;
        }
        getDataList();
    }

    // 下载
    function download(url) {
        window.open(url);
    }

    // 渲染翻页组件
    function pagination() {
        var beginIndex = pageIndex;
        var endIndex = pageIndex;
        var point = 4;
        //计算页码
        for (var i = 0; i < 3; i++) {
            if (endIndex == totalPage) {
                break;
            }
            endIndex++;
            point--;
        }
        for (var i = 0; i < 3; i++) {
            if (beginIndex == 1) {
                break;
            }
            beginIndex--;
            point--;
        }
        if (point > 0) {
            while (point > 0) {
                if (endIndex == totalPage) {
                    break;
                }
                endIndex++;
                point--;
            }
            while (point > 0) {
                if (beginIndex == 1) {
                    break;
                }
                beginIndex--;
                point--
            }
        }
        // 是否显示 前一页 按钮
        if (pageIndex > 1) {
            $('#tableId_previous').show();
        } else {
            $('#tableId_previous').hide();
        }
        // 渲染页码按钮
        for (var i = beginIndex; i <= endIndex; i++) {
            var pageNum = document.createElement('li');
            pageNum.setAttribute('onclick', "pageNumChange(" + i + ")");
            if (pageIndex == i) {
                pageNum.setAttribute('class', 'paginate_button page-item active useOnce');
            } else {
                pageNum.setAttribute('class', 'paginate_button page-item useOnce');
            }
            var pageHref = document.createElement('a');
            pageHref.setAttribute('class', 'page-link');
            pageHref.setAttribute('href', '#');
            pageHref.setAttribute('aria-controls', 'tableId');
            pageHref.setAttribute('data-dt-idx', i);
            pageHref.setAttribute('tabindex', 0);
            pageHref.innerHTML = i;
            pageNum.appendChild(pageHref);
            $('#tableId_next').before(pageNum);
        }
        // 是否显示 下一页 按钮
        if (pageIndex < totalPage) {
            $('#tableId_next').show();
            $('#tableId_next a').attr('data-dt-idx', endIndex + 1);
        } else {
            $('#tableId_next').hide();
        }
        var pageNumInfo = "当前第 " + pageIndex + " 页，共 " + totalPage + " 页";
        $('#tableId_info').html(pageNumInfo);
    }

    // 跳转到指定页
    function toThatPage() {
        //var index = document.getElementById('pageIndexInput').value;
        if (index < 0 || index > totalPage) {
            alert('请输入正确的页码');
        } else {
            pageNumChange(index);
        }
    }

    // 全选/全不选
    function chooseAll() {
        checkAll = !checkAll;
        var boxs = document.getElementsByName("chk");
        for (var i = 0; i < boxs.length; i++) {
            boxs[i].checked = checkAll;
        }
    }

    // 批量删除
    function deleteMore() {
        ids = []
        var boxs = document.getElementsByName("chk");
        for (var i = 0; i < boxs.length; i++) {
            if (boxs[i].checked) {
                ids.push(boxs[i].value)
            }
        }
        if (ids.length == 0) {
            alert('请勾选要删除的记录');
        } else {
            remove(ids);
        }
    }

    // 删除
    function remove(id) {
        var mymessage = confirm("删除会级联删除订单详情内容,确定要删除吗？");
        if (mymessage == true) {
            var paramArray = [];
            if (id == ids) {
                paramArray = id;
            } else {
                paramArray.push(id);
            }
            httpJson("buyOrder/delete", "POST", paramArray, (res) => {
                if(res.code == 0
        )
            {
                getDataList();
                alert('删除成功');
            }
        })
            ;
        }
        else {
            alert("已取消操作");
        }
    }

    // 用户登出
    <%@ include file="../../static/logout.jsp"%>

    //修改
    function edit(id) {
        window.sessionStorage.setItem('updateId', id)
        window.location.href = "add-or-update.jsp"
    }

    //清除会重复渲染的节点
    function clear() {
        var elements = document.getElementsByClassName('useOnce');
        for (var i = elements.length - 1; i >= 0; i--) {
            elements[i].parentNode.removeChild(elements[i]);
        }
    }

    //添加
    function add() {
        window.sessionStorage.setItem("addbuyOrder", "addbuyOrder");
        window.location.href = "add-or-update.jsp"
    }

    //报表
    function graph() {
        window.location.href = "graph.jsp"
    }

    // 查看详情
    function detail(id) {
        window.sessionStorage.setItem("updateId", id);
        window.location.href = "info.jsp";
    }

    //填充级联表搜索下拉框
                                         
                     
                     
                     
        function sexTypesSelectSearch() {
            var sexTypesSelectSearch = document.getElementById('sexTypesSelectSearch');
            if(sexTypesSelectSearch != null) {
                sexTypesSelectSearch.add(new Option('-请选择-',''));
                if (sexTypesOptions != null && sexTypesOptions.length > 0){
                    for (var i = 0; i < sexTypesOptions.length; i++) {
                            sexTypesSelectSearch.add(new Option(sexTypesOptions[i].indexName, sexTypesOptions[i].codeIndex));
                    }
                }
            }
        }
                                                                                                     
                     
        function jifenTypesSelectSearch() {
            var jifenTypesSelectSearch = document.getElementById('jifenTypesSelectSearch');
            if(jifenTypesSelectSearch != null) {
                jifenTypesSelectSearch.add(new Option('-请选择-',''));
                if (jifenTypesOptions != null && jifenTypesOptions.length > 0){
                    for (var i = 0; i < jifenTypesOptions.length; i++) {
                            jifenTypesSelectSearch.add(new Option(jifenTypesOptions[i].indexName, jifenTypesOptions[i].codeIndex));
                    }
                }
            }
        }
                     
        function huiyuanTypesSelectSearch() {
            var huiyuanTypesSelectSearch = document.getElementById('huiyuanTypesSelectSearch');
            if(huiyuanTypesSelectSearch != null) {
                huiyuanTypesSelectSearch.add(new Option('-请选择-',''));
                if (huiyuanTypesOptions != null && huiyuanTypesOptions.length > 0){
                    for (var i = 0; i < huiyuanTypesOptions.length; i++) {
                            huiyuanTypesSelectSearch.add(new Option(huiyuanTypesOptions[i].indexName, huiyuanTypesOptions[i].codeIndex));
                    }
                }
            }
        }

    //填充本表搜索下拉框
         
     
                 
     
    
    //查询级联表搜索条件所有列表
        function sexTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=sex_types", "GET", {}, (res) => {
                if(res.code == 0){
                    sexTypesOptions = res.data.list;
                }
            });
        }
        function jifenTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=jifen_types", "GET", {}, (res) => {
                if(res.code == 0){
                    jifenTypesOptions = res.data.list;
                }
            });
        }
        function huiyuanTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=huiyuan_types", "GET", {}, (res) => {
                if(res.code == 0){
                    huiyuanTypesOptions = res.data.list;
                }
            });
        }

    //查询当前表搜索条件所有列表


    // 查看购买订单详情
    function detailList(orderId) {
        id=orderId;
        $('#buyOrderListModal').modal('show');
    }

    $('#buyOrderListModal').on('show.bs.modal', function () {

        var orderBianhao = null;
        // 查询购买订单详情
        http("buyOrder/info/"+id, "GET", {}, (res) => {
            if(res.code == 0){
                orderBianhao = res.data.orderBianhao;
                document.getElementById("originalMoney").innerHTML=res.data.originalMoney;
                document.getElementById("discountMoney").innerHTML=res.data.discountMoney;
            }
        });

        //查询购买订单列表详情
        http("buyOrderList/page", "GET", {
            page: 1,
            limit: 100,
            sort: sortColumn,
            order: sortOrder,
            //本表的
            buyOrderId: orderBianhao,
        }, (res) => {
            if(res.code == 0){
                var list = res.data.list;
                for (var i = 0; i < list.length; i++) { //遍历一下表格数据  
                    var trow = setBuyOrderListDataRow(list[i]); //定义一个方法,返回tr数据 
                    $('#buyOrderListTbody').append(trow);
                }
            }else{
                alert("查不到该订单的详情");
            }
        });
    })

    $('#buyOrderListModal').on('hide.bs.modal', function () {
        id=null;
        $("#originalMoney").val("");
        $("#discountMoney").val("");
        $("#buyOrderListTbody").html("");
    });

    // 添加当前购买订单中的物资到列表中
    function setBuyOrderListDataRow(item) {
        //创建行 
        var row = document.createElement('tr');
        // row.setAttribute("id","rowId"+item.id);
        //物资名称
        var goodsNameCell = document.createElement('td');
        goodsNameCell.innerHTML = item.goodsName;
        row.appendChild(goodsNameCell);


        //操作数量
        var orderNumberCell = document.createElement('td');
        orderNumberCell.innerHTML = item.orderNumber;
        row.appendChild(orderNumberCell);



        //单价
        var danjiaCell = document.createElement('td');
        danjiaCell.innerHTML = item.danjia;
        row.appendChild(danjiaCell);


        //总价
        var zongCell = document.createElement('td');
        zongCell.innerHTML = item.danjia * item.orderNumber;
        row.appendChild(zongCell);


        //单位
        var danweiCell = document.createElement('td');
        danweiCell.innerHTML = item.danwei;
        row.appendChild(danweiCell);
        return row;
    }



    //新增订单
    function addBuyOrder() {
        $('#buyOrderModal').modal('show');
    }

    $('#buyOrderModal').on('show.bs.modal', function () {
        goodsSelect();
        huiyuanSelect();
        initializationgoodsSelect();
        initializationhuiyuanSelect();
        $(".selectpicker" ).selectpicker('refresh');
    })
    $('#buyOrderModal').on('hide.bs.modal', function () {
        $("#buyOrderTbody").html("");
        $("#goodsSelect").empty();
        $("#huiyuanSelect").empty();
        $("#huiyuanName").val("");
        $("#huiyuanPhone").val("");
        $("#huiyuanIdNumber").val("");
        document.getElementById("buyOriginalMoney").innerHTML="";
        document.getElementById("buyDiscountMoney").innerHTML="";
        huiyuan=null;
        $(".selectpicker" ).selectpicker('refresh');
    })
    function goodsSelect() {
        //填充下拉框选项
        http("goods/page?page=1&limit=100&sort=&order=", "GET", {}, (res) => {
            if(res.code == 0){
                goodsOptions = res.data.list;
            }
        });
    }

    function initializationgoodsSelect() {
        var goodsSelect = document.getElementById('goodsSelect');
        if(goodsSelect != null && goodsOptions != null  && goodsOptions.length > 0 ) {
            for (var i = 0; i < goodsOptions.length; i++) {
                goodsSelect.add(new Option("物资名:"+goodsOptions[i].goodsName+" 单位:"+goodsOptions[i].danwei, goodsOptions[i].id));
            }
        }
    }

    function huiyuanSelect() {
        //填充下拉框选项
        http("huiyuan/page?page=1&limit=100&sort=&order=&huiyuanTypes=1", "GET", {}, (res) => {
            if(res.code == 0){
                huiyuanOptions = res.data.list;
            }
        });
    }

    function initializationhuiyuanSelect() {
        var huiyuanSelect = document.getElementById('huiyuanSelect');
        if(huiyuanSelect != null && huiyuanOptions != null  && huiyuanOptions.length > 0 ) {
            for (var i = 0; i < huiyuanOptions.length; i++) {
                huiyuanSelect.add(new Option("姓名:"+huiyuanOptions[i].huiyuanName+" 手机号:"+huiyuanOptions[i].huiyuanPhone, huiyuanOptions[i].id));
            }
        }

        $("#huiyuanSelect").change(function(e) {
            var id = e.target.value;
            http("huiyuan/info/"+id, "GET", {}, (res) => {
                if(res.code == 0){
                    huiyuan = res.data;
                    $("#huiyuanName").val(res.data.huiyuanName);
                    $("#huiyuanPhone").val(res.data.huiyuanPhone);
                    $("#huiyuanIdNumber").val(res.data.huiyuanIdNumber);
                }
            });
        });

    }


    function addBuyOrderOne() {
        var id = document.getElementById("goodsSelect").options[document.getElementById("goodsSelect").selectedIndex].value;//获取当前选择项的值.
        if(id ==null || id=="" || id<=0){
            alert("请选择商品");
            return;
        }
        if( $("#rowId"+id).val() == null ){
            http("goods/info/"+id, "GET", {}, (res) => {
                if(res.code == 0){
                    var span =  setBuyOrderDataRow(res.data);
                    $('#buyOrderTbody').append(span);
                }else{
                    alert("添加商品失败,请联系管理员查看详情");
                    return;
                }
            });
        }else{
            alert("您已经添加过此物资");
        }
    }

    // 添加物资到待提交列表
    function setBuyOrderDataRow(item) {
        //创建行 
        var row = document.createElement('tr');
        row.setAttribute("id","rowId"+item.id);
        //物资名称
        var goodsNameCell = document.createElement('td');
        goodsNameCell.innerHTML = item.goodsName;
        row.appendChild(goodsNameCell);


        //现有物资数量
        var goodsNumberCell = document.createElement('td');
        goodsNumberCell.setAttribute("id","td"+item.id);
        goodsNumberCell.innerHTML = item.goodsNumber;
        row.appendChild(goodsNumberCell);

        //单价
        var danjiaCell = document.createElement('td');
        danjiaCell.setAttribute("id","danjiatd"+item.id);
        danjiaCell.innerHTML = item.danjia;
        row.appendChild(danjiaCell);


        //操作数量
        var inputCell = document.createElement('td');
        var input = document.createElement("input");
        input.setAttribute("type","input") ;
        input.setAttribute("id","inputId"+item.id) ;
        input.setAttribute("name","inputNumber") ;
        input.setAttribute("class","form-control") ;
        input.setAttribute("value",1) ;
        input.setAttribute("onchange","chickGoodsNumber(this"+","+item.id+")") ;
        inputCell.appendChild(input)
        row.appendChild(inputCell);


        //单位
        var danweiCell = document.createElement('td');
        danweiCell.innerHTML = item.danwei;
        row.appendChild(danweiCell);

        //总价
        var zongjiaCell = document.createElement('td');
        zongjiaCell.setAttribute("id","zongjiatd"+item.id);
        zongjiaCell.setAttribute("name","zongjia");
        zongjiaCell.innerHTML = item.danjia;
        row.appendChild(zongjiaCell);

        //每行按钮
        var btnGroup = document.createElement('td');
        //删除按钮
        var deleteBtn = document.createElement('button');
        // var deleteAttr = 'removeInOutGoods(' + item.id + ')';
        deleteBtn.setAttribute("type", "button");
        deleteBtn.setAttribute("class", "btn btn-danger btn-sm 删除");
        deleteBtn.setAttribute("onclick","removeBuyGoods("+item.id+")");
        deleteBtn.innerHTML = "删除"
        btnGroup.appendChild(deleteBtn)

        row.appendChild(btnGroup)
        return row;
    }

    function chickGoodsNumber(e,id){
        var this_val = e.value || 0;
        if(this_val == 0){
            e.value = 1;
            alert("购买数量为0无意义");
            return false;
        }
        var reg=/^[1-9][0-9]*$/;
        if(!reg.test(this_val)){
            e.value = 1;
            alert("只能输入正整数数字");
            return false;
        }
        var tdid = "#td"+id;
        var number = $(tdid).text();
        if(number==null || number==""){
            alert("库存不正确,请进入物资中修改该商品库存");
            return false;
        }
        if((parseInt(number)-parseInt(this_val))<0){
            e.value = 1;
            alert("购买数量不能大于库存数量");
            return false;
        }


        //把总价算出来填充上去
        var danjia=document.getElementById("danjiatd"+id).innerText;
        document.getElementById("zongjiatd"+id).innerHTML=parseInt(danjia) * parseInt(this_val);

        //填充原来总价
        var elementsByName = document.getElementsByName("zongjia");
        var originalMoney =0;
        for (var i = 0; i < elementsByName.length; i++) {
            var a = elementsByName[i].innerText;
            originalMoney = originalMoney+parseInt(a);
        }

        if(huiyuan == null ){
            alert("请选择会员");
            e.value = 1;
            return false;
        }
        var jifenTypes = huiyuan.jifenTypes;
        var discountMoney =0;
        if(jifenTypes ==1 ){
            //钻石会员 8折
            discountMoney = originalMoney*0.8;
        }else if(jifenTypes == 2 ){
            //黄金会员 85折
            discountMoney = originalMoney*0.85;
        }else if(jifenTypes == 3 ){
            //白银会员 9折
            discountMoney = originalMoney*0.90;
        }else if(jifenTypes == 4 ){
            //青铜会员 95折
            discountMoney = originalMoney*0.95;
        }else{
            alert("会员未知错误,请联系管理员");
        }
        document.getElementById("buyOriginalMoney").innerHTML=originalMoney;
        document.getElementById("buyDiscountMoney").innerHTML=discountMoney;
    }

    function removeBuyGoods(id) {
        var rowId = "#rowId"+ id;
        $(rowId).remove();
    }

    //入库和出库操作
    function submitBuyOrder() {
        var elementsByName = document.getElementsByName("inputNumber");
        var flag=false;
        let map = {};
        for (var i = 0; i < elementsByName.length; i++) { //遍历一下表格数据  
            var value = elementsByName[i].value;
            if(value ==null || value =="" ||  value =="null"){
                flag=true;
            }else{
                var id = parseInt(elementsByName[i].id.replace("inputId",""));
                map[id]=parseInt(value);
            }
        }
        if(flag){
            alert("数量中有空或者为0情况");
            return false;
        }

        if(map == null || Object.keys(map).length==0){
            alert("您没有添加物资");
            return false;
        }
        var buyOriginalMoney = document.getElementById("buyOriginalMoney").innerText;
        var buyDiscountMoney = document.getElementById("buyDiscountMoney").innerText;
        if(buyOriginalMoney == null || buyOriginalMoney == "" || buyOriginalMoney=="null" || buyDiscountMoney == null || buyDiscountMoney == "" || buyDiscountMoney=="null"){
            alert("原总价或者折后价计算价格为空,请联系管理员");
            return false;
        }
        httpJson("buyOrder/buyOrder", "POST", {
            map:map,
        }, (res) => {
            if(res.code == 0){
                alert("添加订单成功");
                $('#buyOrderModal').modal('hide');
                getDataList();
            }else{
                alert(res.msg);
            }
        });
    }




    $(document).ready(function () {
        //激活翻页按钮
        $('#tableId_previous').attr('class', 'paginate_button page-item previous')
        $('#tableId_next').attr('class', 'paginate_button page-item next')
        //隐藏原生搜索框
        $('#tableId_filter').hide()
        //设置右上角用户名
        $('.dropdown-menu h5').html(window.sessionStorage.getItem('username'))
        //设置项目名
        $('.sidebar-header h3 a').html(projectName)
        setMenu();
        init();

        //查询级联表的搜索下拉框
        sexTypesSelect();
        jifenTypesSelect();
        huiyuanTypesSelect();


        //查询当前表的搜索下拉框
        getDataList();

        //搜素下拉框赋值
        sexTypesSelectSearch();
        jifenTypesSelectSearch();
        huiyuanTypesSelectSearch();
        <%@ include file="../../static/myInfo.js"%>
    });
</script>
</body>

</html>