package com.hrproject.hrproject.dto;


import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class SalaryDto {
    private int salaryNo; //급여 번호 메인 키
    private int empNo;      // 사원번호 // 외래키
    private String accountingPeriod;  //근무 연월 / 근무한 월
    private String salaryCategory;     //지급구분
    private String salaryName;          //급여구분
    private String salaryDay;           //지급날짜
    private int salary;                 //돈!
    private String salaryInfo;          //급여내역
    private int bonus;                  //
//    private int total;
}


