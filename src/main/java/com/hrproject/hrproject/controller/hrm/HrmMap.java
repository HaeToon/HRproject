package com.hrproject.hrproject.controller.hrm;

import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class HrmMap {
    public Map<Integer, String> getPositionMap() {
        Map<Integer, String> positionMap = new TreeMap<>();
        // 사원 대리 과장 차장 대표이사
        positionMap.put(10, "사원");
        positionMap.put(20, "대리");
        positionMap.put(30, "과장");
        positionMap.put(40, "차장");
        positionMap.put(50, "대표이사");
        return positionMap;
    }

    public Map<Integer, String> getDeptMap() {
        Map<Integer, String> deptMap = new TreeMap<>();
        deptMap.put(10, "근태관리팀");
        deptMap.put(20, "급여관리팀");
        deptMap.put(30, "인사관리팀");
        deptMap.put(40, "개발팀");
        deptMap.put(50, "기획팀");
        return deptMap;
    }

    public Map<Integer, String> getBankMap() {
        Map<Integer, String> bankMap = new TreeMap<>();
        bankMap.put(1, "한국은행");
        bankMap.put(2, "국민은행");
        bankMap.put(3, "기업은행");
        bankMap.put(4, "외환은행");
        bankMap.put(5, "국민농협");
        bankMap.put(6, "우리은행");
        bankMap.put(7, "신한은행");
        bankMap.put(8, "하나은행");
        bankMap.put(9, "SC제일은행");
        bankMap.put(10, "케이뱅크");
        bankMap.put(11, "카카오뱅크");
        bankMap.put(12, "씨티은행");
        bankMap.put(13, "스탠다드차타드은행");
        return bankMap;
    }
}
