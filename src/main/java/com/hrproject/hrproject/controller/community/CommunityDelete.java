package com.hrproject.hrproject.controller.community;

import com.hrproject.hrproject.dao.CommunityDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/community/delete")
public class CommunityDelete extends HttpServlet {
    private CommunityDao communityDao;

    @Override
    public void init() throws ServletException {
        super.init();
        communityDao = new CommunityDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int communityNo = Integer.parseInt(request.getParameter("communityNo"));


        int result = communityDao.deleteCommunity(communityNo);

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
