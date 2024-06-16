package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.HrmDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/attend/update")
public class AttendUpdate extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AttendDto attendDto = AttendDto.builder()
                .empNo(Integer.parseInt(req.getParameter("empNo"))) //사원번호
                .atdNo(req.getParameter("atdNo")) //근태번호
                .ename(req.getParameter("ename")) //사원명
                .atdCode(req.getParameter("atdCode")) //근태코드
                .atdNum(Double.parseDouble(req.getParameter("atdNum"))) //근태수
                .atdDate(req.getParameter("atdDate")) //근태기간
                .offDay(req.getParameter("offDay")) //휴가명
                .offDayRs(req.getParameter("offDayRs")) //휴가사유
                .print(req.getParameter("print")) //인쇄
                .build();
        System.out.println("atdCode===="+req.getParameter("atdCode"));
        System.out.println("empNo===="+req.getParameter("empNo"));
        System.out.println("atdNo===="+req.getParameter("atdNo"));
        System.out.println("atdNo===="+req.getParameter("print"));

        AttendDao attendDao = new AttendDao();

        int result = attendDao.updateAttend(attendDto);

        resp.sendRedirect("/attend/board");

    }
}