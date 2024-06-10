package com.hrproject.hrproject.controller.hrm;

import com.leekiye.jhta2024semiproject.dao.HrmDao;
import com.leekiye.jhta2024semiproject.dto.HrmDto;
import com.leekiye.jhta2024semiproject.utils.ScriptWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/")
public class UpdateHrm extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/hrm/updateHrm.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 사원 정보 업데이트 할때 바뀌는 정보들
        // 이름(개명), 영어이름(개명), 부서번호(부서이동), 폰번, 이메일, 퇴사일, 퇴사사유
        // 계좌관련, 우편번호, 집주소관련, 프로필사진관련
        HrmDto hrmDto = HrmDto.builder()
                .empNo(Integer.parseInt(req.getParameter("empNo")))
                .eName(req.getParameter("eName"))
                .foreignName(req.getParameter("foreignName"))
                .deptNo(Integer.parseInt(req.getParameter("deptNo")))
                .deptName(req.getParameter("deptName"))
                .positionName(req.getParameter("positionName"))
                .mobileNumber(req.getParameter("mobileNumber"))
                .passport(req.getParameter("passport"))
                .email(req.getParameter("email"))
                .hireDate(req.getParameter("hireDate"))
                .hireType(req.getParameter("hireType"))
                .resignationDate(req.getParameter("resignationDate"))
                .outReason(req.getParameter("outReason"))
                .bankName(req.getParameter("bankName"))
                .account(req.getParameter("account"))
                .accountHolder(req.getParameter("accountHolder"))
                .postCode(req.getParameter("postCode"))
                .address(req.getParameter("address"))
                .addressDetail(req.getParameter("addressDetail"))
                .originalProfile(req.getParameter("originalProfile"))
                .renameProfile(req.getParameter("renameProfile"))
                .etcFile(req.getParameter("etcFile"))
                .remarks(req.getParameter("remarks"))
                .positionNo(Integer.parseInt(req.getParameter("positionNo"))) // 새로운 컬럼에 대한 데이터 추가
                .build();

        HrmDao hrmDao = new HrmDao();
        int result = hrmDao.updateHrm(hrmDto);
        if (result > 0) {
            ScriptWriter.alertAndNext(resp, "사원정보 수정이 완료되었습니다.", "../index/index");
        } else {
            ScriptWriter.alertAndBack(resp, "이런 제길! 다시 시도해주세요(알 수 없는 오류)");
        }

    }
}
