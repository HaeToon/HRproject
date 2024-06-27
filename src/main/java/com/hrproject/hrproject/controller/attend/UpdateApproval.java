// com.hrproject.hrproject.controller.attend.AttendController.java
package com.hrproject.hrproject.controller.attend;


import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dto.AttendDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;


@WebServlet("/attend/updateApproval")
public class UpdateApproval extends HttpServlet {
//    private SqlSessionFactory sqlSessionFactory;
//
//    @Override
//    public void init() throws ServletException {
//        String resource = "mybatis-config.xml";
//        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream(resource)) {
//            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
//        } catch (IOException e) {
//            throw new ServletException("Error initializing MyBatis", e);
//        }
//    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        AttendDao attendDao = new AttendDao();
        String atdNo = req.getParameter("atdNo");
        String approval = req.getParameter("approval");

        System.out.println("atdNo: " + atdNo);
        System.out.println("approval: " + approval);

        AttendDto attendDto = AttendDto.builder()
                .atdNo(atdNo)
                .approval(approval)
                .build();

        attendDao.updateApproval(attendDto);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"success\": true}");
    }
}
