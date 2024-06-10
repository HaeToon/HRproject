package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HrmDao {
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

    public HrmDto getHrm(int no) {
        HrmDto hrmDto = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmDto = sqlSession.selectOne("getHrm", no);

        sqlSession.commit();
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
        total = sqlSession.selectOne("getHrmTotal", searchMap);
        sqlSession.commit();
        sqlSession.close();

        return total;
    }
    public List<HrmDto> getHrmList(HrmPageDto hrmPageDto) {
        List<HrmDto> hrmList =  null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmList = sqlSession.selectList("getHrmList", hrmPageDto);
        sqlSession.commit();
        sqlSession.close();
        return hrmList;

    }

    public List<HrmDto> getSearchHrmList(HrmPageDto pageListDto) {
        List<HrmDto> hrmList = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        hrmList = sqlSession.selectList("getSearchHrmList", pageListDto);
        sqlSession.close();
        return hrmList;
    }
}