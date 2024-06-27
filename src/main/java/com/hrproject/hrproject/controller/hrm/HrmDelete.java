package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.utils.ScriptWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/hrm/delete")
public class HrmDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empNo = 0;
        if (req.getParameter("empNo") != null) empNo = Integer.parseInt(req.getParameter("empNo"));
        System.out.println(empNo);
        String outReasons = req.getParameter("outReasons");
        String resignDate = req.getParameter("resignDate");
        if (resignDate.equals("")){
            resignDate = null;
        }

        HrmDao hrmDao = new HrmDao();
        HrmDto hrmDto = HrmDto.builder()
                .empNo(empNo)
                .outReasons(outReasons)
                .resignDate(resignDate)
                .build();
        int result = hrmDao.setShowAbleHrm(hrmDto);
        if (result > 0) {
            ScriptWriter.alertAndNext(resp, "사원 삭제가 완료되었습니다.", "../hrm/board");
        } else {
            ScriptWriter.alertAndBack(resp, "오류가 발생했습니다. 다시 시도해주세요.");
        }
    }
}