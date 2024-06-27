package com.hrproject.hrproject.controller.salary;

import com.google.gson.Gson;
import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dao.NoticeDao;
import com.hrproject.hrproject.dao.SalaryDao;
import com.hrproject.hrproject.dao.WorkScheduleDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.NoticeDto;
import com.hrproject.hrproject.dto.SalaryDto;
import com.hrproject.hrproject.dto.WorkScheduleDto;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
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

@WebServlet("/salary/check")
public class SalaryCheck extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LocalDate now = LocalDate.now(); //현재 날짜
        int year = now.getYear(); //현재 년도
        int month = now.getMonthValue(); //현재 달

        // 입력 month가 1자리이면 0붙이기
        String formatMonth;
        if (month < 10) {
            formatMonth = "0"+month;
        }
        else {
            formatMonth = String.valueOf(month);
        }
        req.setAttribute("year", String.valueOf(year));
        req.setAttribute("month", formatMonth);

        List<Integer> weekWorkTimes = new ArrayList<>(); // 주간근무시간

        String workMonth=now.toString().substring(0,7); //일한 달

        //로그인된 정보 가져오는것
        HttpSession session = req.getSession();
        HrmDto loginDto = (HrmDto)session.getAttribute("loginDto");
        int empNo = loginDto.getEmpNo();

        //일한 년도, 월을 기준으로 해당월에 대한 근무기록 dto 리턴
        WorkScheduleDao workScheduleDao = new WorkScheduleDao();
        WorkScheduleDto workScheduleDto = WorkScheduleDto.builder()
                .empNo(empNo)
                .workMonth(workMonth)
                .build();

        //해당월의 근무기록Dto를 list에 넣기
        List<WorkScheduleDto> workScheduleDtoList = workScheduleDao.getEmpWorkList(workScheduleDto); // 일한날 리스트

        Map<Integer,Integer>workDayList = new HashMap<>(); //일한날짜 리스트 일한날(key)의 일한시간(value)

        Calendar cal = Calendar.getInstance();
        cal.set(year, month - 1, 1); // 1월 = 0
        int dayLast = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        int workTime = 0;
        boolean isWork = false;
        workDayList.put(0,0); // 일수가 1부터 시작하게 0번에 임의의값 넣기
        //해당월의 근무리스트에서 일을 했다면 근무시간 기입식
        for(int i=1; i<=dayLast; i++){
            isWork=false;
            for(int j=0; j<workScheduleDtoList.size(); j++){
                if(i == Integer.parseInt(workScheduleDtoList.get(j).getWorkDate().substring(8))){
                    workDayList.put(i,8);
                    isWork=true;
                    workTime++;
                }
            }
            if(!isWork) {
                workDayList.put(i,0);
            }
        }

        int weekdaysCount = 0;
        //매달의 평일수 계산
        for (int day = 1; day <= dayLast; day++) {
            cal.set(Calendar.DAY_OF_MONTH, day);
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            // 월요일부터 금요일까지를 평일로 간주
            if (dayOfWeek != Calendar.SATURDAY && dayOfWeek != Calendar.SUNDAY) {
                weekdaysCount++;
            }
        }
        System.out.println("평일수=="+weekdaysCount);
        double workRate=((double)workTime/weekdaysCount)*100;
        String formattedRate = String.format("%.1f", workRate);

        req.setAttribute("workDayList",workDayList);
        req.setAttribute("formattedRate",formattedRate);
        // 첫 번째 날의 요일 인덱스 구하기 (일요일: 1 ~ 토요일: 7)
        int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

        // 주차별 날짜 리스트 생성
        List<List<Integer>> weekDates = new ArrayList<>();

        //달력에 들어갈 주당 일수 리스트 기입
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
        req.setAttribute("weekDates", weekDates);

        int numberOfWeeks = weekDates.size(); //해당월의 주 수
        req.setAttribute("numberOfWeeks", numberOfWeeks);
        // 주간 근무시간을 계산할 리스트 초기화
        for (int i = 0; i < weekDates.size(); i++) {
            List<Integer> week = weekDates.get(i);
            int weeklyWorkTime = 0;

            // 주간 근무시간 계산
            for (int j = 0; j < week.size(); j++) {
                int day = week.get(j);
                if (day != 0) {
                    // workDayList는 0부터 시작하므로 인덱스 조정 필요
                    weeklyWorkTime += workDayList.get(day);
                }
            }
            // 계산된 주간 근무시간을 리스트에 추가
            weekWorkTimes.add(weeklyWorkTime);
        }
        req.setAttribute("weekWorkTimes", weekWorkTimes);

        //입사일~현재까지의 근속연수 계산
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate hireDate = LocalDate.parse(loginDto.getHireDate(), formatter);

        // 두 날짜 사이의 기간을 일(day) 단위로 계산
        long hireDateToSysDate = ChronoUnit.DAYS.between(hireDate, currentDate) +1 ;
        if (hireDateToSysDate < 0) {
            hireDateToSysDate = 0;
        }

        long diffYear = hireDateToSysDate/365;
        if (diffYear != 0) {
            hireDateToSysDate %= diffYear*365;
        }

        long diffMonth = hireDateToSysDate/30;
        if (diffMonth != 0 ) {
            hireDateToSysDate %= diffMonth*30;
        }
        req.setAttribute("diffYear",diffYear);
        req.setAttribute("diffMonth",diffMonth);
        req.setAttribute("diffDay",hireDateToSysDate);

        SalaryDao salarycheckListDao = new SalaryDao();
        List<SalaryDto>salarycheckList = salarycheckListDao.getSalaryList(empNo);
        req.setAttribute("salarycheckList",salarycheckList);
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/salary/salary-check.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empNo = Integer.parseInt(req.getParameter("empNo"));
        int searchYear = Integer.parseInt(req.getParameter("year"));
        int searchMonth = Integer.parseInt(req.getParameter("month"));

        String month = req.getParameter("month");
        String year = req.getParameter("year");

        String workMonth = "";
        if(searchMonth<10){
            workMonth = req.getParameter("year").concat("-0"+req.getParameter("month"));
        }else {
        workMonth = req.getParameter("year").concat("-"+req.getParameter("month"));
        }

        //검색 월의 마지막날 찾기
        Calendar cal = Calendar.getInstance();
        cal.set(searchYear,searchMonth-1,1);
        int dayLast=cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        int firstDayOfWeek =cal.get(Calendar.DAY_OF_WEEK);
        List<List<Integer>> weekDates = new ArrayList<>();
        int dayCounter=1;

        WorkScheduleDao workScheduleDao = new WorkScheduleDao();
        WorkScheduleDto workScheduleDto = WorkScheduleDto.builder()
                .empNo(empNo)
                .workMonth(workMonth)
                .build();

        List<WorkScheduleDto> workScheduleDtoList = workScheduleDao.getEmpWorkList(workScheduleDto); // 일한날 리스트
        Map<Integer,Integer> workDayList = new HashMap<>(); //일한날짜 리스트

        boolean isWork = false;
        int workTime = 0;
        workDayList.put(0,0);
        for(int i=1; i<=dayLast; i++){
            isWork=false;
            for(int j=0; j<workScheduleDtoList.size(); j++){
                if(i == Integer.parseInt(workScheduleDtoList.get(j).getWorkDate().substring(8))){
                    workDayList.put(i,8);
                    workTime++;
                    isWork=true;
                }
            }
            if(!isWork) {
                workDayList.put(i,0);
            }
        }

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
        int numberOfWeeks = weekDates.size();

        int weekdaysCount = 0;
        //매달의 평일수 계산
        for (int day = 1; day <= dayLast; day++) {
            cal.set(Calendar.DAY_OF_MONTH, day);
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            // 월요일부터 금요일까지를 평일로 간주
            if (dayOfWeek != Calendar.SATURDAY && dayOfWeek != Calendar.SUNDAY) {
                weekdaysCount++;
            }
        }
        double workRate=((double)workTime/weekdaysCount)*100;
        String formattedRate = String.format("%.1f", workRate);

        // 응답 객체 생성
        ResponseData responseData = new ResponseData(weekDates, numberOfWeeks,workDayList,formattedRate,searchYear,searchMonth);

        Gson gson = new Gson();
        String json = gson.toJson(responseData);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.write(json);
        out.flush();
    }
    private static class ResponseData {
        List<List<Integer>> weekDates;
        Map<Integer,Integer> workDayList;
        List<SalaryDto>salarycheckList;
        String workRate;
        int month;
        int year;
        int numberOfWeeks;
        public ResponseData(List<List<Integer>> weekDates, int numberOfWeeks ,Map<Integer,Integer> workDayList,String workRate,int year , int month) {
            this.weekDates = weekDates;
            this.numberOfWeeks = numberOfWeeks;
            this.workDayList=workDayList;
            this.workRate=workRate;
            this.year=year;
            this.month=month;
        }
    }
}
