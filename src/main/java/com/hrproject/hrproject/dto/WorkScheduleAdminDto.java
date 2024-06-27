package com.hrproject.hrproject.dto;


import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@ToString
public class WorkScheduleAdminDto {
    private int workIdx;
    private int empNo;
    private String workDate;
    private String deptName; //HRM에서 가져오기
    private String ename;   //HRM에서 가져오기
    private String startTime;
    private String endTime;
    private String duration; //start랑 end 계산 DB에는 없음
    private String status;
    private String vacationCode;
    private String etc;



}
