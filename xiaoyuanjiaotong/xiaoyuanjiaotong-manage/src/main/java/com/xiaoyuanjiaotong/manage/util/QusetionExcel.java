package com.xiaoyuanjiaotong.manage.util;

import com.xiaoyuanjiaotong.manage.domain.Exams;
import com.xiaoyuanjiaotong.manage.domain.Questions;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.apache.poi.ss.usermodel.*;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class QusetionExcel {
    public static List<Questions> importExcel(String sheetName, InputStream is, int titleNum) throws Exception {
        List<Questions> list = new ArrayList<>();
        Workbook wb = WorkbookFactory.create(is);
        Sheet sheet = StringUtils.isNotEmpty(sheetName) ? wb.getSheet(sheetName) : wb.getSheetAt(0);
        int rows = sheet.getLastRowNum();

        // 定义表头映射
        Map<String, Integer> headerMap = new HashMap<>();
        Row headerRow = sheet.getRow(titleNum);
        for (Cell cell : headerRow) {
            headerMap.put(cell.getStringCellValue(), cell.getColumnIndex());
        }

        Questions currentQuestion = null;

        for (int i = titleNum + 1; i <= rows; i++) {
            Row row = sheet.getRow(i);
            if (isRowEmpty(row)) continue;

            // 解析主表字段
            String questionContent = getCellStringValue(row, headerMap.get("题目"));
            String answer = getCellStringValue(row, headerMap.get("答案"));
            String category = getCellStringValue(row, headerMap.get("问题类型"));
            String examContent = getCellStringValue(row, headerMap.get("选项列表"));

            // 判断是否为新主记录
            if (StringUtils.isNotEmpty(questionContent) || StringUtils.isNotEmpty(answer) || StringUtils.isNotEmpty(category)) {
                currentQuestion = new Questions();
                currentQuestion.setQuestionContent(questionContent);
                currentQuestion.setAnswer(answer);
                currentQuestion.setCategory(category);
                currentQuestion.setExamsList(new ArrayList<>());
                list.add(currentQuestion);
            }

            // 添加子表数据到当前主记录
            if (currentQuestion != null && StringUtils.isNotEmpty(examContent)) {
                Exams exam = Exams.builder().examContent(examContent).build();
                currentQuestion.getExamsList().add(exam);
            }
        }
        return list;
    }

    private static String getCellStringValue(Row row, int columnIndex) {
        Cell cell = row.getCell(columnIndex);
        return cell != null ? cell.getStringCellValue() : "";
    }

    private static boolean isRowEmpty(Row row) {
        if (row == null) return true;
        for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
            Cell cell = row.getCell(i);
            if (cell != null && cell.getCellType() != CellType.BLANK) {
                return false;
            }
        }
        return true;
    }
}

