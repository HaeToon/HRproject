package com.hrproject.hrproject.controller.workSchedule;

import com.hrproject.hrproject.dao.WorkScheduleDao;
import com.hrproject.hrproject.dto.WorkScheduleDto;
import com.hrproject.hrproject.dto.WorkScheduleLogDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/workSchedule/modify")
public class WorkScheduleModify extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        WorkScheduleDao workScheduleDao = new WorkScheduleDao();
        //클라이언트에서 받은 수정하고 싶은 값들
        String startTime = req.getParameter("modifyStartTime");
        String endTime = req.getParameter("modifyEndTime");
        int workIdx = Integer.parseInt(req.getParameter("workIdx_modify"));
        String status = req.getParameter(" searchWorkStatus");
        String startTimeFormat = "";
        String endTimeFormat = "";

        System.out.println("startTime >>> " + startTime);

        // 시간 형식DB에 맞게 포맷하는 과정
        if (!startTime.isEmpty()) {
            startTimeFormat = startTime + ":00";
        }
        if (!endTime.isEmpty()) {
            endTimeFormat = endTime + ":00";
        }
        System.out.println("startTime >>> " + startTimeFormat);
        System.out.println("endTime >>> " + endTimeFormat);

        // 클라이언트에서 받은 workIdx를 통해서 워크스케쥴_DB 조회를 통해 백업 준비를 합니다.
        WorkScheduleLogDto workScheduleLogDto01 = workScheduleDao.getWorkScheduleByWorkIdx(workIdx);
        System.out.println("workScheduleLogDto01 >>>> " + workScheduleLogDto01);

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
                .whoModify("whoModify세션에서 받아와야합니다~")
                .logStatus("M")
                .build();

        // 수정 전 백업
        workScheduleDao.insertWorkScheduleLog(workScheduleLogDto02);

        Map<String, Object> modifyParamMap = new HashMap<>();

        modifyParamMap.put("startTime", startTimeFormat);
        modifyParamMap.put("endTime", endTimeFormat);
        modifyParamMap.put("workIdx", workIdx);
        modifyParamMap.put("status", status);

        // 수정하는 로직
        workScheduleDao.modifyWorkTime(modifyParamMap);

        resp.sendRedirect("/workSchedule/adminWorkBoard");
//        req.getRequestDispatcher("/WEB-INF/workSchedule/board-adminWork.jsp").forward(req, resp);

    }


}
