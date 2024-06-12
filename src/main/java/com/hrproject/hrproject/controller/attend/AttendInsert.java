package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dto.AttendDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/attend/insert")
public class AttendInsert extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/attend/insert-attend.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String empNoStr = req.getParameter("empNo");
        String atdNumStr = req.getParameter("atdNum");
        System.out.println(req.getParameter("atdNo"));
        System.out.println(req.getParameter("empNo"));
        int empNo = 0;
        double atdNum = 0.0;

        //정수형과 더블형에 따른 예외처리
        try {
            if (empNoStr != null && !empNoStr.isEmpty()) {
                empNo = Integer.parseInt(empNoStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            // 여기에 적절한 오류 처리를 추가하세요.
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid empNo value");
            return;
        }

        try {
            if (atdNumStr != null && !atdNumStr.isEmpty()) {
                atdNum = Double.parseDouble(atdNumStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            // 여기에 적절한 오류 처리를 추가하세요.
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid atdNum value");
            return;
        }

        String startAtdDate = req.getParameter("startAtdDate");
        String endAtdDate = req.getParameter("endAtdDate");
        String atdDate = startAtdDate + " ~ " + endAtdDate;

        AttendDto attendDto = AttendDto.builder()
                .empNo(empNo) // 사원번호
                .atdNo(req.getParameter("atdNo")) // 근태번호
                .ename(req.getParameter("ename")) // 사원명
                .atdCode(req.getParameter("atdCode")) // 근태코드
                .atdNum(atdNum) // 근태수
                .atdDate(atdDate) // 근태기간
                .startAtdDate(startAtdDate) // 시작 근태기간
                .endAtdDate(endAtdDate) // 끝 근태기간
                .offDay(req.getParameter("offDay")) // 휴가명
                .offDayRs(req.getParameter("offDayRs")) // 휴가사유
                .print(req.getParameter("print")) // 인쇄
                .build();

        AttendDao attendDao = new AttendDao();
        int result = attendDao.insertAttendDao(attendDto);

        if (result > 0) {
            System.out.println("attend data input successfully");
            resp.sendRedirect("/attend/board");
        } else {
            System.out.println("attend data input failed");
        }
    }
}
