package com.hrproject.hrproject.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieManager {
    public static void createCookie(HttpServletResponse response,
                             String cookieName,
                             String cookieValue,
                             int second) {
        Cookie cookie = new Cookie(cookieName, cookieValue);
        cookie.setMaxAge(second);
        cookie.setPath("/");
        // response는 자바 내장 객체가 아니라서 외부에서 받아와야함
        response.addCookie(cookie);
    };
    // cookie 읽는 method 만들어보세요 return String
    // cookie 지우기 같은 이름의 쿠키를 새로 만들면서 시간을 0으로 하면 된다
    // 쿠키 만드는건 readCookie, 지우는건 deleteCookie

    public static String readCookie(HttpServletRequest request, String cookieName) {
        // 쿠키 읽기
        Cookie cookies[] = request.getCookies();
        String cookieValue = "";
        if (cookies!=null) {
            for (int i=0; i<cookies.length; i++) {
                Cookie cookie = cookies[i];
                if (cookie.getName().equals(cookieName)) {
                    cookieValue = cookie.getValue();
                }
            }
        }
        return cookieValue;
    }

    public static void deleteCookie(HttpServletResponse response,
                                    String cookieName) {
        createCookie(response,cookieName,null,0);
        // 쿠키 삭제는 벨류 필요없음, 시간 0으로 설정하면 끝
    };
}
