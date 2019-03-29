<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>

    <%--web路径--%>
    <%--不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题--%>
    <%--以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306),需加上项目名--%>
    <%--http://localhost:3306/employee-management--%>
    <script src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
    <link   rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
</head>
<body>
<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">
                    员工修改
                </h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2  control-label" for="empId">empId:</label>
                            <input type="text" name="empId" class="form-control" id="UpempId" placeholder="empId">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="empName">empName:</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2  control-label" for="email">Email:</label>
                            <input type="email" name="email" class="form-control" id="Upemail" placeholder="Enter email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2 control-label " >gender:</label>
                            <div class="offset-1">
                                <input type="radio" name="gender" id="Upgender1" value="M" checked>男
                                <input type="radio" name="gender" id="Upgender2" value="F">女
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">
                    保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<%--员工添加的模态框--%>
<!-- 模态框（Modal） -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    员工添加
                </h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2  control-label" for="empId">empId:</label>
                            <input type="text" name="empId" class="form-control" id="empId" placeholder="empId">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2 control-label" for="empName">empName:</label>
                            <input type="empName" name="empName" class="form-control" id="empName" placeholder="Enter empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2  control-label" for="email">Email:</label>
                            <input type="email" name="email" class="form-control" id="email" placeholder="Enter email">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-10">
                            <label class="col-sm-2 control-label " >gender:</label>
                            <div class="offset-1">
                                <input type="radio" name="gender" id="gender1" value="M" checked>男
                                <input type="radio" name="gender" id="gender2" value="F">女
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">
                    保存
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <p>员工管理系统</p>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger"  id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>empId</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
            <%--当前${pageInfo.pageNum}页，总共${pageInfo.pages}页，总共${pageInfo.total}条数据--%>
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_info_nav">
            <%--<nav aria-label="Page navigation">--%>
                <%--<ul class="pagination">--%>
                    <%--<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>--%>
                    <%--<c:if test="${pageInfo.hasPreviousPage}">--%>
                        <%--<li>--%>
                            <%--<a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">--%>
                                <%--<span aria-hidden="true">&laquo;</span>--%>
                            <%--</a>--%>
                        <%--</li>--%>
                    <%--</c:if>--%>


                    <%--<c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">--%>
                        <%--<c:if test="${page_Num == pageInfo.pageNum}">--%>
                            <%--<li class="active"><a href="#">${page_Num}</a></li>--%>
                        <%--</c:if>--%>

                        <%--<c:if test="${page_Num != pageInfo.pageNum}">--%>
                            <%--<li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>--%>
                        <%--</c:if>--%>

                    <%--</c:forEach>--%>
                    <%--<c:if test="${pageInfo.hasNextPage}">--%>
                        <%--<li>--%>
                            <%--<a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">--%>
                                <%--<span aria-hidden="true">&raquo;</span>--%>
                            <%--</a>--%>
                        <%--</li>--%>
                    <%--</c:if>--%>
                    <%--<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>--%>
                <%--</ul>--%>
            <%--</nav>--%>


        </div>
    </div>
</div>
<script type="text/javascript">
     var currentPage;
    <%--相当于$(document).ready(function(){ }）--%>
     $(function () {
         to_page(1);
     })
     function to_page(pn){
         $.ajax({
             url:"${APP_PATH}/emps",
             data:"pn="+pn,
             type:"get",
             dataType:"json",
             success:function (result) {
                 //    1,解析并显示员工数据
                 build_emps_table(result);
                 //    2,解析显示分页条
                 build_page_nav(result)
                 //    3,解析显示分页信息
                 build_page_info(result)
             }
         })
     }
    
    function build_emps_table(result) {
        // 清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender =="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary edit_btn").append("编辑");

            //为编辑按钮添加自定义属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId);

            var delBtn  = $("<button></button>").addClass("btn btn-danger delete_btn").append("删除");

            delBtn.attr("del-id",item.empId);


            var btnTd = $("<td></td>").append(editBtn).append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                          .append(empIdTd)
                          .append(empNameTd)
                          .append(genderTd)
                          .append(emailTd)
                          .append(deptNameTd)
                         .append(btnTd)
                         .appendTo("#emps_table tbody")
        })
    }
    function build_page_nav(result) {
         $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总"+
       result.extend.pageInfo.pages+"页，总"+
          result.extend.pageInfo.total +"条记录")

        currentPage = result.extend.pageInfo.pageNum;
    }
    function build_page_info(result) {
        $("#page_info_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("首页").attr("href","#"));
        var prePageLi   = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

        //为元素点击翻页的事件
        firstPageLi.click(function () {
            to_page(1)
        })
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum -1);
        })
        var nextPageLi  = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&raquo;"));
        var lastPageLi  = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages)
        })
        nextPageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum + 1);
        })
        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
       $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {

           var numLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append(item));

           if(result.extend.pageInfo.pageNum == item){
               numLi.addClass("active")
           }
           numLi.click(function () {
               to_page(item);
           });
           ul.append(numLi);
       });
      //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);

       //把ul加入到nav中
       var navEle = $("<nav></nav>").append(ul);

       navEle.addClass("Page navigation");
       navEle.appendTo($("#page_info_nav"))

    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("is-valid is-invalid");
        $(ele).find(".help-block").text("");
    }


     //查出所有的部门信息并显示在下拉列表中
     function getDeps(ele) {
         $(ele).empty();
       $.ajax({
           url:"${APP_PATH}/depts",
           type:"GET",
           dataType:"json",
           success:function (result) {
               // console.log(result)
           //    显示在下拉列表中

               $.each(result.extend.depts,function () {
                    var option = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    option.appendTo($(ele));
               });
               // $("#dId").
           }
       })
     }
     //点击新增按钮弹出模态框
     $("#emp_add_modal_btn").click(function () {
         // 清除表单数据(表单重置)
         reset_form("#empAddModal form")
         // 发送ajax请求，查出部门信息，显示在下拉列表中
         getDeps("#empAddModal select");
         // 弹出模态框
         $("#empAddModal").modal({
             backdrop:"static"
         })
     });
     //使用正则表达式校验表单数据
     function validate_add_form(){
        var empName = $("#empName").val();
        var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            show_validate_msg("#empName","error","用户可以是2-5位中文或者4-16位英文数字组合");
            return false;
        }else{
            show_validate_msg("#empName","success","");
        }
         var email = $("#email").val();
         var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
         if(!regEmail.test(email)){
             show_validate_msg("#email","error","邮箱格式不正确");
             return false;
         }else{
             show_validate_msg("#email","success","");
         }
          return true;

     }

     function show_validate_msg(ele,status,msg){
         //清除当前元素的校验状态
         $(ele).parent().removeClass("is-valid is-invalid");
         $(ele).next("span").text("");
         if("success"==status){
             $(ele).parent().addClass("is-valid");
             $(ele).next("span").text(msg);
         }else if("error" == status){
             $(ele).parent().addClass("is-invalid");
             $(ele).next("span").text(msg);
         }
     }
     //员工id发生改变，发送ajax请求校验id是否可用
     $("#empId").change(function () {
         var empId = $(this)[0].value;
           // console.log(empId);
             $.ajax({
                 url:"${APP_PATH}/checkId",
                 data:"empId="+parseInt(empId),
                 dataType:"json",
                 type:"POST",
                 success:function (result) {
                     // console.log(result);
                    if (result.code==200){
                        show_validate_msg("#empId","success","员工号可用")
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#empId","error","员工号不可用");
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
                 }
             })
     })
     $("#emp_save_btn").click(function () {
         //校验
          if(!validate_add_form()){
              return false;
          }
         // 判断之前的ajax员工号是否校验成功
         if($(this).attr("ajax-va")=="error"){
             return false;
         }
         //表单内容序列化
         $.ajax({
             url:"${APP_PATH}/emp",
             type:"POST",
             dataType:"json",
             data:$("#empAddModal form").serialize(),
             success:function (result) {
                 if (result.code==200){
                     //    保存员工成功 后 关闭模态框 来到最后一页
                     $("#empAddModal").modal('hide');
                     to_page(9999);
                 }else {
                     //显示失败信息
                    console.log(result)
                     if(undefined!=result.extend.errorFields.email){
                         show_validate_msg("#email","error",result.extend.errorFields.email)
                     }
                     if(undefined!=result.extend.errorFields.empName){
                         show_validate_msg("#empName","error",result.extend.errorFields.empName)
                     }

                 }
             }
         })
     })

//    因为ajax的异步性，所以我们在创建按钮之前就绑定了click,所以绑定不上
//    1，可以在创建按钮的时候绑定，2，绑定点击.live()
//    jquery新版没有live,使用on进行代替
    $(document).on('click',".edit_btn",function () {
        //查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        getDeps("#empUpdateModal select");
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
       $("#empUpdateModal").modal({
           backdrop:"static"
       })
    });
     
     //单个删除
     $(document).on("click",".delete_btn",function () {
     //      1,弹出是否确认删除对话框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId   = $(this).attr("del-id");
        if(confirm("确认删除["+empName+"]吗?")){
        //     确认，就发送ajax请求删除即可
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    to_page(currentPage);
                }
            })
        }
     })

     function getEmp(id) {
         $.ajax({
               url:"${APP_PATH}/emp/"+id,
               type:"GET",
               success:function (result) {
                 var empData = result.extend.emp;
                 $("#UpempId").val(empData.empId);
                 $("#empName_update_static").text(empData.empName);
                 $("#Upemail").val(empData.email);
                 $("#empUpdateModal input[name=gender]").val([empData.gender]);
                 $("#empUpdateModal select").val([empData.dId])
               }
         })
     }
     //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否正确
        var email = $("#Upemail").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email","success","");
        }

    //发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            //这里直接用ajax的put,是无法修改成功的
            //问题:请求体中有数据，但是Employee对象封装不上，
            // 原因:Tomcat:tomcat一看是PUT不会封装请求体中的数据，只有POST的请求会封装
            // 1，请求体中的数据，封装成一个map
            // 2,request.getParameter("empName")就会从map中取值
            // 3，SpringMVC封装POJO对象的时候，会把POJO中每个属性的值获取，但现在request.getParamter都获取不到
            //要配置HttpPutFormContentFilter,它的作用就是将请求体中数据解析包装成一个map,request会被重新包装
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
               $("#empUpdateModal").modal("hide");
               to_page(currentPage);
            }
        })
    })

//    完成全选/全不选
    $("#check_all").click(function () {
       // attr获取checked是undefined
       // 我们这些dom原生的属性:attr获取自定义属性的值
       // 推荐prop修改和读取dom原生的值
       $(this).prop("checked");
       $(".check_item").prop("checked",$(this).prop("checked"));
    });

//     check_item
    $(document).on("click",".check_item",function () {
    // 判断当前每页选中的个数是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
          $("#check_all").prop("checked",flag);
    })

//    点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames ="";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {
            empNames +=  $(this).parents("tr").find("td:eq(2)").text()+",";
        //    组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的逗号
        empNames = empNames.substring(0,empNames.length-1);
        //去除empId多余的-号
        del_idstr =del_idstr.substring(0,del_idstr.length-1);
        console.log(del_idstr);
        if (confirm("确认删除["+empNames+"]吗?")){
        //发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    //回到当前页面
                    to_page(currentPage);
                },
                error:function (result) {
                   console.log(result)
                }
            })

        }
    })

</script>
</body>
</html>

