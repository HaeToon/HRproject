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

        String startAtdDate = req.getParameter("editStartAtdDate");
        String endAtdDate = req.getParameter("editEndAtdDate");
        String atdDate = startAtdDate + " ~ " + endAtdDate;

        AttendDto attendDto = AttendDto.builder()
                .empNo(Integer.parseInt(req.getParameter("editEmpNo"))) //사원번호
                .atdNo(req.getParameter("atdNo")) //근태번호
                .ename(req.getParameter("ename")) //사원명
                .atdCode(req.getParameter("atdCode")) //근태코드
                .atdNum(Double.parseDouble(req.getParameter("atdNum"))) //근태수
                .atdDate(req.getParameter("atdDate")) //근태기간
                .startAtdDate(startAtdDate) // 시작 근태기간
                .endAtdDate(endAtdDate) // 끝 근태기간
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

        if (result > 0) {
            System.out.println("update-attend data input successfully");
            resp.sendRedirect("/attend/board?updateSuccess=true");
            return; // 리다이렉트 이후 메서드 종료
        } else {
            System.out.println("update-attend data input failed");
            // 실패 시 어떤 처리를 할지 추가
        }

        // 실패 시 기본적으로는 다시 목록 페이지로 리다이렉트
        resp.sendRedirect("/attend/board");
    }
}