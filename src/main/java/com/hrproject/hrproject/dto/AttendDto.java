package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AttendDto {
    private int empNo; //사원번호
    private String atdNo; //근태번호
    private String ename; //사원명
    private String atdCode; //근태코드
    private double atdNum; //근태수
    private String atdDate; //근태기간
    private String offDay; //휴가명
    private String offDayRs; //휴가사유
    private String print; //인쇄
}
