package com.hrproject.hrproject.dto;


import lombok.*;

@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
@AllArgsConstructor
public class WorkScheduleLogDto {
    private int workIdx;
    private int empNo;
    private String workDate;
    private String startTime;
    private String endTime;
    private String duration;
    private String status;
    private String atdNo;
    private String vacationCode;
    private String etc;

    private String modifyReason;        //왜 수정함?
    private String whoModify;           // 누가 수정함?
    private String logDate;             // 언제 수정함?
    private String logStatus;           // 수정이면 M 삭제면 D

}
