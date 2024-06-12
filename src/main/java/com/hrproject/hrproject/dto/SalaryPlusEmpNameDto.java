package com.hrproject.hrproject.dto;


import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Setter
@Getter
@ToString
public class SalaryPlusEmpNameDto {
    private int salary_No; //급여 번호 메인 키
    private int empNo;      // 사원번호 // 외래키
    private String ename;  // 사원 이름 + HRM table에서 받아와야함!
    private String accountingPeriod;  //근무 연월 / 근무한 월
    private String salaryCategory;     //지급구분
    private String salaryName;          //급여구분
    private String salaryDay;           //지급날짜
    private int salary;                 //돈!
    private String salaryInfo;          //급여내역

}
