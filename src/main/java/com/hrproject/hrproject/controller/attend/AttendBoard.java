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

        AttendDao attendDao = null;
        List<AttendDto> attendList = null;
        req.setAttribute("attendList",attendList);

        String search = req.getParameter("search");
        String searchWord = req.getParameter("searchWord");

        // 검색어와 검색 조건이 모두 제공되면 검색을 수행합니다.
        if (search != null && searchWord != null && !search.isBlank() && !searchWord.isBlank()) {
            attendDao = new AttendDao();
            attendList = attendDao.searchAttend(search, searchWord);
            req.setAttribute("attendList", attendList);
        } else {
            // 검색어나 검색 조건이 제공되지 않은 경우 모든 출결 정보를 가져옵니다.
            attendDao = new AttendDao();
            attendList = attendDao.getAttendList();
            req.setAttribute("attendList", attendList);
        }

        // JSP 페이지로 포워딩합니다.
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/board-attend.jsp");
        dispatcher.forward(req, resp);
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