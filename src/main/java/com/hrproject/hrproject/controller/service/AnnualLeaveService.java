package com.hrproject.hrproject.controller.service;
import com.hrproject.hrproject.controller.attend.AnnualLeaveCalculator;
import com.hrproject.hrproject.controller.mapper.AttendMapper;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;


import com.hrproject.hrproject.dto.AttendDto;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class AnnualLeaveService {

    private final SqlSessionFactory sqlSessionFactory;

    // 생성자에서 MyBatis의 SqlSessionFactory를 초기화합니다.
    public AnnualLeaveService() {
        this.sqlSessionFactory = MybatisConnectionFactory.getSqlSessionFactory();
    }

    // 직원의 연차 정보를 계산하고 HrmDto 객체에 설정하여 반환하는 메서드입니다.
    public HrmDto getAnnualLeaveInfo(String empNo) {
        try (SqlSession session = sqlSessionFactory.openSession()) {
            // MyBatis의 매퍼 인터페이스를 이용해 연차 관련 데이터를 조회합니다.
            AttendMapper mapper = session.getMapper(AttendMapper.class);
            LocalDate hireDate = mapper.getHireDateByEmpNo(empNo); // 직원의 입사일을 가져옵니다.
            List<HrmDto> usedLeaves = mapper.selectOffdaysByEmpNo(empNo); // 직원의 사용한 휴가 리스트를 가져옵니다.

            // 만약 직원의 입사일이 null이 아니라면 연차 정보를 계산하고 설정합니다.
            if (hireDate != null) {
                AnnualLeaveCalculator calculator = new AnnualLeaveCalculator();
                int totalAnnualLeaveDays = calculator.calculateAnnualLeave(hireDate); // 총 연차 일수를 계산합니다.
                int usedAnnualLeaveDays = (int) usedLeaves.stream()
                        .filter(leave -> leave.getAtdCode().equals("연차"))
                        .count(); // 사용한 연차 일수를 계산합니다.

                // 결과를 담을 HrmDto 객체를 생성하고 설정합니다.
                HrmDto result = new HrmDto();
                result.setEmpNo(Integer.parseInt(empNo)); // 사원 번호 설정
                result.setHireDate(String.valueOf(hireDate)); // 입사일 설정
                result.setUsedLeaves(usedLeaves.toString()); // 사용한 휴가 리스트 설정
                result.setUsedAnnualLeaveDays(usedAnnualLeaveDays); // 사용한 연차 일수 설정
                result.setRemainingAnnualLeaveDays(totalAnnualLeaveDays - usedAnnualLeaveDays); // 남은 연차 일수 설정


                // 현재 날짜를 가져와서 입사일부터 오늘까지의 근무 일수를 계산하여 설정합니다.
                LocalDate today = LocalDate.now();
                long workDays = calculateWorkDays(hireDate, today); // 근무일수 계산 메서드 사용
                result.setWorkDays(workDays);

                return result;
            } else {
                return null; // 입사일이 없는 경우 null을 반환합니다.
            }
        }
    }

    // 입사일로부터의 근무일수를 계산하는 메서드
    private long calculateWorkDays(LocalDate startDate, LocalDate endDate) {
        // 주말 및 공휴일을 제외한 근무일수를 계산하는 로직을 추가하여 사용하세요.
        return java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate);
    }
}
