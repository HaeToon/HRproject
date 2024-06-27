package com.hrproject.hrproject.controller.notice;

import com.hrproject.hrproject.dao.NoticeDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/notice/delete")
public class NoticeDelete extends HttpServlet {
    private NoticeDao noticeDao;

    @Override
    public void init() throws ServletException {
        super.init();
        noticeDao = new NoticeDao(); // NoticeDao 인스턴스 생성
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 파라미터에서 noticeNo 가져오기
        int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

        // noticeNo를 사용하여 데이터베이스에서 데이터 삭제
        int result = noticeDao.deleteNotice(noticeNo);

        // JSON 형태의 응답 생성
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if (result > 0) {
            out.print("{\"success\": true}");
        } else {
            out.print("{\"success\": false}");
        }
        out.flush();
    }
}
