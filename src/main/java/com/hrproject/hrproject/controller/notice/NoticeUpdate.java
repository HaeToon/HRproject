package com.hrproject.hrproject.controller.notice;

import com.hrproject.hrproject.dao.NoticeDao;
import com.hrproject.hrproject.dto.NoticeDto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/notice/update")
public class NoticeUpdate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int noticeNo = Integer.parseInt(req.getParameter("noticeNo"));
        NoticeDto notice = NoticeDao.getNoticeById(noticeNo); // 해당 공지사항 정보를 가져오는 메서드 필요
        req.setAttribute("notice", notice);
        req.getRequestDispatcher("/WEB-INF/notice/update-notice.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");
        String createdDate = request.getParameter("createdDate");
        NoticeDto notice = NoticeDto.builder()
                .noticeNo(noticeNo)
                .title(title)
                .author(author)
                .content(content)
                .createdDate(createdDate)
                .build();

        NoticeDao noticeDao = new NoticeDao();
        noticeDao.updateNotice(notice);

//        response.sendRedirect("/notice/board");
        // 수정이 완료되었다는 메시지를 쿼리 매개변수로 전달
        response.sendRedirect("/notice/board?updateSuccess=true");

    }
}
