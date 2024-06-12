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


        SalarySearchDto.SalarySearchDtoBuilder builder =SalarySearchDto.builder();
        String empNoParam = req.getParameter("searchEmpNo");
        if (empNoParam != null && !empNoParam.isEmpty()) {
            try {
                builder.empNo(Integer.parseInt(empNoParam));
                System.out.println("EmpNo: " + empNoParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String ename = req.getParameter("searchEName");
        if (ename != null && !ename.isEmpty()) {
            builder.ename(ename);
            System.out.println("EName: " + ename);
        }

        String salaryNoParam = req.getParameter("searchSalary_No");
        if (salaryNoParam != null && !salaryNoParam.isEmpty()) {
            try {
                builder.salary_No(Integer.parseInt(salaryNoParam));
                System.out.println("SalaryNo: " + salaryNoParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String accountingPeriod = req.getParameter("searchAccountingPeriod");
        if (accountingPeriod != null && !accountingPeriod.isEmpty()) {
            builder.accountingPeriod(accountingPeriod);
            System.out.println("AccountingPeriod: " + accountingPeriod);
        }

        String salaryCategory = req.getParameter("searchSalaryCategory");
        if (salaryCategory != null && !salaryCategory.isEmpty()) {
            builder.salaryCategory(salaryCategory);
            System.out.println("SalaryCategory: " + salaryCategory);
        }

        String salaryName = req.getParameter("searchSalaryName");
        if (salaryName != null && !salaryName.isEmpty()) {
            builder.salaryName(salaryName);
            System.out.println("SalaryName: " + salaryName);
        }

        String salaryDay = req.getParameter("searchSalaryDay");
        if (salaryDay != null && !salaryDay.isEmpty()) {
            builder.salaryDay(salaryDay);
            System.out.println("SalaryDay: " + salaryDay);
        }

        String salaryInfo = req.getParameter("searchSalaryInfo");
        if (salaryInfo != null && !salaryInfo.isEmpty()) {
            builder.salaryInfo(salaryInfo);
            System.out.println("SalaryInfo: " + salaryInfo);
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
        System.out.println("salarySearchDto >>>> " + salarySearchDto);
        SalaryDao salaryDao = new SalaryDao();
        List<SalaryPlusEmpNameDto> searchDtoList = salaryDao.getSearchSalaryList(salarySearchDto);

        // 검색 결과를 요청 속성에 추가
        req.setAttribute("salaryList", searchDtoList);

        // 결과를 보여줄 JSP로 포워드
        req.getRequestDispatcher("/WEB-INF/salary/salary-board.jsp").forward(req, resp);
    }
}