package com.hrproject.hrproject.controller.salary;

import com.hrproject.hrproject.dao.SalaryDao;
import com.hrproject.hrproject.dto.SalarySearchDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/salary/board")
public class SalaryBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        SalaryDao salaryDao = new SalaryDao();
        //salary_DB에서 조회를 통해 list에 담는다.
        List<SalarySearchDto> salaryList = salaryDao.getSalaryList();
        req.setAttribute("salaryList",salaryList);
        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/WEB-INF/salary/salary-board.jsp");
        dispatcher.forward(req,resp);
    }
}
