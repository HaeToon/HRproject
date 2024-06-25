package com.hrproject.hrproject.controller.workSchedule;

import com.hrproject.hrproject.dao.WorkScheduleDao;
import com.hrproject.hrproject.dto.WorkScheduleAdminDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

// 관리자용 출퇴근 기록 보드
@WebServlet("/workSchedule/adminWorkBoard")
public class adminWorkBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        WorkScheduleDao workScheduleDao = new WorkScheduleDao();
        int page = 1;
        int recordsPerPage = 20;

        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        // 페이지 제한 + 사원 출력
        List<WorkScheduleAdminDto> adminWorkList = workScheduleDao.getAdminWorkList(new WorkScheduleAdminDto(), (page - 1) * recordsPerPage, recordsPerPage);
        int noOfRecords = workScheduleDao.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);

        req.setAttribute("adminWorkList", adminWorkList);
        req.setAttribute("noOfPages", noOfPages);
        req.setAttribute("currentPage", page);

        req.getRequestDispatcher("/WEB-INF/workSchedule/board-adminWork.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        WorkScheduleDao workScheduleDao = new WorkScheduleDao();

        String workDate = req.getParameter("searchWorkDate");
        int empNo=0;
        if (!req.getParameter("searchWorkEmpNo").isEmpty()) {
            empNo = Integer.parseInt(req.getParameter("searchWorkEmpNo"));
        }
        String deptName = req.getParameter("searchWorkDept");
        String ename = req.getParameter("searchWorkEName");
        String status = req.getParameter("searchWorkStatus");
        String vacationCode = req.getParameter("searchWorkVacation");

        //클라이언트에서 받은 값들을 Dto에 할당해서 DB에서 where문을 통해서 조회한다. (서치기능을 위해)
        WorkScheduleAdminDto workScheduleAdminDto = WorkScheduleAdminDto.builder()
                .workDate(workDate)
                .empNo(empNo)
                .deptName(deptName)
                .ename(ename)
                .status(status)
                .vacationCode(vacationCode)
                .build();

        List<WorkScheduleAdminDto> WSADtoList = workScheduleDao.getAdminWorkList(workScheduleAdminDto);

        req.setAttribute("adminWorkList", WSADtoList);
        req.getRequestDispatcher("/WEB-INF/workSchedule/board-adminWork.jsp").forward(req, resp);
    }
}
