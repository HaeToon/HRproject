package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.WorkScheduleDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class WorkScheduleDao {
    public List<WorkScheduleDto> getEmpWorkList(int empNo) {
        List<WorkScheduleDto> salaryList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        salaryList = sqlSession.selectList("getWorkList",empNo);
        if (salaryList !=null){
            System.out.println("Work select query is successfully");
//            System.out.println("SalaryDao.java__salaryList >>> "+salaryList);
        }
        sqlSession.close();
        return salaryList;
    }


    public WorkScheduleDto getTodaySchedule(String date) {
        WorkScheduleDto dto = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        dto = sqlSession.selectOne("getTodaySchedule",date);
        if (dto !=null){
            System.out.println("Work select query is successfully");
//            System.out.println("SalaryDao.java__salaryList >>> "+salaryList);
        }
        sqlSession.close();

        return dto;
    }

    public void createAllEmpSchedule(List<HrmDto> empNoList) {

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        sqlSession.insert("createAllEmpSchedule",empNoList);
        sqlSession.close();
    }
}
