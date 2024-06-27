package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dto.AttendDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;



//현재는 안씀
@WebServlet("/attend/offday")
public class SearchOffdays extends HttpServlet {

    private final AttendDao attendDao = new AttendDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 검색 조건 받기
        String atdCode = req.getParameter("atdCode");
        String empNo = req.getParameter("empNo");
        String empName = req.getParameter("empName");
        String department = req.getParameter("department");

        // DAO를 사용하여 휴가 정보 조회
        List<AttendDto> offdayList = null;
        String errorMessage = null;

        try {
            if (empNo != null && !empNo.isEmpty()) {
                int empNoInt = Integer.parseInt(empNo);
                offdayList = attendDao.selectOffdaysByEmpNo(empNoInt);
            } else if (empName != null && !empName.isEmpty()) {
                offdayList = attendDao.selectOffdaysByEmpName(empName);
            } else if (department != null && !department.isEmpty()) {
                offdayList = attendDao.selectOffdaysByDepartment(department);
            } else if (atdCode != null && !atdCode.isEmpty()) {
                offdayList = attendDao.selectOffdaysByAtdCode(atdCode);
            } else {
                errorMessage = "검색 조건을 입력해주세요.";
            }
        } catch (NumberFormatException e) {
            // 숫자 변환 오류 처리
            errorMessage = "사원번호는 숫자로 입력해주세요.";
        } catch (Exception e) {
            // 기타 예외 처리
            errorMessage = "검색 중 오류가 발생했습니다: " + e.getMessage();
        }

        // 조회된 휴가 정보와 오류 메시지를 request에 저장합니다.
        req.setAttribute("offdayList", offdayList);
        req.setAttribute("errorMessage", errorMessage);

        // JSP 페이지로 포워딩합니다.
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/offday-attend.jsp");
        dispatcher.forward(req, resp);
    }
}
