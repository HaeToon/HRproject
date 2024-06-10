package com.hrproject.hrproject.dao;

import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
import com.hrproject.hrproject.mybatis.MybatisConnectionFactory;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServlet;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

@WebFilter("/")
public class HrmDao extends HttpServlet {

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

    public HrmDto selectHrm(int no) {
        HrmDto hrmDto = null;

        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        hrmDto = sqlSession.selectOne("selectHrm", no);

        sqlSession.commit();
        sqlSession.close();

        return hrmDto;
    }

    public int getHrmTotal() { // 이걸 Modal 안에 사용할거니까
        int total = 0;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);
        total = sqlSession.selectOne("getHrmTotal");
        sqlSession.commit();
        sqlSession.close();

        return total;
    }


    public List<HrmDto> getHrmBoardList(HrmPageDto hrmPageDto) {
        List<HrmDto> hrmList =  null;
        SqlSession sqlSession = MybatisConnectionFactory.getSqlSession(true);

        hrmList = sqlSession.selectList("getHrmBoardList", hrmPageDto);
        sqlSession.commit();
        sqlSession.close();

        return hrmList;

    }
}
