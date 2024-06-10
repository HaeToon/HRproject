package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// SelectHrm은 사원카드 출력시에만 사용?

@WebServlet("/")
public class SelectHrm extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int no = 0;
        if (req.getParameter("no") != null) {
            no = Integer.parseInt(req.getParameter("no"));
        }

        HrmDao hrmDao = new HrmDao();
        HrmDto hrmDto = hrmDao.selectHrm(no);

        req.setAttribute("hrmDto", hrmDto);

        // 이부분 수정 더 필요함
        req.getRequestDispatcher("/hrm/selectHrm.do").forward(req, resp);

    }
}
