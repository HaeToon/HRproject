package com.hrproject.hrproject.filter;

import com.leekiye.mybatis.utils.ScriptWriter;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// spring context 안에서 동작하는 interceptor 와는 조금 다르지만 하는 역할은 비슷하다.
//
//@WebFilter({"/board/*","/admin/*"}) // filter는 주소창에서 경로를 미리 알고 넣고 뚫는것을 방지하기 위함
//
//// 주소창에 /board/~~~~ , /admin/~~~~ 로 되는 주소들을 막고 무조건 강제로 설정된 페이지로 이동시킴
//public class LoginFilter implements Filter {
//    @Override
//    public void init(FilterConfig filterConfig) throws ServletException {
//        Filter.super.init(filterConfig);
//    }
//
//    @Override
//    public void destroy() {
//        Filter.super.destroy();
//    }
//
//    // 이 부분이 핵심인것같다
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        // 로그인 안한 사람이면 무조건 login 으로 강제 이동시키기
//        HttpServletRequest req = (HttpServletRequest) request;
//        HttpSession session = req.getSession();
//        if(session.getAttribute("sessionID")!=null) {
//            chain.doFilter(request, response);
//        } else {
//            HttpServletResponse resp = (HttpServletResponse) response;
//            //HttpServletRequest req02 = (HttpServletRequest) request;
//
//            ScriptWriter.alertAndNext(resp, "로그인 페이지로 이동합니다.",req.getContextPath() + "/member/login");
//        }
//    }
//}

@WebFilter({"/board/*" , "/admin/*"})
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        로그인 안한 사람이면 /login 으로 강제 이동
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
        if (session.getAttribute("sessionID") == null) {
            HttpServletResponse resp = (HttpServletResponse) response;
            ScriptWriter.alertAndNext(resp, "로그인해야함", req.getContextPath() + "/member/login");

        } else chain.doFilter(request, response);
    }
}
