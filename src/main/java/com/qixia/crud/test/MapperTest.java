package com.qixia.crud.test;

import com.qixia.crud.bean.Department;
import com.qixia.crud.bean.Employee;
import com.qixia.crud.dao.DepartmentMapper;

import com.qixia.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author 七夏
 * @create 2020-04-12
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration 指定spring的配置文件的位置
 * 3.直接Autowire
 * */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;


    @Autowired
    SqlSession sqlSession;
    /**
     * 测试Department
     */
    @Test
    public void testCRUD(){
        /*ClassPathXmlApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
        System.out.println(departmentMapper);
        //插入部门
        /*departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));*/

        //生成员工数据，测试员工插入
        //employeeMapper.insertSelective(new Employee(null,"Tom","M","tom@168.com",1));

        //批量插入多个员工，使用批量操作的SqLsESSION
        /*EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 4) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@qixia.com", 1));
        }*/
        //employeeMapper.deleteByPrimaryKey(1000);
        employeeMapper.updateByPrimaryKeySelective(new Employee(2, "Jerry", "F", "je@qq.com", 2));

    }

}
