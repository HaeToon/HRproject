package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.controller.hrm.HrmMap;
import com.hrproject.hrproject.dto.EvaluationDto;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
        if (BCrypt.checkpw(password, hashPassword)) hrmDto = hrmDao.getHrm(empNo); // 비밀번호 변경후 로그인
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

    public int promote(int empNo) {
        int result = 0;
        HrmDto hrmDto = getHrm(empNo);
        HrmMap hrmMap = new HrmMap();
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String today = now.format(formatter);

        EvaluationDto evaluationDto = EvaluationDto.builder()
                .empNo(empNo)
                .evaluationYear(today)
                .comments(hrmMap.getPositionMap().get(hrmDto.getPosNo()) + " ==> "+hrmMap.getPositionMap().get(hrmDto.getPosNo()+10))
                .promote(false)
                .build();
        result = createEvaluation(evaluationDto);

        if (result == 0) return result;
        else result = 0;

        if (hrmDto.getPosNo()<50) {
            hrmDto.setPosNo(hrmDto.getPosNo()+10);
            hrmDto.setPosName(hrmMap.getPositionMap().get(hrmDto.getPosNo()));
        }
        else return result;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.update("promote", hrmDto);

        sqlSession.close();
        return result;
    }

    public List<HrmDto> getHrmEvaluationList() {
        List<HrmDto> hrmList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmList = sqlSession.selectList("getHrmEvaluationList");
        sqlSession.close();
        return hrmList;
    }

    public EvaluationDto getEvaluation(int empNo){
        EvaluationDto evaluationDto = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        evaluationDto = sqlSession.selectOne("getEvaluation", empNo);
        sqlSession.close();

        return evaluationDto;
    }
    public int createEvaluation(EvaluationDto evaluationDto) {
        int result = 0;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.insert("createEvaluation", evaluationDto);

        sqlSession.close();
        return result;
    }
    public int updateEvaluation(EvaluationDto evaluationDto) {
        int result = 0;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        result = sqlSession.update("updateEvaluation", evaluationDto);

        sqlSession.close();
        return result;
    }

}