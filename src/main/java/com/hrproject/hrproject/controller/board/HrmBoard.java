package com.hrproject.hrproject.controller.board;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/hrm/board")
public class HrmBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int start = 1;
        int end = 20;
        int paginationStart = 1;
        int paginationEnd = 20;

        if (req.getParameter("page") != null) {
            start = (Integer.parseInt(req.getParameter("page"))-1)*20 + 1;
        }

        end = start + 20;

        HrmPageDto hrmPageDto = new HrmPageDto();
        hrmPageDto.setStart(start);
        hrmPageDto.setEnd(end);

        HrmDao hrmDao = new HrmDao();
        HrmDao hrmTotalDao = new HrmDao();
        int total = hrmTotalDao.getHrmTotal();

        List<HrmDto> hrmList = hrmDao.getHrmBoardList(hrmPageDto);
        req.setAttribute("hrmList",hrmList);
        req.setAttribute("total",total);
        req.getRequestDispatcher("/WEB-INF/hrm/hrm-board.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        int empno = Integer.parseInt(req.getParameter("empno"));

    }
}

