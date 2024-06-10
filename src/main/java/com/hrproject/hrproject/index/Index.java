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
//        ModalDto modalDto = new ModalDto("타이틀","들어갈 내용","show");
//        req.setAttribute("modalDto", modalDto);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/index/index.jsp");
        dispatcher.forward(req, resp);
    }
}
