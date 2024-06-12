package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.NoticeDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class NoticeDao {
    public List<NoticeDto> getNoticeList(){
        List<NoticeDto>noticeList=null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        noticeList = sqlSession.selectList("getNoticeList");
        sqlSession.close();
        return noticeList;
    }
}
