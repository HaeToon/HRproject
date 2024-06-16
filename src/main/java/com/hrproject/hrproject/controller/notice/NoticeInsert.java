package com.hrproject.hrproject.controller.notice;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dao.NoticeDao;
import com.hrproject.hrproject.dao.SalaryDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.NoticeDto;
import com.hrproject.hrproject.dto.SalaryDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/notice/insert")
public class NoticeInsert extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/notice/insert-notice.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NoticeDto noticeDto = NoticeDto.builder()
                .title(req.getParameter("title"))
                .author(req.getParameter("author"))
                .content(req.getParameter("content"))
                .build();

        NoticeDao noticeDao = new NoticeDao();

        int result = noticeDao.insertNoticeDao(noticeDto);
        if (result>0){
            System.out.println("notice data input successfully");
            resp.sendRedirect("/notice/board?insertSuccess=true");
        }else {
            System.out.println("notice data input failed");
        }

    }

}

