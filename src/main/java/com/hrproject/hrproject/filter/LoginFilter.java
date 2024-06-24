package com.hrproject.hrproject.filter;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter({"/*"})
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        로그인 안한 사람이면 /login 으로 강제 이동
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();

        // URL을 가져옴
        String requestUrl = req.getRequestURI().substring(req.getContextPath().length());
        // 로그인 페이지 및 리소스 파일(css, js등)에 대해 필터 적용하지 않음
        if (requestUrl.equals("/hrm/login-logout")
                || requestUrl.startsWith("/static/")
                || requestUrl.startsWith("/resources/")
                || requestUrl.startsWith("/css/")
                || requestUrl.startsWith("/js/")
                || requestUrl.startsWith("/images/")
                || requestUrl.startsWith("/WEB-INF/")) {
            chain.doFilter(request, response);
            return;
        }
        if (session.getAttribute("loginDto") == null) {
            HttpServletResponse resp = (HttpServletResponse) response;
            resp.sendRedirect("/hrm/login-logout");
        } else chain.doFilter(request, response);
    }
}

