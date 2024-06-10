/*
package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.utils.ScriptWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.name.Rename;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@MultipartConfig
@WebServlet("/hrm/hrm-board")
public class InsertHrm extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/hrm/hrm-board.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part profile = req.getPart("profile");

        String fileName = profile.getSubmittedFileName();
        String renameProfile = "";
        String serverUploadDir = this.getServletContext().getRealPath("upload");
        File dir = new File(serverUploadDir);
        if(!dir.exists()){
            dir.mkdir();
        }

        if(!fileName.isEmpty()) {
            profile.write(serverUploadDir+File.separator+fileName); // 원본파일을 미리 써놓기
            String first = fileName.substring(0, fileName.lastIndexOf(".")); // 파일명은 항상 파일명.확장자명 으로 들어올테니 .을 구분
            String extension = fileName.substring(fileName.lastIndexOf("."));
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter dateTimeFormatter =
                    DateTimeFormatter.ofPattern("YYYYMMdd_hhmmss");

            String formatNow = now.format(dateTimeFormatter);
            renameProfile = first + "_" + formatNow + extension;

            File oldFile = new File(serverUploadDir + File.separator + fileName);
            File newFile = new File(serverUploadDir + File.separator + renameProfile);

            Thumbnails.of(oldFile)
                    //.sourceRegion(Positions.CENTER,100,200);
                    .size(100,200)
                    .toFiles(dir, Rename.NO_CHANGE);
            oldFile.renameTo(newFile);

            // 서버에 이미지 올리는것도 다 돈이다.
        }

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
        int result = hrmDao.insertHrm(hrmDto);
        if (result > 0) {
            ScriptWriter.alertAndNext(resp, "사원정보 입력이 완료되었습니다.", "../index/index");
        } else {
            ScriptWriter.alertAndBack(resp, "이런 제길! 다시 시도해주세요(알 수 없는 오류)");
        }

    }
}
*/
