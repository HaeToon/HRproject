package com.hrproject.hrproject.controller.workSchedule;

import com.hrproject.hrproject.dao.WorkScheduleDao;
import com.hrproject.hrproject.dto.WorkScheduleLogDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/workSchedule/delete")
public class WorkScheduleDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int workIdx = Integer.parseInt(req.getParameter("workIdx"));
        WorkScheduleDao workScheduleDao = new WorkScheduleDao();
        // 클라이언트에서 받은 workIdx를 통해 워크스케쥴러 값 조회
        WorkScheduleLogDto workScheduleLogDto01 = workScheduleDao.getWorkScheduleByWorkIdx(workIdx);
        //Delete하기 전에 워크 스케쥴러 로그_DB에 백업하기 위한 과정
        WorkScheduleLogDto workScheduleLogDto02;
        workScheduleLogDto02 = WorkScheduleLogDto.builder()
                .workIdx(workScheduleLogDto01.getWorkIdx())
                .empNo(workScheduleLogDto01.getEmpNo())
                .workDate(workScheduleLogDto01.getWorkDate())
                .startTime(workScheduleLogDto01.getStartTime())
                .endTime(workScheduleLogDto01.getEndTime())
                .status(workScheduleLogDto01.getStatus())
                .atdNo(workScheduleLogDto01.getAtdNo())
                .vacationCode(workScheduleLogDto01.getVacationCode())
                .modifyReason("아직 구현 안했는데 고민 중")
                .whoModify("세션 아이디 받아와야합니다~")
                .logStatus("D")
                .build();
        //워크 스케쥴러 로그_DB에 백업
        workScheduleDao.insertWorkScheduleLog(workScheduleLogDto02);
        //workIdx로 DB에서 삭제
        workScheduleDao.deleteWorkSchedule(workIdx);
        resp.sendRedirect("/workSchedule/adminWorkBoard");
    }
}
