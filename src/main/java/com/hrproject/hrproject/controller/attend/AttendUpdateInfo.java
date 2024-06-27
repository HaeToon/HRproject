package com.hrproject.hrproject.controller.attend;

import com.google.gson.*;
import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dto.AttendDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.lang.reflect.Type;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet("/attend/attendUpdateInfo")
public class AttendUpdateInfo extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String selectName =req.getParameter("ATDNO");

        AttendDao attendDao = new AttendDao();
        AttendDto updateInfoDto = attendDao.getUpdateInfo(selectName);

        // DAO에서 가져온 정보 출력
        System.out.println("ATDNO: " + selectName);
        System.out.println("EmpNo: " + updateInfoDto.getEmpNo());
        System.out.println("Ename: " + updateInfoDto.getEname());
        System.out.println("AtdCode: " + updateInfoDto.getAtdCode());
        System.out.println("AtdNum: " + updateInfoDto.getAtdNum());
        System.out.println("AtdDate: " + updateInfoDto.getAtdDate());
        System.out.println("OffDay: " + updateInfoDto.getOffDay());
        System.out.println("OffDayRs: " + updateInfoDto.getOffDayRs());
        System.out.println("Print: " + updateInfoDto.getPrint());

        // LocalDate 타입 어댑터 등록
        JsonSerializer<LocalDate> localDateSerializer = new JsonSerializer<LocalDate>() {
            @Override
            public JsonElement serialize(LocalDate src, Type typeOfSrc, JsonSerializationContext context) {
                return src == null ? null : context.serialize(src.format(DateTimeFormatter.ISO_LOCAL_DATE));
            }
        };

        // Gson 객체 생성
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDate.class, localDateSerializer)
                .create();

        String json = gson.toJson(updateInfoDto);
        System.out.println("Generated JSON: " + json);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);

    }
}
