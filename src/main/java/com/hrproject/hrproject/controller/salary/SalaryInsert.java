package com.hrproject.hrproject.controller.salary;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dao.SalaryDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.SalaryDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/salary/insert")
public class SalaryInsert extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HrmDao hrmDao = new HrmDao();
        List<HrmDto> hrmList = null;

        req.getRequestDispatcher("/WEB-INF/salary/insert-salary.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryDto salaryDto = SalaryDto.builder()
                .empNo(Integer.parseInt(req.getParameter("empNo")))
                .accountingPeriod(req.getParameter("accountingPeriod"))
                .salaryCategory(req.getParameter("salaryCategory"))
                .salaryName(req.getParameter("salaryName"))
                .salaryDay(req.getParameter("salaryDay"))
                .salary(Integer.parseInt(req.getParameter("salary")))
                .salaryInfo(req.getParameter("salaryInfo"))
                .build();

        SalaryDao salaryDao = new SalaryDao();

        System.out.println("SalaryInsert.java __ salaryDto >>> " + salaryDto);

        int result = salaryDao.insertSalaryDao(salaryDto);
        if (result > 0) {
            System.out.println("salary data input successfully");
            resp.sendRedirect("/salary/board");
        } else if (result == -1) {
            // Display alert message using JavaScript
            String alertMessage = "Employee number does not exist.";
            String script = "alert('" + alertMessage + "');";
            resp.getWriter().println("<script>" + script + "</script>");

            // Add JavaScript to delay redirection after alert is acknowledged
            resp.getWriter().println("<script>setTimeout(function() { window.location.href = '/salary/board'; }, 100);</script>");
        } else {
            System.out.println("salary data input failed");
        }

    }
}
