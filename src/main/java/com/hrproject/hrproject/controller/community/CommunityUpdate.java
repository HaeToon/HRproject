package com.hrproject.hrproject.controller.community;

import com.hrproject.hrproject.dao.CommunityDao;
import com.hrproject.hrproject.dto.CommunityDto;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/community/update")
public class CommunityUpdate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int communityNo = Integer.parseInt(req.getParameter("communityNo"));
        CommunityDto community = CommunityDao.getCommunityById(communityNo);
        req.setAttribute("community", community);
        req.getRequestDispatcher("/WEB-INF/community/update-community.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int communityNo = Integer.parseInt(request.getParameter("communityNo"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");
        String category = request.getParameter("category");

        CommunityDto community = CommunityDto.builder()
                .communityNo(communityNo)
                .title(title)
                .author(author)
                .content(content)
                .category(category)
                .build();

        CommunityDao communityDao = new CommunityDao();
        communityDao.updateCommunity(community);



//        response.sendRedirect("/notice/board");
        // 수정이 완료되었다는 메시지를 쿼리 매개변수로 전달
        response.sendRedirect("/community/board?updateSuccess=true");

    }
}
