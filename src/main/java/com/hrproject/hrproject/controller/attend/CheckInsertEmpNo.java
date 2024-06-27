package com.hrproject.hrproject.controller.attend;

import com.google.gson.Gson;
import com.hrproject.hrproject.dao.AttendDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/attend/insertEmpNoCheck")
public class CheckInsertEmpNo extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String empNo = req.getParameter("empNo");
        int result =0;

        AttendDao attendDao = new AttendDao();
        result =  attendDao.checkEmpNo(empNo);

        Gson gson = new Gson();
        String json = gson.toJson(result);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.write(json);
        out.flush();
    }
}