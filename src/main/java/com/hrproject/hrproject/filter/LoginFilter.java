package com.hrproject.hrproject.filter;

import com.hrproject.hrproject.controller.hrm.Grade;
import com.hrproject.hrproject.dto.HrmDto;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

//@WebFilter({"/*"})
@WebFilter({"/hrm/*", "/attend/*", "/*"})
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
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

        // 로그인 안된 상태일때 login.jsp로 강제 이동
        if (session.getAttribute("loginDto") == null) {
            HttpServletResponse resp = (HttpServletResponse) response;
            resp.sendRedirect("/hrm/login-logout");
        } else {
            /* 로그인 상태일때 */
            HrmDto hrmDto = (HrmDto) session.getAttribute("loginDto");
//            Boolean isAdmin = hrmDto.getGrade() == Grade.ADMIN ? true : false;

            // 특정 URL 패턴()에 대한 필터링 조건
            if (requestUrl.startsWith("/workSchedule/adminWorkBoard") || requestUrl.startsWith("/hrm/evaluation")) {
                if (hrmDto.getGrade() == Grade.ADMIN) {
                    chain.doFilter(request, response);
                    return;
                } else {
                    HttpServletResponse resp = (HttpServletResponse) response;
                    resp.sendRedirect("/index/index");
                }
            } else if (requestUrl.startsWith("/hrm/board")) {
                if (hrmDto.getGrade() == Grade.ADMIN) {
                    chain.doFilter(request, response);
                    return;
                } else if (hrmDto.getDeptNo() == 30) {
                    chain.doFilter(request, response);
                    return;
                } else {
                    HttpServletResponse resp = (HttpServletResponse) response;
                    resp.sendRedirect("/index/index");
                }
            } else if (requestUrl.startsWith("/attend/board")) {
                if (hrmDto.getGrade() == Grade.ADMIN) {
                    chain.doFilter(request, response);
                    return;
                } else if (hrmDto.getDeptNo() == 10) {
                    chain.doFilter(request, response);
                    return;
                } else {
                    HttpServletResponse resp = (HttpServletResponse) response;
                    resp.sendRedirect("/index/index");
                }
            } else if (requestUrl.startsWith("/salary/board")) {
                if (hrmDto.getGrade() == Grade.ADMIN) {
                    chain.doFilter(request, response);
                    return;
                } else if (hrmDto.getDeptNo() == 20) {
                    chain.doFilter(request, response);
                    return;
                } else {
                    HttpServletResponse resp = (HttpServletResponse) response;
                    resp.sendRedirect("/index/index");
                }
            } else {
                /* 특정 URL 패턴 전부 안걸렸을시 */
                chain.doFilter(request, response);
                return;
            }
        }
    }
}
