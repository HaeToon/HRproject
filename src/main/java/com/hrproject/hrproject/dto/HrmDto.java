package com.hrproject.hrproject.dto;

import com.hrproject.hrproject.controller.hrm.Grade;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class HrmDto {
    private int empNo;
    private String ename;
    private String foreignName;
    private String birthDate;
    private String password;
    private int deptNo;
    private String deptName;
    private int posNo;
    private String posName;
    private String roleName;
    private String mobile;
    private String passport;
    private String email;
    private String bankName;
    private String account;
    private String accountHolder;
    private String postCode;
    private String address;
    private String addressDetail;
    private String hireDate;
    private String hireType;
    private String resignDate;
    private String outReasons;
    private String originalProfile;
    private String renameProfile; // 프로필사진
    private String etcFile; // 기타첨부파일
    private String remarks; // 비고?
    private int positionNo; // 직급코드
    private int role; // 직책
    private int oldEmpNo;
    // 생성자, getter, setter 등의 필요한 메서드 추가




    // 연차 관련 추가 필드 입니다

    private long workDays; // 입사일로부터의 근무일수
    private String usedLeaves; // 사용한 휴가 리스트
    private int usedAnnualLeaveDays; // 사용한 연차 일수
    private String atdCode; // 근태 코드
    private int remainingAnnualLeaveDays; // 남은 연차 일수
    private int salary;
    private Grade grade;
    private boolean showable;
    private int yosYear; // 근속년수
    private int yosMonth; // 근속월수
    private int workedDays; // 출퇴근한 일수
    private double attendanceRate;
    private boolean isPromotable;
    private String isPromo;
}

