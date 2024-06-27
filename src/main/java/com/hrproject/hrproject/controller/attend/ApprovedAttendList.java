package com.hrproject.hrproject.controller.attend;

import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.ServerException;
import java.util.List;

import com.google.gson.Gson;
import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dto.AttendDto;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/approvedAttendList")
public class ApprovedAttendList extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServerException, IOException {
        // 서버에서 가져올 데이터를 예시로 생성
        AttendDao attendDao = new AttendDao();
        List<AttendDto> approvedAttendList = attendDao.getApprovedAttendList();

        Gson gson = new Gson();
        String json = gson.toJson(approvedAttendList);  // approvedAttendList를 JSON으로 변환

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.write(json);
        out.flush();
    }
}
