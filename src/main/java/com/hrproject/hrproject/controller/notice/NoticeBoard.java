package com.hrproject.hrproject.controller.notice;

import com.hrproject.hrproject.dao.NoticeDao;
import com.hrproject.hrproject.dto.NoticeDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/notice/board")
public class NoticeBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/notice/noticeBoard.jsp");

        NoticeDao noticeDao = new NoticeDao();
        List<NoticeDto>noticeList= noticeDao.getNoticeList();

        req.setAttribute("noticeList",noticeList);

        dispatcher.forward(req,resp);
    }
}
