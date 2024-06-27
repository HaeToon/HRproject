package com.hrproject.hrproject.controller.attend;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;

//근무일수를 직접 입력하여 값 받기
//ㄴㄴ
@WebServlet("/attend/calculate-workdays")
public class CalculateWorkdays extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String hireDateStr = req.getParameter("hireDate");

        if (hireDateStr != null && !hireDateStr.isEmpty()) {
            LocalDate hireDate = LocalDate.parse(hireDateStr, DateTimeFormatter.ISO_DATE);
            LocalDate today = LocalDate.now();
            Period period = Period.between(hireDate, today);
            int workDays = period.getDays(); // 근무 일수 계산

            req.setAttribute("workDays", workDays);
        } else {
            req.setAttribute("errorMessage", "입사일을 선택해주세요.");
        }

        // JSP 페이지로 포워딩
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/calculate-workdays.jsp");
        dispatcher.forward(req, resp);
    }
}
