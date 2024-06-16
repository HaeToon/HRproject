package com.hrproject.hrproject.controller.notice;



import com.hrproject.hrproject.dao.NoticeDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice/incrementViews")
public class NoticeViews extends HttpServlet {
    private final NoticeDao noticeDao = new NoticeDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int noticeNo = getNoticeNoFromRequest(request);
        if (noticeNo == -1) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid notice number format");
            return;
        }

        // 조회수 증가 처리
        noticeDao.incrementViews(noticeNo);

        // 공지사항 상세 페이지로 리다이렉트
        response.sendRedirect("/notice/detail?notice_no=" + noticeNo);
    }

    private int getNoticeNoFromRequest(HttpServletRequest request) {
        String noticeNoParam = request.getParameter("notice_no");
        if (noticeNoParam == null || noticeNoParam.isEmpty()) {
            return -1;
        }
        try {
            return Integer.parseInt(noticeNoParam);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}
