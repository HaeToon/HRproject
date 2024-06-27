package com.hrproject.hrproject.dto;

import com.hrproject.hrproject.controller.hrm.Grade;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EvaluationDto {
    private int evaluationNo;
    private int empNo;
    private String evaluationYear;
    private String performanceGrade;
    private String comments;
    private boolean promote;
    private int yosYear; // 근속년수
    private int yosMonth; // 근속월수
    private double attendanceRate;
}
