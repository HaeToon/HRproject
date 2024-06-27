package com.hrproject.hrproject.controller.hrm;

import com.google.gson.Gson;
import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/hrm/view")
public class HrmView extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empNo = 0;
        if (req.getParameter("empNo") != null) empNo = Integer.parseInt(req.getParameter("empNo"));

        HrmDao hrmDao = new HrmDao();
        HrmDto hrmDto = hrmDao.getHrm(empNo);

        req.setAttribute("hrmViewDto", hrmDto);
        req.getRequestDispatcher("/WEB-INF/hrm/include/view-modal.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 클라이언트에서 전송한 empNo 파라미터를 가져옴
        int empNo = Integer.parseInt(req.getParameter("empNo"));

        // DAO를 사용하여 empNo에 해당하는 사원 정보를 가져옴
        HrmDao hrmDao = new HrmDao();
        HrmDto hrmDto = hrmDao.getHrm(empNo);

        // Gson을 사용하여 DTO 객체를 JSON 형식으로 변환
        Gson gson = new Gson();
        String json = gson.toJson(hrmDto);

        // JSON 형식으로 응답 설정
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }

}
