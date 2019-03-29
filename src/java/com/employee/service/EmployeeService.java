package com.employee.service;

import com.employee.bean.Employee;
import com.employee.bean.EmployeeExample;
import com.employee.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

//    查询所有员工
    public List<Employee> getAll() {
      return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

//    检验员工id是否可用
    public boolean checkId(Integer empId) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdEqualTo(empId);
        long count = employeeMapper.countByExample(example);
        return  count ==0;
    }
//按照员工id查询员工
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deleteEmp(Integer id) {
          employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
//        delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(ids);
       employeeMapper.deleteByExample(example);
    }
}
