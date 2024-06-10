package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class HrmDto {
    private int num;
    private int empNo;
    private String eName;
    private String foreignName;
    private int deptNo;
    private String deptName;
    private String positionName;
    private String mobileNumber;
    private String passport;
    private String email;
    private String hireDate;
    private String hireType;
    private String resignationDate;
    private String outReason;
    private String bankName;
    private String account;
    private String accountHolder;
    private String postCode;
    private String address;
    private String addressDetail;
    private String originalProfile;
    private String renameProfile;
    private String etcFile;
    private String remarks;
    private int positionNo;

}

