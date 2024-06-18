package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.utils.ScriptWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/hrm/login-logout")
public class LoginLogout extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.getRequestDispatcher("/WEB-INF/index/index.jsp").forward(req, resp);
//    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /* 로그아웃 */
        if (req.getParameter("sessionEmpNo") != null) {
            HttpSession session = req.getSession();
            session.invalidate();
            ScriptWriter.alertAndNext(resp, "로그아웃", "../index/index");
        } else {
            /* 관리자 로그인 임시 */
            if (req.getParameter("loginEmpNo").equals("admin") && req.getParameter("loginPassword").equals("1234")) {
                adminLogin(req,resp,"Admin",Grade.ADMIN,"관리자");
            } else if (req.getParameter("loginEmpNo").equals("sal") && req.getParameter("loginPassword").equals("1234")) {
                adminLogin(req,resp,"SalManager",Grade.SALARY_MANAGER,"급여 업무 관리자");
            } else if (req.getParameter("loginEmpNo").equals("attend") && req.getParameter("loginPassword").equals("1234")) {
                adminLogin(req,resp,"AttendManager",Grade.ATTEND_MANAGER,"근태 업무 관리자");
            } else if (req.getParameter("loginEmpNo").equals("hrm") && req.getParameter("loginPassword").equals("1234")) {
                adminLogin(req,resp,"HrmManager",Grade.HRM_MANAGER,"인사 업무 관리자");
            } else {
                /* 로그인 */
                String empNoStr = req.getParameter("loginEmpNo");
                int empNo = 0;
                if (isInteger(resp, empNoStr)) empNo = Integer.parseInt(empNoStr);
                else {
                    ScriptWriter.alertAndBack(resp, "로그인 실패");
                    return;
                }

                String passwordStr = req.getParameter("loginPassword");
                int password = 0;
                if (isInteger(resp, passwordStr)) password = Integer.parseInt(passwordStr);
                else {
                    ScriptWriter.alertAndBack(resp, "로그인 실패");
                    return;
                }
//        String password = req.getParameter("password"); // /* DB에 password추가 및 회원정보 수정에서 비번 바꾸는 기능 추가후 주석 풀기 */

                HrmDao loginHrmDao = new HrmDao();
                HrmDto loginHrmDto = loginHrmDao.login(empNo, password);

                if (loginHrmDto != null) {
                    HrmDto sessionDto = HrmDto.builder()
                            .empNo(loginHrmDto.getEmpNo())
                            .ename(loginHrmDto.getEname())
                            .deptName(loginHrmDto.getDeptName())
                            .renameProfile(loginHrmDto.getRenameProfile())
                            .build();
                    HttpSession session = req.getSession();
                    session.setAttribute("sessionDto", sessionDto);
                    ScriptWriter.alertAndNext(resp, "로그인 성공", "../index/index");
                } else {
                    ScriptWriter.alertAndBack(resp, "로그인 실패");
                }
            }
        }
    }

    private static void adminLogin(HttpServletRequest req, HttpServletResponse resp, String ename, Grade grade, String msg) {
        HrmDto adminDto = HrmDto.builder()
                .empNo(0)
                .ename(ename)
                .grade(grade)
                .build();
        HttpSession session = req.getSession();
        session.setAttribute("sessionDto", adminDto);
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
