package com.hrproject.hrproject.mybatis;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class MybatisConnectionFactory {
    // SingleTon Pattern
    private static SqlSessionFactory sqlSessionFactory;
    static {
        String resource = "config.xml";
        try {
            InputStream inputStream = Resources.getResourceAsStream(resource);
            System.out.println("resource load success XD QwQ ^D^");
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
            System.out.println("session load success XD QwQ ^D^");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    public static SqlSession getSqlSession() {
        return sqlSessionFactory.openSession(); // autoCommit의 기본값은 false 이다(아무것도 안 쓰면)
    }

    public static SqlSession getSqlSession(boolean isCommit) {
        return sqlSessionFactory.openSession(isCommit);
    }
}
