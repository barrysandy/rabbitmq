﻿<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!doctype html>
<head>
    <title>微信素材列表</title>
    <%@ include file="/WEB-INF/common_andy.jsp" %>
    <script src="${path }/resources/js/plugins/layer/layer.min.js"></script>
    <style>
        .m-table tbody tr td {
            padding: 0 !important;
            vertical-align: middle;
        }

        .status i {
            color: #CCCCCC;
            font-size: 26px;
            width: 26px;
            height: 18px;
            display: block
        }

        table {
            table-layout: fixed;
        }

        #table1 td {
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
        #table1 td:hover{
            text-overflow: clip;
            white-space: normal;
            overflow:visible;
        }
    </style>
    <script>
        function view (id) {
            layer.open({
                type: 2,
                title: '查看详情',
                skin: 'layui-layer-rim',
                area: ['95%', '95%'],
                content: '${path}/wechatMaterial/toView.htm?id='+id
            });
        }

        function add(menuId,parentMenuId){
            layer.open({
                type: 2,
                title: '新增',
                skin: 'layui-layer-rim',
                area: ['95%', '95%'],
                content: '${path}/wechatMaterial/toEdit?menuId='+ menuId + '&parentMenuId=' + parentMenuId
            });
        }

        function edit(id) {
            layer.open({
                type: 2,
                title: '修改',
                skin: 'layui-layer-rim',
                area: ['95%', '95%'],
                content: '${path}/wechatMaterial/toEdit.htm?id='+id
            });
        }

        function confirmDelete(id) {
            layer.open({
                type: 1,
                title: '删除',
                skin: 'layui-layer-rim',
                area: ['300px', '200px'],
                content: '<div style="padding: 42px 112px; font-size: 16px; color: #808080;" >确认删除?</div>',
                btn: ['确认','取消'],
                yes: function(){
                    layer.closeAll();
                    deleted(id);
                },
                btn2: function(){
                    console.log('no');
                }
            });
        }

        function deleted(id) {
            var url = "${path}/wechatMaterial/del.htm";
            $.post(url,{'id':id},function(result){
                if(result.state) {
                    layer.open({
                        type: 1,
                        title: '删除',
                        skin: 'layui-layer-rim',
                        area: ['300px', '200px'],
                        content: '<div style="padding: 42px 112px; font-size: 16px; color: #808080;" >删除成功</div>',
                        btn: ['关闭'],
                        btn2: function(){
                            layer.closeAll();
                        },
                        end: function () {
                            location.reload();
                        }
                    });
                }else{
                    layer.open({
                        type: 1,
                        title: '删除',
                        skin: 'layui-layer-rim',
                        area: ['300px', '200px'],
                        content: '<div style="padding: 42px 112px; font-size: 16px; color: #808080;" >删除失败</div>',
                        end: function () {
                            location.reload();
                        }
                    });
                }
            }, "json");
        }

        /**
         *提交表单
         */
        function submitForm() {
            $("#listForm").submit();
        }
    </script>
</head>
<body>
<div class="g-max">
    <div class="m-tabs head-top style01" id="tabs" an-tabs>
        <div class="m-tabs-content">
            <div class="item f-p-xs activate">
                <div class="g-h-max">
                    <form id="listForm" method="post" action="${path}/wechatMaterial/list.html">
                        <div class="g-layout m-panel u-datagrid f-b f-b-n-b">
                            <div class="layout-head panel-head">
                                <div class=" panel-head-btnbar">
                                    <button class="u-btn sm success" type="button" onClick="add('${menuId}','${parentMenuId}')">
                                        <i class="iconfont">&#xe61f;</i> 新增
                                    </button>
                                </div>
                                <div class=" panel-head-btnbar f-right">
                                    <div class="u-group sm f-m-t-xxss"
                                         style="width:200px; display:inline-block; float:left">
                                        <input type="text" class="u-input u-group-left" name="search" value="${search}"
                                               placeholder="输入关键字...">
                                        <span class=" u-but-group u-group-right">搜索
									<button class="u-but-button" type="button" onclick="sumitForm()"></button> 
									</span>
                                    </div>
                                </div>
                            </div>
                            <div class="layout-center">
                                <table class="m-table" id="table1" an-datagrid style="width:100%">
                                    <thead>
                                    <tr>
                                        <th align="center" style="width:30px">序号</th>
                                        <th style="width:80px" align="center">素材主键ID</th>
                                        <th style="width:80px" align="center">素材描述</th>
                                        <th style="width:80px" align="center">素材类型</th>
                                        <th style="width:80px" align="center">系统服务器material_id</th>
                                        <th style="width:80px" align="center">微信服务器material_id</th>
                                        <th style="width:80px" align="center">创建时间</th>
                                        <th style="width:80px" align="center">更新时间</th>
                                        <th style="width:80px" align="center">状态</th>
                                        <th style="width:80px" align="center">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="bean" items="${pager.list}" varStatus="status">
                                        <tr>
                                            <td align="center">${status.index+1}</td>
                                            <td align="center">${bean.id}</td>
                                            <td align="center">${bean.descM}</td>
                                            <td align="center">${bean.typese}</td>
                                            <td align="center">${bean.url}</td>
                                            <td align="center">${bean.material_id}</td>
                                            <td align="center"><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm" ></fmt:formatDate></td>
                                            <td align="center"><fmt:formatDate value="${bean.updateTime}" pattern="yyyy-MM-dd HH:mm" ></fmt:formatDate></td>
                                            <td align="center">${bean.status}</td>
                                            <td align="center">
                                                <button class="u-btn sm texture f-m-l-xs" title="编辑" type="button"
                                                        onClick="edit('${bean.id}')">
                                                    <i class="iconfont" style="color: blue;">&#xe619;</i>
                                                </button>
                                                <button class="u-btn sm texture f-m-l-xs" title="查看" type="button"
                                                        onClick="view('${bean.id}')">
                                                    <i class="iconfont">&#xe63d;</i>
                                                </button>
                                                <button class="u-btn sm texture f-m-l-xs" title="删除" type="button"
                                                        onClick="deleted('${bean.id}')">
                                                    <i class="iconfont" style="color: red;">&#xe62a;</i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <ui:page pager="${pager}"></ui:page>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
