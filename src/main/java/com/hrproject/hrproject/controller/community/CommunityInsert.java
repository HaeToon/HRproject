package com.hrproject.hrproject.controller.community;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dao.CommunityDao;
import com.hrproject.hrproject.dao.NoticeDao;
import com.hrproject.hrproject.dao.SalaryDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.CommunityDto;
import com.hrproject.hrproject.dto.NoticeDto;
import com.hrproject.hrproject.dto.SalaryDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/community/insert")
public class CommunityInsert extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/community/insert-community.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CommunityDto communityDto = CommunityDto.builder()
                .category(req.getParameter("category"))
                .title(req.getParameter("title"))
                .author(req.getParameter("author"))
                .content(req.getParameter("content"))
                .build();

        CommunityDao communityDao = new CommunityDao();

        int result = communityDao.insertCommunityDao(communityDto);

        if (result>0){
            System.out.println("community data input successfully");
            resp.sendRedirect("/community/board?insertSuccess=true");
        }else {
            System.out.println("community data input failed");
        }

    }

}

