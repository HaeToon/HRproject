package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.NoticeDto;
import com.hrproject.hrproject.dto.SalaryDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NoticeDao {
    public List<NoticeDto> getNoticeList(){
        List<NoticeDto>noticeList=null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        noticeList = sqlSession.selectList("getNoticeList");
        sqlSession.close();
        System.out.println(noticeList.toString());
        return noticeList;
    }

    public int insertNoticeDao(NoticeDto noticeDto) {
        int result = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        result = sqlSession.insert("insertNotice",noticeDto);
        //sqlSession.commit();
        if (result>0){
            System.out.println("notice insert Qry is successfully");
        }
        sqlSession.close();
        return result;

    }

    //제목을 누르면 공지사항의 내용을 볼수 있음
    public NoticeDto getNoticeByNoticeNo(int noticeNo) {
        NoticeDto notice = null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        try {
            notice = sqlSession.selectOne("getNoticeByNoticeNo", noticeNo);
        } finally {
            sqlSession.close();
        }
        return notice;
    }


    public static NoticeDto getNoticeById(int noticeNo) {
        NoticeDto notice = null;
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true)) {
            notice = sqlSession.selectOne("getNoticeByNoticeNo", noticeNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notice;
    }

    public int deleteNotice(int noticeNo) {
        int result = 0;
        try (SqlSession session = MybatisConnectionFactory.getSqlSession(true)) {
            result = session.delete("deleteNotice", noticeNo);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<NoticeDto> searchNotice(String search, String searchWord) {
        try (SqlSession sqlSession = MybatisConnectionFactory.getSqlSession()) {
            Map<String, Object> parameterMap = new HashMap<>();
            parameterMap.put("search", search);
            parameterMap.put("searchWord", "%" + searchWord + "%");

            List<NoticeDto> noticeList = sqlSession.selectList("searchNotice", parameterMap);
            System.out.println("search query is successful");
            System.out.println(noticeList.toString()); // 가져온 데이터 로깅

            return noticeList;
        } catch (Exception e) {
            // 예외 발생 시 처리
            e.printStackTrace(); // 혹은 로깅
            return null; // 또는 예외를 상위로 다시 throw
        }
    }

    public void incrementViews(int noticeNo) {
        try (SqlSession session = MybatisConnectionFactory.getSqlSession(true)) {
            session.update("com.hrproject.hrproject.dao.NoticeDao.incrementViews", noticeNo);
            session.commit();
        }
    }

    public void updateNotice(NoticeDto notice) {
        try (SqlSession session = MybatisConnectionFactory.getSqlSession(true)) {
            session.update("updateNotice", notice);
            session.commit();
        }
    }

}
