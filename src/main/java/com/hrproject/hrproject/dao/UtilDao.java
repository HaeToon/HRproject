package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import org.apache.ibatis.session.SqlSession;

public class UtilDao {
    public String getDayType() {
        String day_type = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession();
        day_type = sqlSession.selectOne("getDayType");
        sqlSession.close();

        return day_type;
    }
}
