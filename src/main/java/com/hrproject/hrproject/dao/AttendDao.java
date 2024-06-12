package com.hrproject.hrproject.dao;


import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AttendDao {

    public List<AttendDto> searchAttend(String search, String searchWord) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            Map<String, Object> parameterMap = new HashMap<>();
            parameterMap.put("search", search);
            parameterMap.put("searchWord", "%" + searchWord + "%");

            List<AttendDto> attendList = sqlSession.selectList("searchAttend", parameterMap);
            System.out.println("search query is successful");
            System.out.println(attendList); // 가져온 데이터 로깅

            return attendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }


    public int insertAttendDao(AttendDto attendDto) {
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        result = sqlSession.insert("insertAttend",attendDto);
        //sqlSession.commit();
        if (result>0){
            System.out.println("attend insert Qry is successfully");
        }
        sqlSession.close();
        return result;

    }

    public List<AttendDto> getAttendList() {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> attendList = sqlSession.selectList("getAttendList");
            System.out.println("select query is successfully");
            System.out.println(attendList); // 가져온 데이터 로깅

            return attendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }

    public int updateAttend(AttendDto attendDto) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            int result = sqlSession.update("updateAttend", attendDto);
            sqlSession.commit();  // Ensure the transaction is committed
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public int updateAttendList(List<AttendDto> attendList) {
        int totalUpdated = 0;
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            for (AttendDto attendDto : attendList) {
                int result = sqlSession.update("updateAttend", attendDto);
                totalUpdated += result;
            }
            sqlSession.commit();  // Ensure the transaction is committed
            return totalUpdated;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
