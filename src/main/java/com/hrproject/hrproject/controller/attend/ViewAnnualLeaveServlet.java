package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.HrmDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.List;

@WebServlet("/attend/view-annual-leave")
public class ViewAnnualLeaveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String empNo = req.getParameter("empNo");

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/view-annual-leave.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empNo = Integer.parseInt(req.getParameter("empNo"));

        HrmDto hrmDto= null;
        HrmDao hrmDao = new HrmDao();
        hrmDto=hrmDao.getHrm(empNo);

        AttendDto attendDto = null;
        AttendDao attendDao = new AttendDao();
        List<AttendDto> attendList = attendDao.getAttendListByEmpNo(empNo);

        /*for(int i=0; i<attendList.size(); i++){
            attendList.get(i).
        }*/

        String hireDateStr = hrmDto.getHireDate();
        LocalDate today = LocalDate.now();
        LocalDate hireDate = LocalDate.parse(hireDateStr);
        String todayStr = today.toString();



        Period period = Period.between(hireDate, today);
        long daysBetween = ChronoUnit.DAYS.between(hireDate, today);
        /*long daysBetween = ChronoUnit.DAYS.between(, today);*/
        String periodString = period.getYears() + "년 " + period.getMonths() + "개월 " + period.getDays() + "일";
        System.out.println("daysBetween=="+daysBetween);
        System.out.println("period=="+period);
        System.out.println("periodString=="+periodString);
        System.out.println("hrmDto.getHireDate()=="+hrmDto.getHireDate());

        int annualLeave = 0;
        int usedAnnualCount=0;
        // 근무 기간에 따라 연차 계산
        if (daysBetween < 365) {
            // 1년 미만 근무 시
            annualLeave = calculateLessThanOneYear(daysBetween);
        } else {
            // 1년 이상 근무 시
            annualLeave = calculateAnnualLeave(daysBetween);
        }

        // 연차는 최대 23일로 제한
        annualLeave = Math.min(annualLeave, 23);

        if(attendList!=null){
            for(int i=0; i<attendList.size(); i++){
                LocalDate startDate = LocalDate.parse(attendList.get(i).getStartAtdDate());
                LocalDate endDate = LocalDate.parse(attendList.get(i).getEndAtdDate());
                long usedAnnual = ChronoUnit.DAYS.between(startDate, endDate)+1;
                annualLeave-=usedAnnual;
                usedAnnualCount+=usedAnnual;
            }
        }

        req.setAttribute("hrmDto", hrmDto);
        req.setAttribute("daysBetween", daysBetween);
        req.setAttribute("annualLeave", annualLeave);
        req.setAttribute("periodString",periodString);
        req.setAttribute("usedAnnualCount",usedAnnualCount);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/view-annual-leave.jsp");
        dispatcher.forward(req, resp);
    }

    // 1년 미만 근무 시 연차 계산
    private int calculateLessThanOneYear(long daysWorked) {
        // 월별 연차 1일씩 계산 (조직의 정책에 따라 조정 필요)
        return (int) (daysWorked / 30);
    }

    // 1년 이상 근무 시 연차 계산
    private int calculateAnnualLeave(long daysWorked) {
        int yearsWorked = (int) (daysWorked / 365);

        int baseAnnualLeave = 15; // 첫해 기본 연차
        int additionalLeave = 0; // 추가되는 연차 수

        // 매 2년마다 추가 연차 1일씩 증가, 최대 추가 연차는 8일
        for (int i = 2; i <= yearsWorked; i += 2) {
            additionalLeave++;
        }

        int totalAnnualLeave = baseAnnualLeave + additionalLeave;

        // 최대 연차는 23일로 제한
        return Math.min(totalAnnualLeave, 23);
    }
}