package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dao.NoticeDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.NoticeDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/attend/board")
public class AttendBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String search = req.getParameter("search");
        String searchWord = req.getParameter("searchWord");
        String url = req.getRequestURL().toString().substring(22);
        AttendDao attendDao = new AttendDao();
        // 검색어와 검색 조건이 모두 제공되면 검색을 수행합니다.
        if (search != null && searchWord != null && !search.isBlank() && !searchWord.isBlank()) {

            List<AttendDto> attendList = attendDao.searchWaiting(search, searchWord);
            req.setAttribute("attendList", attendList);
            req.setAttribute("url", url);

        } else {
            //대기 상태의 근태 정보 가져오기
            List<AttendDto> attendList = attendDao.getWaitingAttendList();
            req.setAttribute("attendList", attendList);
            req.setAttribute("url", url);
        }

<<<<<<< p4
=======
        //처리 완료된 근태 정보 가져오기
        List<AttendDto> acceptedAttendList = attendDao.getAcceptedAttendList();
        req.setAttribute("acceptedAttendList", acceptedAttendList);
        req.setAttribute("url", url);


>>>>>>> develop
        // JSP 페이지로 포워딩합니다.
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/board-attend.jsp");
        dispatcher.forward(req, resp);
    }
}
