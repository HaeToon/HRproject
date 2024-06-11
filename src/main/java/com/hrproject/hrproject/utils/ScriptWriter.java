package com.hrproject.hrproject.utils;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

public class ScriptWriter {
    /* 일반 경고창 */
    public static void alert(HttpServletResponse response, String msg) {
        try {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert(\"" + msg + "\");</script>");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /* 경고창 -> 페이지 이동 */
    public static void alertAndNext(HttpServletResponse response, String msg, String url) {
        try {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert(\"" + msg + "\"); location.href = \"" + url + "\";</script>");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static void alertAndNext(HttpServletResponse response, String msg, String url, int no) {
        try {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert(\"" + msg + "\"); location.href = \"" + url + no + "\";</script>");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /* 경고창 <- 새로고침 */
    public static void alertAndBack(HttpServletResponse response, String msg) {
        try {
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert(\"" + msg + "\");history.back();</script>");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}