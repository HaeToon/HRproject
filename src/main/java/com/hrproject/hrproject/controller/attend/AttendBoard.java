package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dto.AttendDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/attend/board")
public class AttendBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//
        AttendDao attendDao = new AttendDao();
        List<AttendDto> attendList = attendDao.getAttendList();
        req.setAttribute("attendList",attendList);
        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/WEB-INF/attend/board-attend.jsp");
        dispatcher.forward(req,resp);


    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 단일 객체 업데이트 코드
        AttendDto attendDto = AttendDto.builder()
                .empNo(Integer.parseInt(req.getParameter("empNo")))
                .atdNo(req.getParameter("atdNo"))
                .ename(req.getParameter("ename"))
                .atdCode(req.getParameter("atdCode"))
                .atdNum(Double.parseDouble(req.getParameter("atdNum")))
                .atdDate(req.getParameter("atdDate"))
                .offDay(req.getParameter("offDay"))
                .offDayRs(req.getParameter("offDayRs"))
                .print(req.getParameter("print"))
                .build();

        AttendDao attendDao = new AttendDao();
        int result = attendDao.updateAttend(attendDto);

        // 여러 객체 업데이트 코드
        List<AttendDto> attendList = attendDao.getAttendList(); // 생성 및 초기화
        int totalUpdated = attendDao.updateAttendList(attendList);

        if (result > 0 || totalUpdated > 0) {
            resp.sendRedirect(req.getContextPath() + "/attend/board");
        } else {
            req.setAttribute("errorMessage", "업데이트에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req, resp);
        }
    }
}