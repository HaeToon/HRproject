package com.hrproject.hrproject.controller.hrm;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum Grade {
    //열거형 제한 getter, 속성가지는 생성자
    MEMBER("member"),
    ADMIN("admin");
    private final String label;
}