package com.hrproject.hrproject.controller.wokrSchedule;

import com.hrproject.hrproject.dao.AttendDao;
import com.hrproject.hrproject.dao.HrmDao;
import com.hrproject.hrproject.dao.WorkScheduleDao;
import com.hrproject.hrproject.dto.AttendDto;
import com.hrproject.hrproject.dto.HrmDto;
import com.hrproject.hrproject.dto.WorkScheduleDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.eclipse.tags.shaded.org.apache.xalan.xsltc.trax.TemplatesImpl;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/workSchedule/empWorkBoard")
public class empWorkBoard extends HttpServlet {
}
