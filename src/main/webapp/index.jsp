<%--
  Created by IntelliJ IDEA.
  User: 七夏
  Date: 2020/4/12
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工信息</title>
    <%--web路径:
        不以“/”开始的相对路径寻找资源时，会以当前资源路径为基准
        以“/”开始的相对路径寻找资源，以服务器的路径为标准( http://localhost:8080)，需要加上项目名称：
            http://localhost:8080/SSM_CRUD
    --%>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.0.3.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>


</head>

<body>

<!--员工修改的模态框-->
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input"
                                   placeholder="qixia.song@foxmail.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2 control-label">Gender</label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!--员工添加的模态框-->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input"
                                   placeholder="qixia.song@foxmail.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2 control-label">Gender</label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<!--显示页面-->
<div class="container">

    <%--标题行--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%--新增，删除按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_model_btn">添加</button>
            <button class="btn btn-danger" id="emp_delete_btn">删除</button>
        </div>
    </div>

    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all" />
                    </th>
                    <th>#</th>
                    <th>EmpName</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>DeptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="emps_table"></tbody>
            </table>
        </div>
    </div>

    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area"></div>

        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>

<script type="text/javascript">

    var totalRecord,currentPge;

    //1.页面加载完成后，直接发送Ajax请求，要到分页数据
    $(function () {
        //页面加载完毕，第一次直接去第一页
        toPage(1);
    });

    function toPage(pageNum) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pageNum=" + pageNum,
            type: "get",
            success: function (res) {
                //console.log(res);
                //1.解析并显示员工数据
                build_emps_table(res);

                //2.解析并显示分页信息
                build_page_info(res);

                //3.解析分页条数据
                build_page_nav(res);
            }
        });
    };

    //解析表格中员工数据
    function build_emps_table(res) {
        //清空之前的数据
        $("#emps_table").empty();

        var emps = res.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var email = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加自定义属性，表示当前员工的id
            editBtn.attr("edit-id", item.empId);

            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加自定义属性，表示当前删除的员工id
            deleteBtn.attr("del-id",item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);

            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd).append(email).append(deptName).append(btnTd).appendTo("#emps_table");
        })
    };

    //解析分页信息
    function build_page_info(res) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + res.extend.pageInfo.pageNum + "页，总" + (res.extend.pageInfo.pages) + "页，共" + res.extend.pageInfo.total + "条记录");
        totalRecord = res.extend.pageInfo.total;
        currentPge = res.extend.pageInfo.pageNum;
    };

    //解析分页条数据，点击后产生连接
    function build_page_nav(res) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (res.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //添加点击事件
            firstPageLi.click(function () {
                toPage(1);
            });
            prePageLi.click(function () {
                toPage(res.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (res.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                toPage(res.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                toPage(res.extend.pageInfo.pages);
            });
        }

        //添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);

        //遍历给ul添加页码提示
        $.each(res.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (res.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                toPage(item);
            });
            ul.append(numLi);
        })
        //添加下一页，和末页提示
        ul.append(nextPageLi).append(lastPageLi);
        //将构建的ul添加到nav标签中
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    };

    //点击新增按钮弹出模态框
    $("#emp_add_model_btn").click(function () {
        //清空表单数据以及样式
        reset_form("#empAddModel form");
        //应该先发送Ajax请求，查出部门信息
        getDepts("#empAddModel select");
        //弹出模态框
        $("#empAddModel").modal({
            backdrop: "static"
        });
    });

    //查询所有的部门信息，并显示在下拉列表中
    function getDepts(element) {
        //清空下拉列表的值
        $(element).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "get",
            success: function (res) {
                $.each(res.extend.depts, function (index, item) {
                    var option = $("<option></option>").append(item.deptName).attr("value", item.deptId)
                    option.appendTo(element);
                })
            }
        });
    };

    function show_validate_msg(element, status, msg) {
        //清除当前元素的校验状态
        $(element).parent().removeClass("has-success has-error");
        $(element).next("span").text("");
        if (status == "success") {
            $(element).parent().addClass("has-success");
            $(element).next("span").text(msg);
        } else if (status == "error") {
            $(element).parent().addClass("has-error");
            $(element).next("span").text(msg);
        }
    }

    //校验表单数据
    function validate_add_form() {
        //1.获取要校验的数据
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error", "用户名为2-5位中文或6-16位英文或数字");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        //2.校验邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("请输入正确的邮箱地址");
            show_validate_msg("#email_add_input", "error", "请输入正确的邮箱地址");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    };

    //清空表单样式及数据
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    };


    $("#empName_add_input").change(function () {
        //发送Ajax请求，校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            type: "post",
            data: "empName=" + empName,
            success: function (res) {
                if (res.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-value", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", res.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-value", "error");
                }
            }
        });
    });

    $("#emp_save_btn").click(function () {
        /* if (!validate_add_form()) {
             return false;
         }*/
        //判断之前的用户名校验是否成功
        if ($(this).attr("ajax-value") == "error") {
            return false;
        }
        //1.将模态框中的数据提交到服务器进行保存
        //2.发送Ajax请求保存员工信息
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "post",
            data: $("#empAddModel form").serialize(),
            success: function (res) {
                //alert(res.msg);
                if (res.code == 100) {
                    //1.关闭模态框
                    $("#empAddModel").modal('hide');
                    //2.来到最后一页显示
                    toPage(totalRecord);
                } else {
                    //显示失败信息
                    //console.log(res);
                    if (undefined != res.extend.errorFields.email) {
                        //显示员工的邮箱错误信息
                        show_validate_msg("#email_add_input", "error", res.extend.errorFields.email);
                    }
                    if (undefined != res.extend.errorFields.empName) {
                        //显示员工的名字错误信息
                        show_validate_msg("#empName_add_input", "error", res.extend.errorFields.empName);
                    }
                }
            }
        })
    });

    //使用on绑定编辑按钮
    $(document).on("click", ".edit_btn", function () {
        //弹出模态框
        $("#empUpdateModel").modal({
            backdrop: "static"
        });
        //alert("edit_btn");

        //1.查询部门信息，并显示部门列表
        getDepts("#empUpdateModel select");
        //2.查询员工信息
        getEmp($(this).attr("edit-id"));

        //3.将员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

    });

    //绑定删除按钮事件（单个删除）
    $(document).on("click",".delete_btn",function () {
        //1.弹出确认对话框
        //alert($(this).parents("tr").find("td:eq(1)").text());
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if(confirm("您确认删除【"+ empName +"】吗？")){
            //确认后发送Ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/" + empId,
                type:"DELETE",
                success:function (res) {
                    alert(res.msg);
                    //回到本页
                    toPage(currentPge);
                }
            });
        }
    });

    function getEmp(empId) {
        $.ajax({
            url: "${APP_PATH}/emp/" + empId,
            type: "GET",
            success: function (res) {
                //console.log(res);
                var empData = res.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModel input[name=gender]").val([empData.gender]);
                $("#empUpdateModel select").val([empData.dId]);
            }
        });
    };

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //1.验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("请输入正确的邮箱地址");
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //2，发送Ajax请求，保存更新的数据
        $.ajax({
            url: "${APP_PATH}/update/" + $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (res) {
                //alert(res.msg);
                //1.关闭模态框
                $("#empUpdateModel").modal("hide");
                //2.回到本页面
                toPage(currentPge);
            }
        });
    });

    //全选，全不选
    $("#check_all").click(function () {
        //prop修改和读取DOM原生属性的值
       $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //check_item
    $(document).on("click",".check_item",function () {
        //判断当前选中的元素是否为5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    });
    
    //批量删除
    $("#emp_delete_btn").click(function () {
        var empNames = "";
        var del_ids = "";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组装员工id字符串
            del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //取出empNames多余的逗号
        empNames = empNames.substring(0,empNames.length-1);
        del_ids = del_ids.substring(0,del_ids.length-1);
        if(confirm("您确认删除【"+ empNames +"】吗？")){
            //确认后，发送Ajax请求
            $.ajax({
               url:"${APP_PATH}/emp/" + del_ids,
                type:"DELETE",
                success:function (res) {
                    alert(res.msg);
                    //返回当前页面
                    toPage(currentPge);
                }
            });
        }
    });


</script>


</body>
</html>
