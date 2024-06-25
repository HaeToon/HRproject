package com.hrproject.hrproject.controller.workSchedule;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dao.UtilDao;
import com.hrproject.hrproject.dao.WorkScheduleDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.WorkScheduleDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

//사원용 출퇴근 기록 보드
@WebServlet("/workSchedule/empWorkBoard")
public class empWorkBoard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 로그인을 통해서 현재 접속자 empNo를 받는다.
        HttpSession session = req.getSession();
        HrmDto loginDto = (HrmDto) session.getAttribute("loginDto");
        int empNo = loginDto.getEmpNo();

        int page = 1;
        int recordsPerPage = 20;

        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        // 페이지 제한 + 사원 출력
        WorkScheduleDao workScheduleDao = new WorkScheduleDao();
        int noOfRecords = workScheduleDao.getNoOfRecords(empNo);
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);


        //로그인에서 받은 empNo를 통해 DB에서  워크스케쥴를 받는다.
        List<WorkScheduleDto> empWorkList = workScheduleDao.getEmpWorkList(empNo);

        req.setAttribute("empWorkList", empWorkList);
        req.setAttribute("noOfPages", noOfPages);
        req.setAttribute("currentPage", page);
        req.getRequestDispatcher("/WEB-INF/workSchedule/board-empWork.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 오늘 날짜 설정 (현재 날짜를 사용하려면 LocalDate.now() 사용)
        LocalDate currentDate = LocalDate.now();
        // 현재 시각 설정 (현재 시각을 사용하려면 LocalTime.now() 사용)
        LocalTime currentTime = LocalTime.now();
        // 세션으로 로그인된 사람의 empNo를 받아옴
        HttpSession session = req.getSession();
        HrmDto loginDto = (HrmDto) session.getAttribute("loginDto");
        int empNo = loginDto.getEmpNo();

        String Date = currentDate.toString(); // LocalDate는 ISO 형식으로 문자열로 변환됨
        String Time = currentTime.toString(); // LocalTime은 ISO 형식으로 문자열로 변환됨


        WorkScheduleDao workScheduleDao = new WorkScheduleDao();
        AttendDao attendDao = new AttendDao();
        HrmDao hrmDao = new HrmDao();

        List<AttendDto> attendDtoList = null;
        String atdNo = null;
        double duration = 0;

        // 여기에서 init 하는게 아니라 어디론가 옮겨야한다.
        // 오늘자 워크스케쥴러 init
        // 오늘날짜 DB 있는지 체크
        if (workScheduleDao.getTodaySchedule(Date).isEmpty()) {
            // 오늘날짜 DB가 없으니까 전사원 대상 오늘 날짜 DB생성
            System.out.println("today DB doesnt exist");
            // 모든 사원의 empNo 리스트를 받아서 DB 생성
            List<HrmDto> empNoList = hrmDao.getEmpNoList();

            //오늘이 주말인지 확인한다!
            UtilDao utilDao = new UtilDao();
            String day_type = utilDao.getDayType();
            // 평일이면
            if (empNoList != null&&day_type.equals("Weekday")) {
                System.out.println("List로 전 사원 empNo 받음");
                // 전 사원 대상 워크스케쥴러 만들기
                workScheduleDao.createAllEmpSchedule(empNoList);
                //주말이면 워크스케쥴러에 주말이라고 뜸
            } else if (empNoList != null&&day_type.equals("Weekend")) {
                workScheduleDao.createAllEmpScheduleWeekend(empNoList);

            }
        }

        // 작동 순서 궁금하면 보세용~
        // 전 사원 HRM정보를 받아서 while문 돌면서 현재 인덱스의 empNo를 뽑느다.
        // HRM_DB에서 받은 empNo를 통해서 ATTEND_DB를 휴가날짜를 조회한다.
        // 휴가날짜가 "YYYY-MM-DD ~ YYYY-MM-DD" 이기 때문에,
        // 공백 제거 후 "~" 기준으로 값을 쪼개서 배열에 담는다.
        // 그 배열의 타입은 String이기에 날짜타입으로 바꾼다.
        // 그 포맷한 날짜를 사이의 날짜를 뽑는다.
        // 그리고 그 날짜가 현재 날짜와 비교를 하고, 동일하다면,
        // ATTEND_DB에서 atdNo와 atdCode를 받아와서
        // 워크스케쥴_DB를 업데이트한다.


        // 오늘자 워크스케쥴러 휴가상태 업데이트
        List<HrmDto> empNoList = hrmDao.getEmpNoList();
        boolean run = true;
        int idx = 0;
        int empListSize = empNoList.size();
        String vacationCode = null;

        while (run && idx < empListSize) {
            if (empNoList.get(idx) != null) {
                int empNoIdx = empNoList.get(idx).getEmpNo();
                attendDtoList = attendDao.getAttendListByEmpNo(empNoIdx);
                for (AttendDto attendDto : attendDtoList) {
                    String date = attendDto.getAtdDate().trim();
                    String dateRange = date.replaceAll("\\s+", "");
                    String[] dates = dateRange.split("~");
                    String startDateStr = dates[0].trim();
                    String endDateStr = dates[1].trim();
                    DateTimeFormatter formatterDate = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    LocalDate startDate = LocalDate.parse(startDateStr, formatterDate);
                    LocalDate endDate = LocalDate.parse(endDateStr, formatterDate);
                    List<String> allDates = new ArrayList<>();
                    LocalDate tempDate = startDate;
                    while (!tempDate.isAfter(endDate)) {
                        allDates.add(tempDate.format(formatterDate));
                        tempDate = tempDate.plusDays(1);
                    }
                    // 오늘날짜 확인
                    for (String dateStr : allDates) {
                        if (dateStr.equals(Date)) {
                            atdNo = attendDto.getAtdNo();
                            if (attendDto.getApproval().equals("승인")){
                                vacationCode  = attendDto.getAtdCode();
                            }else if (attendDto.getApproval().equals("대기")){
                                vacationCode = null;
                            }
                        }

                    }

                    WorkScheduleDto workScheduleDto = WorkScheduleDto.builder()
                            .empNo(attendDto.getEmpNo())
                            .atdNo(atdNo)
                            .vacationCode(vacationCode)
                            .workDate(Date)
                            .build();
                    int updateResult = workScheduleDao.updateWorkSchedule(workScheduleDto);
                    if (updateResult > 0) {
                        System.out.println("workScheduleDao.updateWorkSchedule(workScheduleDto) 성공");
                    }
                }
                idx++;
            } else {
                run = false;
            }
        }

        Map<String, Object> empNoDateMap = new HashMap<>();
        empNoDateMap.put("empNo", empNo);
        empNoDateMap.put("date", Date);

        // 클라이언트에서 버튼을 누를 시 출근시간,퇴근시간, 출근,퇴근 남기는 로직
        // 쓸데없는 로직이 있는데, 수정하기엔 조금 무섭네요 ㅜ
        WorkScheduleDto workScheduleDto = workScheduleDao.getWorkScheduleOne(empNoDateMap);
        if (workScheduleDto.getStartTime() == null) {
            workScheduleDto.setStartTime(Time);
            try {
                String strStatus = workScheduleDto.getStatus();
                if (strStatus != null) {
                    List<String> statusList = new ArrayList<>(Arrays.asList(strStatus.split("/")));
                    statusList.add("출근");
                    String combinedString = String.join("/", statusList);
                    workScheduleDto.setStatus(combinedString);
                } else {
                    workScheduleDto.setStatus("출근");
                }
            } catch (
                    NullPointerException e) {
                e.printStackTrace();
            }
            workScheduleDao.updateWorkStartTime(workScheduleDto);
            resp.sendRedirect("/workSchedule/empWorkBoard");
        } else if (workScheduleDto.getStartTime() != null && workScheduleDto.
                getEndTime() == null) {
            workScheduleDto.setEndTime(Time);
            String strStatus = workScheduleDto.getStatus();
            List<String> statusList = new ArrayList<>(Arrays.asList(strStatus.split("/")));
            for (int i = 0; i < statusList.size(); i++) {
                String status = statusList.get(i);
                if (status.equals("출근")) {
                    status = "퇴근";
                    statusList.set(i, status);
                }
            }
            String combinedString = String.join("/", statusList);
            workScheduleDto.setStatus(combinedString);
            workScheduleDao.updateWorkEndTime(workScheduleDto);
            resp.sendRedirect("/workSchedule/empWorkBoard");
        } else if (workScheduleDto.getStartTime() != null && workScheduleDto.getEndTime() != null) {

            // JavaScript를 사용하여 경고창을 표시하고 확인 클릭 시 특정 페이지로 이동
            String alertScript = "<script>"
                    + "alert('이미 기록이 있습니다. 수정은 관리자에게 문의해주세요.');"
                    + "window.location.href = '/workSchedule/empWorkBoard';"  // 확인을 누르면 이동할 페이지
                    + "</script>";

            resp.setContentType("text/html; charset=UTF-8");

            PrintWriter out = resp.getWriter();
            out.println(alertScript);
            out.flush();
        }
    }
}
