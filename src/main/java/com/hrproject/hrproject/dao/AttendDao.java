package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AttendDao {

    public List<AttendDto> searchLoginAttend(String search, String searchWord, int empNo) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            Map<String, Object> parameterMap = new HashMap<>();
            parameterMap.put("search", search);
            parameterMap.put("searchWord", "%" + searchWord + "%");
            parameterMap.put("empNo", empNo);

            List<AttendDto> attendList = sqlSession.selectList("searchLoginAttend", parameterMap);
            System.out.println("search query is successful");
            //System.out.println(attendList); // 가져온 데이터 로깅

            return attendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }


    //처리 완료된 근태 출력
    public List<AttendDto> getAcceptedAttendList() {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> acceptedAttendList = sqlSession.selectList("getAcceptedAttendList");
            System.out.println("acceptedAttendList = " + acceptedAttendList);
            return acceptedAttendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            System.out.println(" acceptedAttendList fail ....................." + e);
            return null; // 또는 예외를 상위로 다시 throw
        }
    }

    //승인 상태의 근태만 출력
    public List<AttendDto> getApprovedAttendList() {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> attendList = sqlSession.selectList("getApprovedAttendList");
            return attendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }



    //대기 중인 근태만 출력
    public List<AttendDto> getWaitingAttendList() {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> attendList = sqlSession.selectList("getWaitingAttendList");
            System.out.println("select query is successfully");
            return attendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }


    // 근태 승인 여부 업데이트
    public void updateApproval(AttendDto attendDto) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            sqlSession.update("updateApproval", attendDto);
            sqlSession.commit();
        }
    }


    // 삭제 메서드 추가
    public int deleteAttend(String atdNo) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            int result = sqlSession.delete("deleteAttend", atdNo);
            sqlSession.commit();  // Ensure the transaction is committed
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }




    public List<AttendDto> searchWaiting(String search, String searchWord) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            Map<String, Object> parameterMap = new HashMap<>();
            parameterMap.put("search", search);
            parameterMap.put("searchWord", "%" + searchWord + "%");

            List<AttendDto> attendList = sqlSession.selectList("searchWaitingAttend", parameterMap);
            System.out.println("search query is successful");
            //System.out.println(attendList); // 가져온 데이터 로깅

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
            //System.out.println(attendList); // 가져온 데이터 로깅

            return attendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }

    public AttendDto getUpdateInfo(String atdNo){
        AttendDto attendDto = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        attendDto=sqlSession.selectOne("getUpdateInfo",atdNo);
        sqlSession.close();
        return attendDto;
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



//    출퇴근 기록에서 필요해서 만들었습니다!!
    public List<AttendDto> getAttendListByEmpNo(int empNo) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> attendList = sqlSession.selectList("getAttendListByEmpNo", empNo);
            System.out.println("getAttendListByEmpNo query is successfully");
            System.out.println("attendList >>> " + attendList); // 가져온 데이터 로깅

            return attendList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅

            return null; // 또는 예외를 상위로 다시 throw
        }
    }
    public int checkEmpNo(String empNo){
        int result =0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result=sqlSession.selectOne("countByEmpNo",empNo);
        sqlSession.close();
        return result;
    }

    public int checkAtdNo(String atdNo){
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result=sqlSession.selectOne("countByAtdNo",atdNo);
        sqlSession.close();
        return result;

    }

    // 휴가정보 관련
    public List<AttendDto> selectOffdaysByEmpNo(int empNo) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> offdaysList = sqlSession.selectList("com.hrproject.hrproject.mybatis.selectOffdaysByEmpNo", empNo);
            System.out.println("selectOffdaysByEmpNo query is successful");
            for (AttendDto dto : offdaysList) {
                System.out.println(dto); // 각 DTO의 내용을 로깅
            }
            return offdaysList;
        } catch (Exception e) {
            e.printStackTrace(); // 혹은 로깅
            return null;
        }
    }

    public List<AttendDto> selectOffdaysByDepartment(String department) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> offdaysList = sqlSession.selectList("com.hrproject.hrproject.mybatis.selectOffdaysBySearch", Map.of("search", "department", "searchWord", department));
            System.out.println("selectOffdaysByDepartment query is successful");
            for (AttendDto dto : offdaysList) {
                System.out.println(dto); // 각 DTO의 내용을 로깅
            }
            return offdaysList;
        } catch (Exception e) {
            e.printStackTrace(); // 혹은 로깅
            return null;
        }
    }

    public List<AttendDto> selectOffdaysByAtdCode(String atdCode) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> offdaysList = sqlSession.selectList("com.hrproject.hrproject.mybatis.selectOffdaysBySearch", Map.of("search", "atdCode", "searchWord", atdCode));
            System.out.println("selectOffdaysByAtdCode query is successful");
            for (AttendDto dto : offdaysList) {
                System.out.println(dto); // 각 DTO의 내용을 로깅
            }
            return offdaysList;
        } catch (Exception e) {
            e.printStackTrace(); // 혹은 로깅
            return null;
        }
    }

    public List<AttendDto> selectOffdaysByEmpName(String empName) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            List<AttendDto> offdaysList = sqlSession.selectList("com.hrproject.hrproject.mybatis.selectOffdaysByEmpName", empName);
            System.out.println("selectOffdaysByEmpName query is successful");
            for (AttendDto dto : offdaysList) {
                System.out.println(dto); // 각 DTO의 내용을 로깅
            }
            return offdaysList;
        } catch (Exception e) {
            e.printStackTrace(); // 혹은 로깅
            return null;
        }
    }



}



