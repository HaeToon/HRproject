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


@WebServlet("/salary/delete")
public class SalaryDelete extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 클라이언트에서 받은 salray_No
        int salary_No = Integer.parseInt(req.getParameter("salary_No"));
        SalaryDao salaryDao = new SalaryDao();
        // 백업하기 위한 Dto 준비 과정
        SalaryPlusEmpNameDto salaryPlusEmpNameDto =salaryDao.getSalaryOne(salary_No);
        SalaryLogDto salaryLogDto = SalaryLogDto.builder()
                .salary_No(salaryPlusEmpNameDto.getSalary_No())
                .empNo(salaryPlusEmpNameDto.getEmpNo())
                .ename(salaryPlusEmpNameDto.getEname())
                .accountingPeriod(salaryPlusEmpNameDto.getAccountingPeriod())
                .salaryCategory(salaryPlusEmpNameDto.getSalaryCategory())
                .salaryName(salaryPlusEmpNameDto.getSalaryName())
                .salaryDay(salaryPlusEmpNameDto.getSalaryDay())
                .salary(salaryPlusEmpNameDto.getSalary())
                .salaryInfo(salaryPlusEmpNameDto.getSalaryInfo())
                .modifyReason("이유 __ 아직 구현 안함 salary_board.jsp에서 받아오든가 해야함")
                .whoModify("admin __ 로그인 세션으로 값 받아야함!")
                .logStatus("D")
                .build();
        // 삭제 전 백업
       int result= salaryDao.insertSalaryLogDao(salaryLogDto);
       if (result>0){
           System.out.println("logDB insert is Successfully");
       }
        // salary_No를 통해 DB 삭제
       int result02=salaryDao.deleteSalary(salary_No);
       if (result02>0){
           System.out.println("salaryDB delete by "+salary_No);
       }else {
           System.out.println("salaryDB delete failed");
       }
        resp.sendRedirect("/salary/board");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
