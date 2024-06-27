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

            /* 권한 없는 페이지 들어갈시 index로 */
            if (filterRequest(requestUrl, hrmDto, request, response, chain)) {
                chain.doFilter(request, response);
            } else {
                HttpServletResponse resp = (HttpServletResponse) response;
                resp.sendRedirect("/index/index");
            }
        }
    }

    private boolean filterRequest(String requestUrl, HrmDto hrmDto, ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (hrmDto.getGrade() == Grade.ADMIN) {
            return true;
        } else if (requestUrl.startsWith("/workSchedule/adminWorkBoard") || requestUrl.startsWith("/hrm/evaluation")) {
            return false;
        } else if (requestUrl.startsWith("/hrm/board")) {
            if (hrmDto.getDeptNo() == 30) return true;
            else return false;
        } else if (requestUrl.startsWith("/attend/board")) {
            if (hrmDto.getDeptNo() == 10) return true;
            else return false;
        } else if (requestUrl.startsWith("/salary/board")) {
            if (hrmDto.getDeptNo() == 20) return true;
            else return false;
        } else return true;
    }
}