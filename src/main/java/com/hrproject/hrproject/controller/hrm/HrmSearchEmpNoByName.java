package com.hrproject.hrproject.controller.hrm;

import com.google.gson.Gson;
import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/hrm/searchEmpNoByName")
public class HrmSearchEmpNoByName extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        System.out.println(searchName);
        HrmDao hrmDao = new HrmDao();
        List<HrmDto>EmpNoListBySearchName = hrmDao.getSearchEmpNoByName(searchName);
        if (EmpNoListBySearchName==null){
            System.out.println("list값 안나옴");
        }else {
            System.out.println(EmpNoListBySearchName.toString());
        }
        Gson gson = new Gson();
        String json = gson.toJson(EmpNoListBySearchName);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(json);
        out.flush();
    }
}
