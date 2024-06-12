package com.hrproject.hrproject.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class HrmDto {
    private int num;
    private int empNo; // 사원번호
    private String ename; // 이름
    private String foreignName; // 영문성명
    private int deptNo; // 부서번호
    private String deptName; // 부서명
    private String position; // 직급
    private String mobile; // 휴대폰번호
    private String passport; // 여권번호
    private String email; // 이메일
    private String hireDate; // 입사일자
    private String hireType; // 입사구분
    private String resignDate; // 퇴사일자
    private String outReasons; // 퇴사사유
    private String bankName; // 은행명
    private String account; // 계좌번호
    private String accountHolder; // 예금주
    private String postCode; // 주소 ~
    private String address;
    private String addressDetail; // ~ 주소
    private String originalProfile;
    private String renameProfile; // 프로필사진
    private String etcFile; // 기타첨부파일
    private String remarks; // 비고?
    private int positionNo; // 직급코드
    private int role; // 직책



    // 생성자, getter, setter 등의 필요한 메서드 추가
}


