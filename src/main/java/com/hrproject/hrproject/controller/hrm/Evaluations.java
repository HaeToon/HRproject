package com.hrproject.hrproject.controller.hrm;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
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
        List<HrmDto> hrmList = getHrmList(hrmPageDto);

        for (HrmDto hrmDto : hrmList) {
            int score = 0;
            if (hrmDto.getAttendanceRate()*100 > 95) hrmDto.setAttendanceGrade("A");
            else if (hrmDto.getAttendanceRate()*100 > 90) hrmDto.setAttendanceGrade("B");
            else if (hrmDto.getAttendanceRate()*100 > 85) hrmDto.setAttendanceGrade("C");
            else hrmDto.setAttendanceGrade("D");

            if (hrmDto.getAttendanceGrade().equals("A")) score = hrmDto.getYosYear() * 50;
            else if (hrmDto.getAttendanceGrade().equals("B")) score = hrmDto.getYosYear() * 25;
            else if (hrmDto.getAttendanceGrade().equals("C")) score = hrmDto.getYosYear() * 10;
            else score = hrmDto.getYosYear() * 5;

            int requireScore = hrmDto.getPosNo()*hrmDto.getPosNo();
            if (score > requireScore) hrmDto.setIsPromo("O");
            else hrmDto.setIsPromo("X");
        }

        setRequestAttributes(req, totalPage, startPage, endPage, listPerPage, paginationPerPage, search, searchWord, hrmList);

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

    private void setRequestAttributes(HttpServletRequest req, int totalPage, int startPage, int endPage, int listPerPage, int paginationPerPage, String search, String searchWord, List<HrmDto> hrmList) {
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("startPage", startPage);
        req.setAttribute("endPage", endPage);
        req.setAttribute("previousPage", startPage - 1);
        req.setAttribute("nextPage", startPage + paginationPerPage);
        req.setAttribute("listPerPage", listPerPage);
        req.setAttribute("search", search);
        req.setAttribute("searchWord", searchWord);
        req.setAttribute("hrmList", hrmList); // 여기가 evaluation-board.jsp 에서 근속년월이랑 등급 등등 관계지어서 함
        HrmMap hrmMap = new HrmMap();
        req.setAttribute("deptMap", hrmMap.getDeptMap());
        req.setAttribute("positionMap", hrmMap.getPositionMap());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /* 사원 승진 승인 반려 */
        int empNo = Integer.parseInt(req.getParameter("empNo"));
        HrmDao hrmDao = new HrmDao();
    }
}