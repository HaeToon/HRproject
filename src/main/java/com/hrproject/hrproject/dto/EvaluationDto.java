package com.hrproject.hrproject.dto;

import lombok.*;

@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
@AllArgsConstructor
public class EvaluationDto {
    private int empNo;
    private int evaluationNo;
//    private String evaluationYear;
    private double performanceScore;
    private String performanceGrade;
    private boolean isPromotable;
    private String comments;
    private int daysSinceHire;
    private int totalWorkDays;
}
