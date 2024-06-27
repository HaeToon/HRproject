package com.hrproject.hrproject.controller.attend;

import com.hrproject.hrproject.dto.HrmDto;

import java.time.LocalDate;
import java.time.Period;

public class AnnualLeaveCalculator {

    // 연차 계산 메서드
    public int calculateAnnualLeave(LocalDate hireDate) {
        LocalDate today = LocalDate.now();
        Period period = Period.between(hireDate, today);
        int yearsOfService = period.getYears();

        int annualLeave = 0;

        // 근속 연수에 따라 연차 부여 규칙 적용
        if (yearsOfService < 1) {
            // 1년 미만 근속
            annualLeave = calculateLessThanOneYear(hireDate, today);
        } else if (yearsOfService >= 1 && yearsOfService <= 3) {
            // 1년 이상 ~ 3년 이하 근속
            annualLeave = 15; // 기본 연차는 15일
        } else {
            // 3년 이상 근속
            annualLeave = 15; // 기본 연차는 15일

            // 매 2년마다 추가 가산 연차 부여 (이직 시 초기화됨)
            for (int i = 3; i <= yearsOfService; i += 2) {
                annualLeave++;
            }
        }

        return annualLeave;
    }

    // 1년 미만 근속자 연차 계산
    private int calculateLessThanOneYear(LocalDate hireDate, LocalDate today) {
        Period period = Period.between(hireDate, today);
        int monthsWorked = period.getMonths();
        int leaveDays = monthsWorked; //월 만근 수

        return leaveDays;
    }

    // 테스트용 메인 메서드
    public static void main(String[] args) {
        // 테스트용 입사일 설정
        LocalDate hireDate = LocalDate.of(2022, 8, 15); // 예시 입사일

        // AttendDto 생성
        HrmDto hrmDto = new HrmDto();
        hrmDto.setHireDate(String.valueOf(hireDate));

        // 연차 계산기 인스턴스 생성
        AnnualLeaveCalculator calculator = new AnnualLeaveCalculator();

        // 연차 계산
        int annualLeave = calculator.calculateAnnualLeave(LocalDate.parse(hrmDto.getHireDate()));
        System.out.println("연차: " + annualLeave);
    }
}
