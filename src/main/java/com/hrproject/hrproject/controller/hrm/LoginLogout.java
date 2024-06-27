package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.utils.ScriptWriter;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/hrm/login-logout")
public class LoginLogout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/hrm/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /* 로그아웃 */
        if (req.getParameter("sessionEmpNo") != null) {
            HttpSession session = req.getSession();
            session.invalidate();
            ScriptWriter.alertAndNext(resp, "로그아웃", "../hrm/login-logout");
        } else {
            /* 관리자 로그인 id, pw 설정 위치 - web.xml */
            ServletContext application  = getServletContext();
            String adminID = application.getInitParameter("AdminID");
            String adminPassword = application.getInitParameter("AdminPassword");
            if (req.getParameter("loginEmpNo").equals(adminID) && req.getParameter("loginPassword").equals(adminPassword)) {
                adminLogin(req, resp,  "관리자");
            } else {
                /* 로그인 */
                String empNoStr = req.getParameter("loginEmpNo");
                int empNo = 0;
                if (isInteger(resp, empNoStr)) empNo = Integer.parseInt(empNoStr);
                else {
                    ScriptWriter.alertAndBack(resp, "로그인 실패");
                    return;
                }

                String password = req.getParameter("loginPassword");
                HrmDao loginHrmDao = new HrmDao();
                HrmDto loginHrmDto = loginHrmDao.login(empNo, password);

                if (loginHrmDto != null) {
                    HrmDto sessionDto = HrmDto.builder()
                            .empNo(loginHrmDto.getEmpNo())
                            .ename(loginHrmDto.getEname())
                            .deptNo(loginHrmDto.getDeptNo())
                            .deptName(loginHrmDto.getDeptName())
                            .posName(loginHrmDto.getPosName())
                            .roleName(loginHrmDto.getRoleName())
                            .hireDate(loginHrmDto.getHireDate())
                            .renameProfile(loginHrmDto.getRenameProfile())
                            .grade(loginHrmDto.getGrade())
                            .build();
                    HttpSession session = req.getSession();
                    session.setAttribute("loginDto", sessionDto);
                    ScriptWriter.alertAndNext(resp, "로그인 성공", "../index/index");
                } else {
                    ScriptWriter.alertAndBack(resp, "로그인 실패");
                }
            }
        }
    }

    private static void adminLogin(HttpServletRequest req, HttpServletResponse resp, String msg) {
        HrmDto adminDto = HrmDto.builder()
                .empNo(0)
                .ename("Admin")
                .grade(Grade.ADMIN)
                .build();
        HttpSession session = req.getSession();
        session.setAttribute("loginDto", adminDto);
        ScriptWriter.alertAndNext(resp, msg + " 계정으로 로그인", "../index/index");
    }

    public static boolean isInteger(HttpServletResponse resp, String numCheck) {
        /* 로그인할때 문자 입력해도 error 500 안뜨게 */
        if (numCheck == null) {
            return false;
        }
        try {
            Integer.parseInt(numCheck);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
