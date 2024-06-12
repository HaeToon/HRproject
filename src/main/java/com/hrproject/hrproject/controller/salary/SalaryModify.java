package com.hrproject.hrproject.controller.salary;


import com.hrproject.hrproject.dao.SalaryDao;
import com.hrproject.hrproject.dto.SalaryLogDto;
import com.hrproject.hrproject.dto.SalaryPlusEmpNameDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/salary/modify")
public class SalaryModify extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);

        SalaryDao salaryDao = new SalaryDao();
        SalaryLogDto salaryLogDto = SalaryLogDto.builder()
                .salary_No(Integer.parseInt(req.getParameter("salary_No_orig")))
                .empNo(Integer.parseInt(req.getParameter("empNo_orig")))
                .ename(req.getParameter("ename_orig"))
                .accountingPeriod(req.getParameter("accountingPeriod_orig"))
                .salaryCategory(req.getParameter("salaryCategory_orig"))
                .salaryName(req.getParameter("salaryName_orig"))
                .salaryDay(req.getParameter("salaryDay_orig"))
                .salary(Integer.parseInt(req.getParameter("salary_orig")))
                .salaryInfo(req.getParameter("salaryInfo_orig"))
                .modifyReason("이유 __ 아직 구현 안함 salary_board.jsp에서 받아오든가 해야함")
                .whoModify("admin __ 로그인 세션으로 값 받아야함!")
                .logStatus("M")
                .build();

        int result= salaryDao.insertSalaryLogDao(salaryLogDto);
        if (result>0){
            System.out.println("logDB insert is Successfully");
        }

        SalaryPlusEmpNameDto salaryPlusEmpNameDto = SalaryPlusEmpNameDto.builder()
                .salary_No(Integer.parseInt(req.getParameter("salary_No_modify")))
                .accountingPeriod(req.getParameter("accountingPeriod_modify"))
                .salaryCategory(req.getParameter("salaryCategory_modify"))
                .salaryName(req.getParameter("salaryName_modify"))
                .salaryDay(req.getParameter("salaryDay_modify"))
                .salary(Integer.parseInt(req.getParameter("salary_modify")))
                .salaryInfo(req.getParameter("salaryInfo_modify"))
                .build();

        int result02 = salaryDao.updateSalaryDao(salaryPlusEmpNameDto);
        if (result02>0){
            System.out.println("update salary qry good");
        }
        resp.sendRedirect("/salary/board");
    }
}