package com.hrproject.hrproject.controller.community;

import com.hrproject.hrproject.dao.CommunityDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/community/incrementViews")
public class CommunityViews extends HttpServlet {
    private final CommunityDao communityDao = new CommunityDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int communityNo = getCommunityNoFromRequest(request);
        if (communityNo == -1) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid notice number format");
            return;
        }

        // 조회수 증가 처리
        communityDao.incrementViews(communityNo);

        // 공지사항 상세 페이지로 리다이렉트
        response.sendRedirect("/community/detail?communityNo=" + communityNo);
    }

    private int getCommunityNoFromRequest(HttpServletRequest request) {
        String communityNoParam = request.getParameter("communityNo");
        if (communityNoParam == null || communityNoParam.isEmpty()) {
            return -1;
        }
        try {
            return Integer.parseInt(communityNoParam);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}
