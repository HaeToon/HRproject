package com.hrproject.hrproject.controller.community;


import com.hrproject.hrproject.dao.CommunityDao;
import com.hrproject.hrproject.dto.CommunityDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/community/detail")
public class CommunityDetail extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int communityNo = Integer.parseInt(request.getParameter("communityNo"));
        System.out.println("communityNo = " + communityNo);

        // DAO를 사용하여 공지사항 정보를 가져옴
        CommunityDao communityDao = new CommunityDao();
        CommunityDto community = communityDao.getCommunityByCommunityNo(communityNo);

        // 가져온 공지사항 정보를 request 속성에 저장
        request.setAttribute("community", community);

        // noticeDetail.jsp로 포워딩
        request.getRequestDispatcher("/WEB-INF/community/detail-community.jsp").forward(request, response);
    }
}

