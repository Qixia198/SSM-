package com.qixia.crud.controller;

import com.qixia.crud.bean.Department;
import com.qixia.crud.bean.Msg;
import com.qixia.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author 七夏
 * @create 2020-04-13
 *
 * 处理和部门有关的请求
 *
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门的信息
     */
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        Msg msg = new Msg();
        return Msg.success().add("depts", depts);
    }
}
