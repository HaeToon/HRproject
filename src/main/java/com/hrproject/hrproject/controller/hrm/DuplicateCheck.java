package com.hrproject.hrproject.controller.hrm;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.hrproject.hrproject.dao.HrmDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/hrm/duplicate-check")
public class DuplicateCheck extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HrmDao hrmDao = new HrmDao();
        int result = -1;
        String check = req.getParameter("check");
        String checkValue = req.getParameter("checkValue");
        if (checkValue != null && !checkValue.equals("")) {
            result = hrmDao.duplicateCheck(check, checkValue);
        }

        Gson gson = new Gson();
        Map<String, Integer> resultMap = new HashMap<>();
        resultMap.put("count", result);
        String resultJson = gson.toJson(resultMap);

        resp.setContentType("application/json; charset=utf-8");
        PrintWriter out = resp.getWriter();
        out.println(resultJson);
    }
}
