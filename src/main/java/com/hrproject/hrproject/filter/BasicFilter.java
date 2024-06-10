package com.hrproject.hrproject.filter;

import jakarta.servlet.*;

import java.io.IOException;

public class BasicFilter implements Filter {

    FilterConfig config;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        config = filterConfig;
        String filterName = filterConfig.getFilterName();
        System.out.println("encoding filter init 호출 == " + filterName);
    }

    @Override
    public void destroy() {
        System.out.println("encoding filter destroy 호출됨");
        //Filter.super.destroy();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("doFilter 호출됨");
        String filterInitParam = config.getInitParameter("FILTER INIT PARAM");
        System.out.println("encodingFilter init param === " + filterInitParam);
        filterChain.doFilter(request,response);
        System.out.println("JSP call after");
    }
}
