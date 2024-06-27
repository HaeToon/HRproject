package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.CommunityDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommunityDao {
    public List<CommunityDto> getCommunityList(){

        List<CommunityDto>communityList=null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        communityList = sqlSession.selectList("getCommunityList");
        sqlSession.close();
        return communityList;
    }

    public int insertCommunityDao(CommunityDto communityDto) {
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        result = sqlSession.insert("insertCommunity",communityDto);
        //sqlSession.commit();
        if (result>0){
            System.out.println("community insert Qry is successfully");
        }
        sqlSession.close();
        return result;

    }

    //제목을 누르면 커뮤니티 내용을 볼수 있음
    public CommunityDto getCommunityByCommunityNo(int communityNo) {
        CommunityDto community = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        try {
            community = sqlSession.selectOne("getCommunityByCommunityNo", communityNo);
        } finally {
            sqlSession.close();
        }
        return community;
    }


    public static CommunityDto getCommunityById(int communityNo) {
        CommunityDto community = null;
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true)) {
            community = sqlSession.selectOne("getCommunityByCommunityNo", communityNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return community;
    }

    public int deleteCommunity(int communityNo) {
        int result = 0;
        try (SqlSession session = MybatisConnectionFactory.getSqlSession(true)) {
            result = session.delete("deleteCommunity", communityNo);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<CommunityDto> searchCommunity(String search, String searchWord) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            Map<String, Object> parameterMap = new HashMap<>();
            parameterMap.put("search", search);
            parameterMap.put("searchWord", "%" + searchWord + "%");

            List<CommunityDto> communityList = sqlSession.selectList("searchCommunity", parameterMap);
            System.out.println("search query is successful");
            System.out.println(communityList); // 가져온 데이터 로깅

            return communityList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }

    public void incrementViews(int communityNo) {
        try (SqlSession session = MybatisConnectionFactory.getSqlSession(true)) {
            session.update("com.hrproject.hrproject.dao.CommunityDao.incrementViews", communityNo);
            session.commit();
        }
    }

    public void updateCommunity(CommunityDto community) {
        try (SqlSession session = MybatisConnectionFactory.getSqlSession(true)) {
            session.update("updateCommunity", community);
            session.commit();
        }
    }

}
