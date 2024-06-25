package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.EvaluationDto;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
import com.hrproject.hrproject.utils.ScriptWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

@WebServlet("/hrm/evaluation")
@MultipartConfig
public class Evaluations extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        /* 페이지네이션 및 검색 기능 */
        String search = req.getParameter("search");
        String searchWord = req.getParameter("searchWord");
        int total = getTotalHrmCount(search, searchWord); // DB에서 가져온 총 사원수
        int currentPage = getCurrentPage(req);
        int listPerPage = 15; // 페이지당 보여지는 게시물 수
        int paginationPerPage = 5; // 보여지는 페이지 수 ex : 1 ~ 5, 6 ~ 10
        int totalPage = calculateTotalPage(total, listPerPage);
        int startPage = calculateStartPage(currentPage, paginationPerPage);
        int endPage = calculateEndPage(totalPage, startPage, paginationPerPage);
        HrmPageDto hrmPageDto = createPageDto(currentPage, listPerPage, search, searchWord);


        /* 승진대상자 페이지면(param 값으로 판단) 승진대상자만 보임 */
        List<HrmDto> hrmList = null;
        String promoteParam = req.getParameter("promote");
        if ("true".equals(promoteParam)) {
            HrmDao hrmdao = new HrmDao();
            hrmList = hrmdao.getHrmEvaluationList();
        } else {
//            HrmDao hrmdao = new HrmDao();
//            hrmList = hrmdao.getAllHrmEvalList();
            hrmList = getHrmList(hrmPageDto);
        }

        /* 사원별 Evaluations table 생성 및 업데이트 */
        List<EvaluationDto> evaluationList = new ArrayList<>(); // board에 내려줄때 씀
        for (HrmDto hrmDto : hrmList) {
            String grade = "";
            boolean promote = false;

             /* 근무 성과 A ~ D (출석률) */
            if (hrmDto.getAttendanceRate() > 98) grade = "A";
            else if (hrmDto.getAttendanceRate() > 95) grade = "B";
            else if (hrmDto.getAttendanceRate() > 90) grade = "C";
            else if (hrmDto.getAttendanceRate() > 80) grade = "D";
            else grade = "F";

            /* 입사일 or 진급일부터 오늘까지 일한 날(개월) */
            int yosMonth = 0;
            if (hrmDto.getPosNo() == 10) yosMonth = hrmDto.getYosYear() * 12 + hrmDto.getYosMonth();
            else {
                HrmDao hrmDao = new HrmDao();
                EvaluationDto evaluationDto = hrmDao.getEvaluation(hrmDto.getEmpNo());
                if (evaluationDto == null) {
                    HrmDao hrmDaoCreateEvaluation = new HrmDao();
                    evaluationDto = EvaluationDto.builder()
                            .empNo(hrmDto.getEmpNo())
                            .evaluationYear(hrmDto.getHireDate())
                            .comments("...")
                            .build();
                    hrmDaoCreateEvaluation.createEvaluation(evaluationDto);
                }
                yosMonth = evaluationDto.getYosYear() * 12 + evaluationDto.getYosMonth();
            }
            /* 근무성과 진급 가산점 계산 */
            if (grade.equals("A")) yosMonth += 24;
            else if (grade.equals("B")) yosMonth += 12;
            else if (grade.equals("C")) yosMonth += 0;
            else if (grade.equals("D")) yosMonth -= 12;
            else yosMonth -= 60;
            /* 직급별 진급에 필요한 근무개월수 */
            if (hrmDto.getPosNo() == 10 && yosMonth > 60) promote = true;
            else if (hrmDto.getPosNo() == 20 && yosMonth > 72) promote = true;
            else if (hrmDto.getPosNo() == 30 && yosMonth > 84) promote = true;
            else if (hrmDto.getPosNo() == 40 && yosMonth > 96) promote = true;

             /*사원 평가 Evaluation 테이블 생성 및 업데이트*/
            HrmDao hrmDao = new HrmDao();
            if (hrmDao.getEvaluation(hrmDto.getEmpNo()) == null) {
                HrmDao hrmDaoCreateEvaluation = new HrmDao();
                EvaluationDto evaluationDto = EvaluationDto.builder()
                        .empNo(hrmDto.getEmpNo())
                        .evaluationYear(hrmDto.getHireDate())
                        .performanceGrade(grade)
                        .promote(promote)
                        .comments("...")
                        .build();
                hrmDaoCreateEvaluation.createEvaluation(evaluationDto);
            } else {
                HrmDao hrmDaoUpdateEvaluation = new HrmDao();
                EvaluationDto evaluationDto = EvaluationDto.builder()
                        .performanceGrade(grade)
                        .promote(promote)
                        .empNo(hrmDto.getEmpNo())
                        .build();
                hrmDaoUpdateEvaluation.updateEvaluation(evaluationDto);
            }

            HrmDao hrmGetEvaluationDao = new HrmDao();
            EvaluationDto evaluationDto = hrmGetEvaluationDao.getEvaluation(hrmDto.getEmpNo());
            evaluationList.add(evaluationDto);
        }


        setRequestAttributes(req, totalPage, startPage, endPage, listPerPage, paginationPerPage, search, searchWord, hrmList, evaluationList);
        req.getRequestDispatcher("/WEB-INF/hrm/evaluation-board.jsp").forward(req, resp);
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
            return hrmDao.getHrmEvalSearchBoardList(hrmPageDto); // hrmDao와 연동
        } else {
            return hrmDao.getHrmEvalBoardList(hrmPageDto); // hrmDao와 연동
        }
    }

    private void setRequestAttributes(HttpServletRequest req, int totalPage, int startPage, int endPage, int listPerPage, int paginationPerPage, String search, String searchWord, List<HrmDto> hrmList, List<EvaluationDto> evaluationList) {
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("startPage", startPage);
        req.setAttribute("endPage", endPage);
        req.setAttribute("previousPage", startPage - 1);
        req.setAttribute("nextPage", startPage + paginationPerPage);
        req.setAttribute("listPerPage", listPerPage);
        req.setAttribute("search", search);
        req.setAttribute("searchWord", searchWord);
        req.setAttribute("hrmList", hrmList); // 여기가 evaluation-board.jsp 에서 근속년월이랑 등급 등등 관계지어서 함
        req.setAttribute("evaluationList", evaluationList); // 여기가 evaluation-board.jsp 에서 근속년월이랑 등급 등등 관계지어서 함
        HrmMap hrmMap = new HrmMap();
        req.setAttribute("deptMap", hrmMap.getDeptMap());
        req.setAttribute("positionMap", hrmMap.getPositionMap());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /* 사원 승진 승인 */
        int empNo = Integer.parseInt(req.getParameter("empNo"));
        HrmDao hrmDao = new HrmDao();
        int result = 0;
        result = hrmDao.promote(empNo);
        if (result > 0){
            HrmDao hrmSetPromoteFalse = new HrmDao();
            EvaluationDto evaluationDto = EvaluationDto.builder()
                    .empNo(empNo)
                    .promote(false)
                    .build();
            hrmSetPromoteFalse.updateEvaluation(evaluationDto);
            ScriptWriter.alertAndNext(resp,"승진 처리 완료","../hrm/evaluation?promote=true");
        } else ScriptWriter.alertAndBack(resp,"알수 없는 에러");
    }
}