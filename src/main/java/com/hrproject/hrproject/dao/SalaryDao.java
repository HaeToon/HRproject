package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.SalaryDto;
import com.hrproject.hrproject.dto.SalaryLogDto;
import com.hrproject.hrproject.dto.SalaryPlusEmpNameDto;
import com.hrproject.hrproject.dto.SalarySearchDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class SalaryDao {
    public int insertSalaryDao(SalaryDto salaryDto) {
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        try {
            result = sqlSession.insert("insertSalary", salaryDto);
            sqlSession.commit();
            if (result > 0) {
                System.out.println("Salary insert query was successful.");
            }
        } catch (PersistenceException e) {
            System.err.println("Error inserting salary: " + e.getMessage());
            e.printStackTrace();
            result = -1;
            // Handle or rethrow the exception as needed
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
        return result;

    }

    public List<SalarySearchDto> getSalaryList() {
        List<SalarySearchDto> salaryList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        salaryList = sqlSession.selectList("getSalaryList");
        if (salaryList !=null){
            System.out.println("salary select query is successfully");
//            System.out.println("SalaryDao.java__salaryList >>> "+salaryList);
        }
        sqlSession.close();
        return salaryList;
    }

    public List<SalaryPlusEmpNameDto> getSearchSalaryList(SalarySearchDto salarySearchDto) {
        List<SalaryPlusEmpNameDto> searchSalaryList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        searchSalaryList = sqlSession.selectList("getSearchSalaryList",salarySearchDto);
        if (searchSalaryList !=null){
            System.out.println("salary select query is successfully");
            System.out.println("SalaryDao.java__salaryList >>> "+searchSalaryList);
        }
        sqlSession.close();
        return searchSalaryList;
    }

    public SalaryPlusEmpNameDto getSalaryOne(int salaryNo) {
        SalaryPlusEmpNameDto salaryPlusEmpNameDto = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        salaryPlusEmpNameDto=sqlSession.selectOne("salarySelect",salaryNo);
        if (salaryPlusEmpNameDto!=null){
            System.out.println("salarySelect Qry successfully");
        }else {
            System.out.println("salarySelact qry failed");
        }
        sqlSession.close();
        return salaryPlusEmpNameDto;
    }

    public int insertSalaryLogDao(SalaryLogDto salaryLogDto) {
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        result = sqlSession.insert("insertSalaryLog",salaryLogDto);
        //sqlSession.commit();
        if (result>0){
            System.out.println("salary insert Qry is successfully");
        }
        sqlSession.close();
        return result;


    }

    public int deleteSalary(int salary_No) {
        int result =0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        result = sqlSession.insert("deleteSalary",salary_No);

        if (result>0){
            System.out.println("salary del Qry is successfully");
        }
        sqlSession.close();
        return result;
    }

    public int updateSalaryDao(SalaryPlusEmpNameDto salaryPlusEmpNameDto) {
        int result =0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        result = sqlSession.insert("updateSalary",salaryPlusEmpNameDto);

        if (result>0){
            System.out.println("salary update Qry is successfully");
        }
        sqlSession.close();
        return result;
    }
    public int getTotalSalaryCount(String search , String searchWord){
        SalaryDao salaryTotalDao = new SalaryDao();
        if (search != null && searchWord != null) {
            return salaryTotalDao.getSalaryTotal(search, searchWord);
        } else {
            return salaryTotalDao.getSalaryTotal();
        }
    }
    public int getSalaryTotal() { //salary list 의 개수 얻기
        int total = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        total = sqlSession.selectOne("getSalaryTotal");
        sqlSession.close();

        return total;
    }
    public int getSalaryTotal(String search , String searchWord) { //salary list 의 개수 얻기
        int total = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        total = sqlSession.selectOne("getSalaryTotal");
        sqlSession.close();
        return total;
    }
}
