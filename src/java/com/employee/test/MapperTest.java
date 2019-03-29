package com.employee.test;

import com.employee.bean.Department;
import com.employee.bean.Employee;
import com.employee.dao.DepartmentMapper;
import com.employee.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

//测试dao层的工作,推荐spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
//1,导入SpringTest
//2,@ContextConfiguration指定Spring配置文件的位置
//3，直接AutoWire要使用的组件
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;


    @Test
    public void testCRUD(){
//       原生方法的单元测试
//      1，创建SpringIOC容器
//        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//       2,从容器中获取mapper
//        ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);

//        1，插入几个部门
//        departmentMapper.insertSelective(new Department(1,"开发部"));
//        departmentMapper.insertSelective(new Department(2,"测试部"));

//        2，生成员工数据，插入
       // employeeMapper.insertSelective(new Employee(1001,"jerry","M","jerry@qq.com",1));

//         3,批量插入，批量，使用可以执行批量操作的sqlSession
          EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
          for (int i=0;i<10;i++){
               String uid=UUID.randomUUID().toString().substring(0,5)+i;
              mapper.insertSelective(new Employee(1010+i,uid,"M",uid+"@163.com",1));
          }
    }
}
