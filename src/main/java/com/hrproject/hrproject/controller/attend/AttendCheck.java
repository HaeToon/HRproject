package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.google.gson.Gson;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.utils.GsonUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

@WebServlet("/attend/check")
public class AttendCheck extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LocalDate now = LocalDate.now(); // 현재 날짜
        int year = now.getYear(); // 현재 년도
        int month = now.getMonthValue(); // 현재 달
        // 입력 month가 1자리이면 0붙여서 리턴
        String formatMonth;
        if (month < 10) {
            formatMonth = "0"+month;
        }
        else {
            formatMonth = String.valueOf(month);
        }
        req.setAttribute("year", String.valueOf(year));
        req.setAttribute("month", formatMonth);
        Calendar cal = Calendar.getInstance();
        cal.set(year, month - 1, 1); // 1월 = 0
        int dayLast = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        // 첫 번째 날의 요일 인덱스 구하기 (일요일: 1 ~ 토요일: 7)
        int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

        // 주차별 날짜 리스트 생성
        List<List<Integer>> weekDates = generateWeeklyDates(firstDayOfWeek, dayLast);
        int numberOfWeeks = weekDates.size();

        req.setAttribute("weekDates", weekDates);
        req.setAttribute("numberOfWeeks", numberOfWeeks);
        //로그인정보 가져오기
        HttpSession session = req.getSession();
        HrmDto loginDto = (HrmDto)session.getAttribute("loginDto");
        int loginEmpNo = loginDto.getEmpNo();



        // 로그인한 사원의 근태 목록 출력
        AttendDao attendDao = new AttendDao();
        String search = req.getParameter("search");
        String searchWord = req.getParameter("searchWord");
        //url 내려주기 값= ex)index/index
        String url = req.getRequestURL().toString().substring(22);
        req.setAttribute("url", url);


        // 검색어와 검색 조건이 모두 제공되면 검색을 수행합니다.
        if (search != null && searchWord != null && !search.isBlank() && !searchWord.isBlank()) {
            List<AttendDto> loginAttendList = attendDao.searchLoginAttend(search, searchWord, loginEmpNo);
            req.setAttribute("loginAttendList", loginAttendList);
        } else {
            // 모든 근태 출력
            List<AttendDto> loginAttendList = attendDao.getAttendListByEmpNo(loginEmpNo);
            req.setAttribute("loginAttendList", loginAttendList);
        }



        //근속연수 내려주기
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate hireDate = LocalDate.parse(loginDto.getHireDate(), formatter);

        // 두 날짜 사이의 기간을 일(day) 단위로 계산
        long hiredateToSysdate = ChronoUnit.DAYS.between(hireDate, currentDate) +1 ;
        long hiredateToSysdateAnnual = ChronoUnit.DAYS.between(hireDate, currentDate) +1 ;
        if (hiredateToSysdate < 0) {
            hiredateToSysdate = 0;
        }

        long diffYear = hiredateToSysdate/365;
        if (diffYear != 0) {
            hiredateToSysdate %= diffYear*365;
        }

        long diffMonth = hiredateToSysdate/30;
        if (diffMonth != 0 ) {
            hiredateToSysdate %= diffMonth*30;
        }
        req.setAttribute("diffYear",diffYear);
        req.setAttribute("diffMonth",diffMonth);
        req.setAttribute("diffDay",hiredateToSysdate);


        AttendDao annualDao = new AttendDao();
        List<AttendDto> annualList = annualDao.getAttendListByEmpNo(loginEmpNo);

        List<AttendDto> approvedAttendList = annualDao.getApprovedAttendList();
        req.setAttribute("approvedAttendList", approvedAttendList);

        int annualLeave = 0;
        int usedAnnualCount=0;
        // 근무 기간에 따라 연차 계산
        if (hiredateToSysdateAnnual < 365) {
            // 1년 미만 근무 시
            annualLeave = (int)hiredateToSysdateAnnual/30;
        } else {
            // 1년 이상 근무 시
            int yearsWorked = (int) (hiredateToSysdateAnnual / 365);
            int baseAnnualLeave = 15; // 첫해 기본 연차
            int additionalLeave = 0; // 추가되는 연차 수
            for (int i = 2; i <= yearsWorked; i += 2) {
                additionalLeave++;
            }
            int totalAnnualLeave = baseAnnualLeave + additionalLeave;
            annualLeave = Math.min(totalAnnualLeave, 23);
        }
        if(annualList!=null){
            for(int i=0; i<annualList.size(); i++){
                LocalDate startDate = LocalDate.parse(annualList.get(i).getStartAtdDate());
                LocalDate endDate = LocalDate.parse(annualList.get(i).getEndAtdDate());
                long usedAnnual = ChronoUnit.DAYS.between(startDate, endDate)+1;
                annualLeave-=usedAnnual;
                usedAnnualCount+=usedAnnual;
            }
        }
        //남은연차
        req.setAttribute("annualLeave", annualLeave);
        //사용한연차
        req.setAttribute("usedAnnualCount",usedAnnualCount);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/attend/check-attend.jsp");
        dispatcher.forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int year = Integer.parseInt(req.getParameter("year"));
        int month = Integer.parseInt(req.getParameter("month"));
        System.out.println("year=="+year);
        System.out.println("month=="+month);
        Calendar cal = Calendar.getInstance();
        cal.set(year, month-1, 1);
        int dayLast = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
        List<List<Integer>> weekDates = generateWeeklyDates(firstDayOfWeek, dayLast);
        int numberOfWeeks = weekDates.size();


        AttendDao attendDao = new AttendDao();

        List<AttendDto> approvedAttendList = attendDao.getApprovedAttendList();

        req.setAttribute("approvedAttendList", approvedAttendList);

        // 응답 객체 생성
        ResponseData responseData = new
                ResponseData(weekDates, numberOfWeeks,year,month,approvedAttendList);

        Gson gson = new Gson();


        String jsonResponse = GsonUtil.GSON.toJson(responseData);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        out.write(jsonResponse);
        out.flush();
    }

    private List<List<Integer>> generateWeeklyDates(int firstDayOfWeek, int dayLast) {
        List<List<Integer>> weekDates = new ArrayList<>();
        int dayCounter = 1;
        for (int i = 0; i < 6; i++) { // 최대 6주까지 생성
            List<Integer> daysInWeek = new ArrayList<>();
            for (int j = 1; j <= 7; j++) {
                if (i == 0 && j < firstDayOfWeek) {
                    daysInWeek.add(0); // 첫 번째 주의 첫 날 이전은 0으로 채운다
                } else if (dayCounter <= dayLast) {
                    daysInWeek.add(dayCounter);
                    dayCounter++;
                } else {
                    daysInWeek.add(0); // 마지막 날 이후는 0으로 채운다
                }
            }
            weekDates.add(daysInWeek);
            if (dayCounter > dayLast) break; // 모든 날짜를 다 채웠으면 중단
        }
        return weekDates;
    }

    private static class ResponseData {
        List<List<Integer>> weekDates;
        int numberOfWeeks;
        int year;
        int month;
        List<AttendDto> approvedAttendList;
        public ResponseData(List<List<Integer>> weekDates, int numberOfWeeks , int year , int month, List<AttendDto> approvedAttendList) {
            this.weekDates = weekDates;
            this.numberOfWeeks = numberOfWeeks;
            this.year=year;
            this.month=month;
            this.approvedAttendList = approvedAttendList;
        }
    }
}
