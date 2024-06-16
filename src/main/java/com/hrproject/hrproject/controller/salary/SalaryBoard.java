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

        String url = req.getRequestURL().toString().substring(22);


        SalaryDao salaryDao = new SalaryDao();
        List<SalarySearchDto> salaryList = salaryDao.getSalaryList();

//        int total = getTotalSalaryCount(search, searchWord); // DB에서 가져온 총 사원수
//        int currentPage = getCurrentPage(req);
//        int listPerPage = 20; // 페이지당 보여지는 게시물 수
//        int paginationPerPage = 5; // 보여지는 페이지 수 ex : 1 ~ 5, 6 ~ 10
//
//        int totalPage = calculateTotalPage(total, listPerPage);
//        int startPage = calculateStartPage(currentPage, paginationPerPage);
//        int endPage = calculateEndPage(totalPage, startPage, paginationPerPage);

//        System.out.println("SalaryBaord.java__salaryList >>> "+salaryList);
        req.setAttribute("salaryList",salaryList);
        req.setAttribute("url", url);
        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/WEB-INF/salary/salary-board.jsp");
        dispatcher.forward(req,resp);
    }
}
