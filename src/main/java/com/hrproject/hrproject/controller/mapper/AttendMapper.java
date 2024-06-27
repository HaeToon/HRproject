package com.hrproject.hrproject.controller.mapper;

import com.hrproject.hrproject.dto.HrmDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface AttendMapper {

    LocalDate getHireDateByEmpNo(@Param("empNo") String empNo);

    List<HrmDto> selectOffdaysByEmpNo(@Param("empNo") String empNo);
}
