package com.hrproject.hrproject.controller.attend;


import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/attend/delete")
public class AttendDelete extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 파라미터에서 atdNo 가져오기
        String atdNo = request.getParameter("atdNo");

        AttendDao attendDao = new AttendDao();
        // atdNo를 사용하여 데이터베이스에서 데이터 삭제
        int result = attendDao.deleteAttend(atdNo);

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

