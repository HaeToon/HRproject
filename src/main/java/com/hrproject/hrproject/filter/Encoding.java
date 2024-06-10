package com.hrproject.hrproject.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

@WebFilter("/*")
public class Encoding implements Filter {

    private String encoding = "UTF-8";
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("encoding filter init");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        System.out.println("filtering~~~~~");
        if(servletRequest.getCharacterEncoding()==null) {
            servletRequest.setCharacterEncoding(encoding);
            System.out.println("utf-8 encoding");
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        System.out.println("Encoding filter destroyed");
    }


}
