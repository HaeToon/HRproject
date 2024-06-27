package com.hrproject.hrproject.controller.notice;


import com.hrproject.hrproject.dao.NoticeDao;
import com.hrproject.hrproject.dto.NoticeDto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice/detail")
public class NoticeDetail extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
        System.out.println("noticeNo = " + noticeNo);

        // DAO를 사용하여 공지사항 정보를 가져옴
        NoticeDao noticeDao = new NoticeDao();
        NoticeDto notice = noticeDao.getNoticeByNoticeNo(noticeNo);


        // 가져온 공지사항 정보를 request 속성에 저장
        request.setAttribute("notice", notice);

        // noticeDetail.jsp로 포워딩
        request.getRequestDispatcher("/WEB-INF/notice/detail-notice.jsp").forward(request, response);
    }
}

