package com.qixia.crud.test;

import com.github.pagehelper.PageInfo;
import com.qixia.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author 七夏
 * @create 2020-04-12
 * 使用Spring测试模块提供的测试请求功能，测试crud
 */
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:spring-servlet.xml"})
public class MVCTest {
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;
    @Autowired
    WebApplicationContext wepApplicationContext;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(wepApplicationContext).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求，获取返回值
        MvcResult res = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "5")).andReturn();

        //请求成功以后，请求域中会有PageInfo
        MockHttpServletRequest request = res.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码：" + pageInfo.getPageNum());
        System.out.println("总页码：" + pageInfo.getPages());
        System.out.println("总记录数：" + pageInfo.getTotal());
        System.out.println("页面连续显示的页码：");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int num : nums) {
            System.out.print("  " + num);
        }

        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println("ID:" + employee.getEmpId() + ", Name:" + employee.getEmpName());
        }
    }
}
