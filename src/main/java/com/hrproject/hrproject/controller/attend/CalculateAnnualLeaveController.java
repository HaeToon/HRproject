package com.hrproject.hrproject.controller.attend;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
//ㄴㄴ
@WebServlet("/attend/calculate-annual-leave")
public class CalculateAnnualLeaveController extends HttpServlet {

    private AnnualLeaveCalculator annualLeaveCalculatorService;

    @Override
    public void init() throws ServletException {
        super.init();
        annualLeaveCalculatorService = new AnnualLeaveCalculator(); // Service 클래스 초기화
    }

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
            LocalDate hireDate = LocalDate.parse(hireDateStr);
            int annualLeaveDays = annualLeaveCalculatorService.calculateAnnualLeave(hireDate);

            req.setAttribute("annualLeaveDays", annualLeaveDays);
        } else {
            req.setAttribute("errorMessage", "입사일을 선택해주세요.");
        }

        // JSP 페이지로 포워딩
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/view-annual-leave.jsp");
        dispatcher.forward(req, resp);
    }
}
