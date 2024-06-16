package com.hrproject.hrproject.index;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/index/index")
public class Index extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURL().toString().substring(22);
        req.setAttribute("url",url);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/index/index.jsp");
        dispatcher.forward(req,resp);
    }
}
