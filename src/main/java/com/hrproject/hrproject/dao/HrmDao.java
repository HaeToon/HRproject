package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.EvaluationDto;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;
import org.mindrot.jbcrypt.BCrypt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HrmDao {

    public HrmDto getHrmByLoginEmpno(int loginEmpno) {
       HrmDto hrmList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmList = sqlSession.selectOne("getHrmByLoginEmpno", loginEmpno);
        sqlSession.close();
        return hrmList;
    }


    public int insertHrm(HrmDto hrmDto) {
        int result = 0;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.insert("insertHrm", hrmDto);

        sqlSession.close();
        return result;
    }

    public int updateHrm(HrmDto hrmDto) {
        int result = 0;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.update("updateHrm", hrmDto);

        sqlSession.close();
        return result;
    }

    //    public int setShowAbleHrm(int[] noArray) {
    /* 일괄 삭제 할때 쓸거 */
//        int result = 0;
//
//        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
//        result = sqlSession.delete("setShowAbleHrm", noArray);
//        sqlSession.close();
//        return result;
//    }
    public int setShowAbleHrm(HrmDto hrmDto) {
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        result = sqlSession.update("setShowAbleHrm", hrmDto);
        sqlSession.close();
        return result;
    }

    public HrmDto getHrm(int empNo) {
        HrmDto hrmDto = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmDto = sqlSession.selectOne("getHrm", empNo);
        sqlSession.close();

        return hrmDto;
    }

    public int getHrmTotal() { // 이걸 Modal 안에 사용할거니까
        int total = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        total = sqlSession.selectOne("getHrmTotal");
        sqlSession.close();

        return total;
    }

    public int getHrmTotal(String search, String searchWord) {
        int total = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        Map<String, String> searchMap = new HashMap<>();
        searchMap.put("search", search);
        searchMap.put("searchWord", searchWord);
        total = sqlSession.selectOne("getSearchHrmTotal", searchMap);
        sqlSession.close();

        return total;
    }

    public List<HrmDto> getHrmBoardList(HrmPageDto hrmPageDto) {
        List<HrmDto> hrmList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmList = sqlSession.selectList("getHrmList", hrmPageDto);
        sqlSession.close();
        return hrmList;
    }

    public List<HrmDto> getSearchHrmBoardList(HrmPageDto hrmPageDto) {
        List<HrmDto> hrmList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmList = sqlSession.selectList("getSearchHrmList", hrmPageDto);
        sqlSession.close();
        return hrmList;
    }

    public List<HrmDto> getSearchEmpNoByName(String searchName) { //salary insert modal의 search modal용
        List<HrmDto> empNoList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        empNoList = sqlSession.selectList("getSearchEmpNoByName", searchName);
        sqlSession.close();
        return empNoList;
    }

    public int getMaxEmpNo() {
        int maxEmpNo = 1;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        maxEmpNo = sqlSession.selectOne("getMaxEmpNo");
        sqlSession.close();

        return maxEmpNo;
    }

    public HrmDto login(int empNo, String password) {
        HrmDto hrmDto = null;
        HrmDao hrmDao = new HrmDao();
        if (hrmDao.getHrm(empNo) == null) return hrmDto; // 로그인하려는 empNo 없음연 리턴

        String hashPassword = hrmDao.getHrm(empNo).getPassword();
        if (password.equals(hashPassword)) hrmDto = hrmDao.getHrm(empNo); // 비밀번호 변경전 empNo=password면 이걸로 로그인
        else if (BCrypt.checkpw(password, hashPassword)) hrmDto = hrmDao.getHrm(empNo); // 비밀번호 변경후 로그인
        return hrmDto;
    }

    public List<HrmDto> getEmpNoList() {
        List<HrmDto> empNoList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        empNoList = sqlSession.selectList("getEmpNoList");
        sqlSession.close();
        return empNoList;
    }

//연차 계산용으로 만들었습니다
public int getUsedAnnualLeaveDays(int empNo) {
    int usedAnnualLeaveDays = 0;
    SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
    try {
        usedAnnualLeaveDays = sqlSession.selectOne("com.hrproject.hrproject.dao.HrmDao.getUsedAnnualLeaveDays", empNo);
    } finally {
        sqlSession.close();
    }
    return usedAnnualLeaveDays;
}

    public int duplicateCheck(String check, String checkValue) {
        int result = 0;
        Map<String, String> duplicateCheckMap = new HashMap<>();
        duplicateCheckMap.put("check", check);
        duplicateCheckMap.put("checkValue", checkValue);
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.selectOne("duplicateCheck", duplicateCheckMap);
        sqlSession.close();
        return result;
    }

    public int changePW(HrmDto hrmDto) {
        int result = 0;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.update("changeHrmPw", hrmDto);

        sqlSession.close();
        return result;
    }

    public int insertHrmList(List<HrmDto> hrmDtoList) {
        int result = 0;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        for (HrmDto hrmDto : hrmDtoList) {
            result += sqlSession.insert("insertHrm", hrmDto);
        }

        sqlSession.close();
        return result;
    }

    //     getWorkStatus
    public int getWorkStatus(int empNo) {
        int result = 0;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.selectOne("getWorkStatus", empNo);
        sqlSession.close();

        return result;
    }

    public EvaluationDto getHrmEval(int empNo) {
        EvaluationDto evaluationDto = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        evaluationDto = sqlSession.selectOne("getHrmEval", empNo);
        sqlSession.close();

        return evaluationDto;
    }

//    public int createHrmEval(int empNo) {
//        int result = 0;
//        /* TOTALWORKDAYS % days_since_hire = 출근율 = EvaluationScore */
//        /* 모든 직원중 최대 출근율 기준점으로 잡고 나머지 계산?  */
////        double score = (double) getTotalWorkDays(empNo) / (double) getDaysSinceHire(empNo);
//        double score =  (double) 4000 / (double) getDaysSinceHire(empNo);
//        EvaluationDto evaluationDto = EvaluationDto.builder()
//                .empNo(empNo)
//                .performanceScore(score)
//                .build();
//
//        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
//        result = sqlSession.insert("createHrmEval", evaluationDto);
//        sqlSession.close();
//        return result;
//    }
//
//    public int getDaysSinceHire(int empNo) {
//        int result = 0;
//        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
//        result = sqlSession.selectOne("getDaysSinceHire", empNo);
//        sqlSession.close();
//        return result;
//    }

    public int getTotalWorkDays(int empNo) {
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.selectOne("getTotalWorkDays", empNo);
        sqlSession.close();
        return result;
    }

    //// HrmEval 관련 getHrm 보드
    public List<HrmDto> getHrmEvalBoardList(HrmPageDto hrmPageDto) {
        List<HrmDto> hrmList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmList = sqlSession.selectList("getEvalHrmList", hrmPageDto);
        sqlSession.close();
        return hrmList;
    }

    public List<HrmDto> getHrmEvalSearchBoardList(HrmPageDto hrmPageDto) {
        List<HrmDto> hrmList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmList = sqlSession.selectList("getEvalSearchHrmList", hrmPageDto);
        sqlSession.close();
        return hrmList;
    }
}