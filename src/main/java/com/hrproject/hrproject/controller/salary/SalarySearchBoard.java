package com.hrproject.hrproject.controller.salary;


import com.hrproject.hrproject.dao.SalaryDao;
import com.hrproject.hrproject.dto.SalaryPlusEmpNameDto;
import com.hrproject.hrproject.dto.SalarySearchDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/salary/searchBoard")
public class SalarySearchBoard extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 서치하기 위한 DTO를 만드는 과정
        // 마이바티스에서 예외처리해도 괜찮지만 자바에서 해보고 싶어서.. 로직이 길어요~
        SalarySearchDto.SalarySearchDtoBuilder builder =SalarySearchDto.builder();
        String empNoParam = req.getParameter("searchEmpNo");
        if (empNoParam != null && !empNoParam.isEmpty()) {
            try {
                builder.empNo(Integer.parseInt(empNoParam));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        String ename = req.getParameter("searchEName");
        if (ename != null && !ename.isEmpty()) {
            builder.ename(ename);
        }
        String salaryNoParam = req.getParameter("searchSalary_No");
        if (salaryNoParam != null && !salaryNoParam.isEmpty()) {
            try {
                builder.salary_No(Integer.parseInt(salaryNoParam));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String accountingPeriod = req.getParameter("searchAccountingPeriod");
        if (accountingPeriod != null && !accountingPeriod.isEmpty()) {
            builder.accountingPeriod(accountingPeriod);;
        }
        String salaryCategory = req.getParameter("searchSalaryCategory");
        if (salaryCategory != null && !salaryCategory.isEmpty()) {
            builder.salaryCategory(salaryCategory);
        }

        String salaryName = req.getParameter("searchSalaryName");
        if (salaryName != null && !salaryName.isEmpty()) {
            builder.salaryName(salaryName);
        }

        String salaryDay = req.getParameter("searchSalaryDay");
        if (salaryDay != null && !salaryDay.isEmpty()) {
            builder.salaryDay(salaryDay);
        }

        String salaryInfo = req.getParameter("searchSalaryInfo");
        if (salaryInfo != null && !salaryInfo.isEmpty()) {
            builder.salaryInfo(salaryInfo);
        }

        String strSalaryMin = req.getParameter("searchMinSalary");
        if (strSalaryMin != null && !strSalaryMin.isEmpty()) {
            builder.salaryMin(Integer.parseInt(strSalaryMin));
        }

        String strSalaryMax = req.getParameter("searchMaxSalary");
        if (strSalaryMax != null && !strSalaryMax.isEmpty()) {
            builder.salaryMax(Integer.parseInt(strSalaryMax));
        }


        SalarySearchDto salarySearchDto = builder.build();
        SalaryDao salaryDao = new SalaryDao();

        //서치를 위한 Dto를 통해 salary_DB에서 값 조회 후 list에 담는다.
        List<SalaryPlusEmpNameDto> searchDtoList = salaryDao.getSearchSalaryList(salarySearchDto);

        req.setAttribute("salaryList", searchDtoList);
        req.getRequestDispatcher("/WEB-INF/salary/salary-board.jsp").forward(req, resp);
    }
}