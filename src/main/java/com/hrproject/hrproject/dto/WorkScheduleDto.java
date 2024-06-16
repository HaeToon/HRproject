package com.hrproject.hrproject.dto;


import lombok.*;

@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
@AllArgsConstructor
public class WorkScheduleDto {
    private int workIdx;
    private int empNo;
    private String workDate;
    private String startTime;
    private String endTime;
    private String duration;
    private String status;
    private String etc;

}
