package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
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
import java.util.List;
import java.util.Map;

@WebServlet("/hrm/board")
@MultipartConfig
public class HrmBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");
        String searchWord = req.getParameter("searchWord");
        String url = req.getRequestURL().toString().substring(22);


        int total = getTotalHrmCount(search, searchWord); // DB에서 가져온 총 사원수
        int currentPage = getCurrentPage(req);
        int listPerPage = 15; // 페이지당 보여지는 게시물 수
        int paginationPerPage = 5; // 보여지는 페이지 수 ex : 1 ~ 5, 6 ~ 10

        int totalPage = calculateTotalPage(total, listPerPage);
        int startPage = calculateStartPage(currentPage, paginationPerPage);
        int endPage = calculateEndPage(totalPage, startPage, paginationPerPage);

        HrmPageDto hrmPageDto = createPageDto(currentPage, listPerPage, search, searchWord);
        List<HrmDto> hrmList = getHrmList(hrmPageDto);

        setRequestAttributes(req, totalPage, startPage, endPage, listPerPage, paginationPerPage, search, searchWord, hrmList);

//        insert
        HrmDao hrmDao = new HrmDao();
        int maxEmpNo = hrmDao.getMaxEmpNo();
        req.setAttribute("maxEmpNo", maxEmpNo);

        req.setAttribute("url", url);
        req.getRequestDispatcher("/WEB-INF/hrm/hrm-board.jsp").forward(req, resp);
    }

    private int getTotalHrmCount(String search, String searchWord) {
        HrmDao hrmTotalDao = new HrmDao();
        if (search != null && searchWord != null) {
            return hrmTotalDao.getHrmTotal(search, searchWord);
        } else {
            return hrmTotalDao.getHrmTotal();
        }
    }

    private int getCurrentPage(HttpServletRequest req) {
        String pageParam = req.getParameter("page");
//        넘어온 ?page= 값이 없으면 1로 설정
        if (pageParam != null) {
            return Integer.parseInt(pageParam);
        } else {
            return 1;
        }
    }

    private int calculateTotalPage(int total, int listPerPage) {
        return (int) Math.ceil((double) total / listPerPage);
    }

    private int calculateStartPage(int currentPage, int paginationPerPage) {
        if (currentPage > paginationPerPage) {
            return ((currentPage - 1) / paginationPerPage) * paginationPerPage + 1;
        } else {
            return 1;
        }
    }

    private int calculateEndPage(int totalPage, int startPage, int paginationPerPage) {
        int endPage = startPage + paginationPerPage - 1;
        if (endPage > totalPage) return totalPage;
        return endPage;
    }

    private HrmPageDto createPageDto(int page, int listPerPage, String search, String searchWord) {
        int start = (page - 1) * listPerPage;
        int end = listPerPage;

        HrmPageDto hrmPageDto = HrmPageDto.builder()
                .start(start)
                .end(end)
                .build();
        if (search != null && searchWord != null) {
            hrmPageDto.setSearch(search);
            hrmPageDto.setSearchWord(searchWord);
        }
        return hrmPageDto;
    }

    private List<HrmDto> getHrmList(HrmPageDto hrmPageDto) {
        HrmDao hrmDao = new HrmDao();
        if (hrmPageDto.getSearch() != null && hrmPageDto.getSearchWord() != null) {
            return hrmDao.getSearchHrmBoardList(hrmPageDto);
        } else {
            return hrmDao.getHrmBoardList(hrmPageDto);
        }
    }

    private void setRequestAttributes(HttpServletRequest req, int totalPage, int startPage, int endPage, int listPerPage, int paginationPerPage, String search, String searchWord, List<HrmDto> hrmList) {
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("startPage", startPage);
        req.setAttribute("endPage", endPage);
        req.setAttribute("previousPage", startPage - 1);
        req.setAttribute("nextPage", startPage + paginationPerPage);
        req.setAttribute("listPerPage", listPerPage);
        req.setAttribute("search", search);
        req.setAttribute("searchWord", searchWord);
        req.setAttribute("hrmList", hrmList);

        req.setAttribute("showModal", "view");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        /* 예외처리 */
        boolean inputCheck = req.getParameter("empNo") == null || req.getParameter("empNo").equals("")
                || req.getParameter("ename") == null || req.getParameter("ename").equals("")
                || req.getParameter("mobile") == null || req.getParameter("mobile").equals("")
                || req.getParameter("email") == null || req.getParameter("email").equals("")
                || req.getParameter("hireDate") == null || req.getParameter("hireDate").equals("");
        HrmDao hrmGetMaxDao = new HrmDao();
        int maxEmpNo = hrmGetMaxDao.getMaxEmpNo();
        if (Integer.parseInt(req.getParameter("empNo")) == maxEmpNo + 1 || inputCheck) {


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

            Map<Integer, String> deptMap = new HashMap<>();
            deptMap.put(10, "개발팀");
            deptMap.put(20, "영업팀");
            deptMap.put(30, "인사팀");
            deptMap.put(40, "회계팀");
            int deptNo = Integer.parseInt(req.getParameter("deptNo"));

            Map<Integer, String> positionMap = new HashMap<>();
            // 사원 대리 과장 차장 대표이사
            positionMap.put(10, "사원");
            positionMap.put(20, "대리");
            positionMap.put(30, "과장");
            positionMap.put(40, "차장");
            positionMap.put(50, "대표이사");
            int positionNo = Integer.parseInt(req.getParameter("positionNo"));

        /*HrmDto hrmDto = HrmDto.builder()
                .deptNo(10)
                .deptName(deptMap.get(10))
                .build();*/

            HrmDto hrmDto = HrmDto.builder()
                    .empNo(Integer.parseInt(req.getParameter("empNo")))
                    .ename(req.getParameter("ename"))

                    .foreignName(req.getParameter("foreignName"))

                    .deptNo(deptNo)
                    .deptName(deptMap.get(deptNo))

                    .positionNo(positionNo)
                    .position(positionMap.get(positionNo))

                    .mobile(req.getParameter("mobile"))
                    .passport(req.getParameter("passport"))
                    .email(req.getParameter("email"))

                    .hireDate(req.getParameter("hireDate"))
                    .hireType(req.getParameter("hireType"))

                    .bankName(req.getParameter("bankName"))
                    .account(req.getParameter("account"))
                    .accountHolder(req.getParameter("accountHolder"))

                    .postCode(req.getParameter("postCode"))
                    .address(req.getParameter("address"))
                    .addressDetail(req.getParameter("addressDetail"))

                    .originalProfile(fileName)
                    .renameProfile(renameProfile)
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
}