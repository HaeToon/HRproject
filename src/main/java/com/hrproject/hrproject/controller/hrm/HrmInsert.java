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
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

@WebServlet("/hrm/insert")
@MultipartConfig
public class HrmInsert extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getParameter("addEmployee").equals("addEmployee")) {
            /* 사원 추가 */
            List<HrmDto> hrmDtoList = new ArrayList<>();
            HrmDao getMaxEmpNo = new HrmDao();
            int maxEmpNo = getMaxEmpNo.getMaxEmpNo() + 1;
            for (int i = 0; i < 30; i++) {
                Random random = new Random();
                int deptNo = 10 + random.nextInt(3) * 10;  // 10, 20, 30 중 하나 선택
                int positionNo = 10 + random.nextInt(3) * 10;  // 10, 20, 30 중 하나 선택
                int year = ThreadLocalRandom.current().nextInt(1980, 2000); // 1980 이상, 2000 미만 (1999까지)
                int month = ThreadLocalRandom.current().nextInt(1, 12); // 1 이상, 13 미만 (1부터 12까지)
                int day = ThreadLocalRandom.current().nextInt(2, 25); // 1 이상, 31 미만 (1부터 30까지)
                // 날짜를 "yyyy-MM-dd" 형식으로 포맷팅
                String dateStr = String.format("%04d-%02d-%02d", year, month, day);
                int month2 = ThreadLocalRandom.current().nextInt(1, 12); // 1 이상, 13 미만 (1부터 12까지)
                int day2 = ThreadLocalRandom.current().nextInt(2, 25); // 1 이상, 31 미만 (1부터 30까지)
                String dateStrHire = String.format("%04d-%02d-%02d", year+20, month2, day2);

                HrmMap hrmMap = new HrmMap();

                HrmDto hrmDto = HrmDto.builder()
                        .empNo(maxEmpNo + i)
                        .ename("Employee" + (i + maxEmpNo))
                        .foreignName("ForeignName" + (i + maxEmpNo))
                        .birthDate(dateStr)
                        .password(Integer.toString(maxEmpNo + i))
                        .deptNo(deptNo)
                        .deptName(hrmMap.getDeptMap().get(deptNo))
                        .posNo(positionNo)
                        .posName(hrmMap.getPositionMap().get(positionNo))
                        .roleName("팀원")
                        .mobile("010-" + (i + maxEmpNo))
                        .passport("Pas" + (i + maxEmpNo))
                        .email("ee" + (i + maxEmpNo) + "@ee.co")
                        .hireDate(dateStrHire)
                        .hireType("신입")
                        .bankName(hrmMap.getBankMap().get(2))
                        .account("Acc" + (i + maxEmpNo))
                        .accountHolder("AccHolder" + (i + 1))
                        .postCode(Integer.toString(12345 + i))
                        .address("Address" + (i + 1))
                        .addressDetail("AddressDetail" + (i + 1))
                        .remarks("Remarks" + (i + 1))
                        .grade(Grade.MEMBER)
                        .build();
                hrmDtoList.add(hrmDto);
            }
            HrmDao hrmDao = new HrmDao();
            int result = hrmDao.insertHrmList(hrmDtoList);
            if (result > 0) {
                ScriptWriter.alertAndNext(resp, result + "명의 사원 정보가 입력되었습니다.", "../hrm/board");
            } else {
                ScriptWriter.alertAndBack(resp, "오류가 발생했습니다. 다시 시도해주세요.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /* 예외처리 try catch 어케함?? */

        HrmDao hrmGetMaxDao = new HrmDao();
        int maxEmpNo = hrmGetMaxDao.getMaxEmpNo();
        if (Integer.parseInt(req.getParameter("empNo")) == maxEmpNo + 1 || !isNullCheck(req)) {
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

                // 서버에 이미지 올리는것도 다 돈이다.
            }
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
                    .password(req.getParameter("empNo"))

                    .deptNo(deptNo)
                    .deptName(deptMap.get(deptNo))
                    .posNo(positionNo)
                    .posName(positionMap.get(positionNo))
                    .roleName(req.getParameter("roleName"))

                    .mobile(req.getParameter("mobile"))
                    .passport(passport)
                    .email(req.getParameter("email"))

                    .hireDate(req.getParameter("hireDate"))
                    .hireType(req.getParameter("hireType"))

                    .bankName(hrmMap.getBankMap().get(Integer.parseInt(req.getParameter("bankName"))))
                    .account(req.getParameter("account"))
                    .accountHolder(req.getParameter("accountHolder"))
                    .postCode(req.getParameter("postCode"))
                    .address(req.getParameter("address"))
                    .addressDetail(req.getParameter("addressDetail"))

                    .originalProfile(fileName)
                    .renameProfile(renameProfile)
                    .remarks(req.getParameter("remarks"))
                    .grade(Grade.MEMBER)
                    .build();

            HrmDao hrmDao = new HrmDao();
            int result = hrmDao.insertHrm(hrmDto);
            if (result > 0) {
                ScriptWriter.alertAndNext(resp, "사원 정보가 입력되었습니다.", "../hrm/board");
            } else {
                ScriptWriter.alertAndBack(resp, "오류가 발생했습니다. 다시 시도해주세요.");
            }
        } else {
            ScriptWriter.alertAndBack(resp, "오류가 발생했습니다. 다시 시도해주세요.");
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
