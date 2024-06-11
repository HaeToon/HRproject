package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HrmDto {
    private int num;
    private int empNo;
    private String eName;
    private String foreignName;
    private int deptNo;
    private String deptName;
    private String position; // 변경된 부분
    private String mobile; // 변경된 부분
    private String passport;
    private String email;
    private String hireDate;
    private String hireType;
    private String resignDate; // 변경된 부분
    private String outReasons; // 변경된 부분
    private String bankName;
    private String account;
    private String accountHolder;
    private String postCode;
    private String address;
    private String addressDetail;
    private String originalName; // 변경된 부분
    private String renameName; // 변경된 부분
    private String etcFile;
    private String remarks;
    private int positionNo; // 테이블 정의에 없음, 필요시 추가

    // 생성자, getter, setter 등의 필요한 메서드 추가
}


