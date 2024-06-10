package com.hrproject.hrproject.controller.board;

import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.HrmPageDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/hrm/board")
public class HrmBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");
        String searchWord = req.getParameter("searchWord");

        int total = getTotalHrmCount(search, searchWord); // DB에서 가져온 총 사원수
        int currentPage = getCurrentPage(req);
        int listPerPage = 10; // 페이지당 보여지는 게시물 수
        int paginationPerPage = 5; // 보여지는 페이지 수 ex : 1 ~ 5, 6 ~ 10

        /* 변수명 Page -> pagination 바꾸기 */
        int totalPage = calculateTotalPage(total, listPerPage);
        int startPage = calculateStartPage(currentPage, paginationPerPage);
        int endPage = calculateEndPage(totalPage, startPage, paginationPerPage);

        HrmPageDto pageListDto = createPageDto(currentPage, listPerPage, search, searchWord);
        List<HrmDto> hrmList = getHrmList(pageListDto);

        setRequestAttributes(req, totalPage, startPage, endPage, listPerPage, paginationPerPage, search, searchWord, hrmList);
        System.out.println("hrmList === " + hrmList.get(0).getEName());
        System.out.println("hrmList === " + hrmList.get(1).getEName());


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
        int start = (page - 1) * listPerPage + 1;
        int end = page * listPerPage;
        HrmPageDto pageListDto = HrmPageDto.builder()
                .start(start)
                .end(end)
                .build();
        if (search != null && searchWord != null) {
            pageListDto.setSearch(search);
            pageListDto.setSearchWord(searchWord);
        }
        return pageListDto;
    }

    private List<HrmDto> getHrmList(HrmPageDto pageListDto) {
        HrmDao hrmDao = new HrmDao();
        if (pageListDto.getSearch() != null && pageListDto.getSearchWord() != null){
            return hrmDao.getSearchHrmList(pageListDto);
        } else {
            System.out.println(pageListDto.getStart() + pageListDto.getEnd() + pageListDto.getSearch());
            System.out.println("getHrmList");
            return hrmDao.getHrmBoardList(pageListDto);
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
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int empno = Integer.parseInt(req.getParameter("empno"));
    }
}