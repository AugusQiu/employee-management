package com.employee.controller;

import com.employee.bean.Department;
import com.employee.bean.Msg;
import com.employee.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

//处理和部门有关的请求
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
//    查出的所有部门信息
       List<Department> list = departmentService.getDepts();
       return Msg.succcess().add("depts",list);
    }
}
