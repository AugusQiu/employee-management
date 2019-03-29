package com.employee.controller;

import com.employee.bean.Employee;
import com.employee.bean.Msg;
import com.employee.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//处理员工CRUD请求
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

//    员工新增保存
    @RequestMapping(value = "/emp",method= RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors){
                System.out.println("错误的字段名:"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.succcess();
        }
    }

    @ResponseBody
    @RequestMapping("/checkId")
    public Msg checkId(@RequestParam("empId")Integer empId){
       boolean b = employeeService.checkId(empId);
       if(b){
           return Msg.succcess();
       }else{
           return Msg.fail();
       }
    }

//  如果要支持JSR303校验，就要导入Hibernate-Validator包



    @RequestMapping("/emps")
//    @ResponseBody自动转json字符串,需要导入jackson包
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue="1")Integer pn,
                                    Model model){
        //引入PageHelper分页插件,参数页码和每页数据大小
        PageHelper.startPage(pn,5);
//        PageHelper.order("emp_id asc");
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        return Msg.succcess().add("pageInfo",page);
    }

//员工更新方法
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.succcess();
    }

//    根据id查询员工
     @ResponseBody
     @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
     public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.succcess().add("emp",employee);
     }

//    // 批量删除员工
//    @ResponseBody
//    @RequestMapping(value = "/emp/{id}",method=RequestMethod.DELETE)
//    public Msg deleteEmpById(@PathVariable("id")Integer id){
//        employeeService.deleteEmp(id);
//        return Msg.succcess();
//    }
//     删除员工 批量/单个二合一
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method=RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            System.out.println(ids);
            List<Integer> del_ids= new ArrayList<>();
           String[] str_ids = ids.split("-");
//          组装id的集合
            for(String string:str_ids){
               del_ids.add(Integer.parseInt(string));
            }
          employeeService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }

        return Msg.succcess();
    }
//    查询员工数据(分页查询)
//    @RequestMapping(value = "/emps")
//    public String getEmps(@RequestParam(value = "pn",defaultValue="1")Integer pn,
//                           Model model){
//        //引入PageHelper分页插件,参数页码和每页数据大小
//        PageHelper.startPage(pn,5);
//        //startPage后面紧跟的这个查询就是一个分页查询
//        List<Employee> emps = employeeService.getAll();
//       //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
//        //封装了详细的分页信息，包括我们查询出来的数据，传入连续显示的页数
//        PageInfo page = new PageInfo(emps,5);
//        model.addAttribute("pageInfo",page);
//        return "list";
//    }
}
