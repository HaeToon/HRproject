package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.utils.ScriptWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.Objects;

import static com.hrproject.hrproject.controller.hrm.LoginLogout.isInteger;

@WebServlet("/hrm/change-password")
public class ChangePassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String empNo = req.getParameter("empNo");

        String changePW = req.getParameter("changePassword");
        String changePWConfirm = req.getParameter("changePasswordConfirm");

        if (Objects.equals(changePW, changePWConfirm) && empNo != null) {
            String salt = BCrypt.gensalt();
            String hashPassword = BCrypt.hashpw(changePW, salt);

            HrmDto hrmDto = HrmDto.builder()
                    .empNo(Integer.parseInt(req.getParameter("empNo")))
                    .password(hashPassword)
                    .build();

            HrmDao changePWDao = new HrmDao();
            int changePWResult = changePWDao.changePW(hrmDto);
            if (changePWResult > 0) {
                ScriptWriter.alertAndNext(resp, "사원 비밀번호가 변경되었습니다.", "../hrm/board");
            } else {
                ScriptWriter.alertAndBack(resp, "오류가 발생했습니다. 다시 시도해주세요.");
            }
        } else {
            ScriptWriter.alertAndBack(resp, "비밀번호가 맞지 않습니다. 다시 시도해주세요.");
        }

    }
}
