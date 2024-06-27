package com.hrproject.hrproject.controller.hrm;

import com.google.gson.Gson;
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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/hrm/update")
@MultipartConfig
public class HrmUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empNo = 0;
        if (req.getParameter("empNo") != null) empNo = Integer.parseInt(req.getParameter("empNo"));

        HrmDao hrmDao = new HrmDao();
        HrmDto hrmDto = hrmDao.getHrm(empNo);
        Gson gson = new Gson();
        String json = gson.toJson(hrmDto);

        // JSON 형식으로 응답 설정
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /* 예외처리 try catch 어케함?? */
        /* empNo 수정버튼 누른거랑 다른값 들어오면 막아야함 */
//        if (req.getParameter("empNo_password_update") != null) {
//            HrmDao hrmDao = new HrmDao();
//            HrmDto hrmDto = HrmDto.builder()
//                    .empNo(Integer.parseInt(req.getParameter("empNo_password_update")))
//                    .password(req.getParameter("empNo_password_update"))
//                    .build();
//            int result = hrmDao.changePW(hrmDto);
//            if (result > 0) {
//                ScriptWriter.alertAndNext(resp, "비밀번호 초기화 되었습니다.", "../hrm/board");
//                return;
//            } else {
//                ScriptWriter.alertAndBack(resp, "오류가 발생했습니다. 다시 시도해주세요.");
//                return;
//            }
//        }

        if (!isNullCheck(req)) {
            Part profile = req.getPart("profile");
            String renameProfile = "";
            //String originalProfile = "";

            String fileName = profile.getSubmittedFileName();
            String serverUploadDir = this.getServletContext().getRealPath("upload");
            File dir = new File(serverUploadDir);
            if (!dir.exists()) {
                dir.mkdir();
            }
            if (!fileName.isEmpty()) {
                profile.write(serverUploadDir + File.separator + fileName); // 원본파일을 미리 써놓기
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
                        .size(100, 200)
                        .toFiles(dir, Rename.NO_CHANGE);
                oldFile.renameTo(newFile);
            }
            // 서버에 이미지 올리는것도 다 돈이다.

            HrmMap hrmMap = new HrmMap();
            Map<Integer, String> deptMap = hrmMap.getDeptMap();
            int deptNo = Integer.parseInt(req.getParameter("deptNo"));

            Map<Integer, String> positionMap = hrmMap.getPositionMap();
            int positionNo = Integer.parseInt(req.getParameter("positionNo"));


            String passport = req.getParameter("passport");
            if (passport.equals("")) passport = null;
            HrmDto hrmDto = HrmDto.builder()
                    .empNo(Integer.parseInt(req.getParameter("empNo")))
                    .ename(req.getParameter("ename"))
                    .foreignName(req.getParameter("foreignName"))
                    .birthDate(req.getParameter("birthDate"))
                    .password("password")

                    .deptNo(deptNo)
                    .deptName(deptMap.get(deptNo))
                    .posNo(positionNo)
                    .posName(positionMap.get(positionNo))
                    .roleName(req.getParameter("roleName"))
                    .hireDate(req.getParameter("hireDate"))
                    .hireType(req.getParameter("hireType"))
                    .passport(passport)
                    .mobile(req.getParameter("mobile"))
                    .account(req.getParameter("account"))
                    .email(req.getParameter("email"))

                    .bankName(hrmMap.getBankMap().get(Integer.parseInt(req.getParameter("bankName"))))
                    .accountHolder(req.getParameter("accountHolder"))
                    .postCode(req.getParameter("postCode"))
                    .address(req.getParameter("address"))
                    .addressDetail(req.getParameter("addressDetail"))

                    .originalProfile(fileName)
                    .renameProfile(renameProfile)
                    .remarks(req.getParameter("remarks"))
                    .build();

            HrmDao updateHrmDao = new HrmDao();
            int updateHrmResult = updateHrmDao.updateHrm(hrmDto);
            if (updateHrmResult > 0) {
                ScriptWriter.alertAndNext(resp, "사원 정보가 수정되었습니다.", "../hrm/board");
            } else {
                ScriptWriter.alertAndBack(resp, "오류가 발생했습니다. 다시 시도해주세요.");
            }
        } else {
            ScriptWriter.alertAndBack(resp, "오류가 발생했습니다.(필수입력사항) 다시 시도해주세요.");
        }
    }

    private static boolean isNullCheck(HttpServletRequest req) {
        boolean nullCheck = req.getParameter("empNo") == null || req.getParameter("empNo").equals("")
                || req.getParameter("ename") == null || req.getParameter("ename").equals("")
                || req.getParameter("birthDate") == null || req.getParameter("birthDate").equals("")
                || req.getParameter("mobile") == null || req.getParameter("mobile").equals("")
                || req.getParameter("email") == null || req.getParameter("email").equals("")
                || req.getParameter("hireDate") == null || req.getParameter("hireDate").equals("")
                || req.getParameter("account") == null || req.getParameter("account").equals("")
                || req.getParameter("postCode") == null || req.getParameter("postCode").equals("")
                || req.getParameter("address") == null || req.getParameter("address").equals("");
        return nullCheck;
    }
}
