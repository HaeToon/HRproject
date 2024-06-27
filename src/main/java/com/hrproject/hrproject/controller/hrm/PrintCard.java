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

@WebServlet("/hrm/print")
public class PrintCard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empNo = Integer.parseInt(req.getParameter("hrmPrintEmpNo"));

        HrmDao hrmDao = new HrmDao();
        HrmDto hrmDto = hrmDao.getHrm(empNo);

        req.setAttribute("printHrmCardDto", hrmDto);
        req.getRequestDispatcher("/WEB-INF/hrm/print.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empNo = Integer.parseInt(req.getParameter("hrmPrintEmpNo"));

        HrmDao hrmDao = new HrmDao();
        HrmDto hrmDto = hrmDao.getHrm(empNo);

        Gson gson = new Gson();
        String json = gson.toJson(hrmDto);

        // JSON 형식으로 응답 설정
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }
}