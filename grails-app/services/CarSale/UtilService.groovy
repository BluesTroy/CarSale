package CarSale

import grails.transaction.Transactional

import org.apache.poi.hssf.usermodel.HSSFCellStyle
import org.apache.poi.hssf.usermodel.HSSFFont
import org.apache.poi.hssf.util.HSSFColor
import org.apache.poi.hssf.usermodel.HSSFWorkbook

@Transactional
class UtilService {

    def buildExcel(out, titleList, contentList) {
        def wb = new HSSFWorkbook()
        def sheet = wb.createSheet("new sheet")
        def row
        def cell
        def style = wb.createCellStyle()
        def font  = wb.createFont()
        font.setFontHeightInPoints((short)12)
        font.setFontName("宋体")
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD)
        style.setFont(font)
        style.setAlignment(HSSFCellStyle.ALIGN_LEFT)
        style.setFillBackgroundColor(HSSFColor.ORANGE.index)
        row = sheet.createRow((short) 0)

        titleList.eachWithIndex{title, i ->
            cell = row.createCell((short) (i))
            cell.setCellStyle(style)
            cell.setCellValue(title)
        }

        contentList.eachWithIndex{ rowcontent,i ->
            row = sheet.createRow((short) (i+1))
            rowcontent.eachWithIndex{c,j->
                cell = row.createCell((short) (j))
                cell.setCellStyle(style)
                cell.setCellValue(c)
            }
        }

        wb.write(out)
        wb.close()
        return out
    }
}
