package com.hrproject.hrproject.dto;

import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AttendDto {
    private int empNo;            // 사원번호
    private String atdNo;         // 근태번호
    private String ename;         // 사원명
    private String atdCode;       // 근태코드
    private double atdNum;        // 근태수
    private String atdDate;       // 근태기간
    private String startAtdDate;  // 시작 근태기간
    private String endAtdDate;    // 끝 근태기간
    private String offDay;        // 휴가명
    private String offDayRs;      // 휴가사유
    private String print;         // 인쇄
    private LocalDate hireDate;   // 입사일
    private int yearsOfWork;      // 근속 연수
    private String annualLeaveDays;  // 연차 일수


    @Override
    public String toString() {
        return "AttendDto{" +
                "empNo=" + empNo +
                ", atdNo='" + atdNo + '\'' +
                ", ename='" + ename + '\'' +
                ", atdCode='" + atdCode + '\'' +
                ", atdNum=" + atdNum +
                ", atdDate='" + atdDate + '\'' +
                ", startAtdDate='" + startAtdDate + '\'' +
                ", endAtdDate='" + endAtdDate + '\'' +
                ", offDay='" + offDay + '\'' +
                ", offDayRs='" + offDayRs + '\'' +
                ", print='" + print + '\'' +
                ", hireDate=" + hireDate +
                ", yearsOfWork=" + yearsOfWork +
                ", annualLeaveDays=" + annualLeaveDays +
                '}';
    }

    public void setRemainingAnnualLeaveDays(int i) {
    }

    public void setEmpName(String ename) {
    }
}

