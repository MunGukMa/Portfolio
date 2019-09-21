package mun.guk.secondpj.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFChildAnchor;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.sl.usermodel.Sheet;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.GsonBuilderUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import mun.guk.secondpj.service.SellerService;
import mun.guk.secondpj.vo.ExcelVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Controller
@RequestMapping(value="/seller")
public class SellerController 
{
	@Autowired
	SellerService service;
	
	@RequestMapping(value = "mylist", method = RequestMethod.GET)
	public String mylist(HttpSession session) 
	{
		return "mylist";
	}
	
	@RequestMapping(value = "registform", method = RequestMethod.GET)
	public String registform(HttpSession session) 
	{
		return "registform";
	}
	
	@RequestMapping(value = "filechk", method = RequestMethod.GET)
	@ResponseBody
	public String filechk(String originalfilename) 
	{
		String result =service.filechk(originalfilename);
		return result;
	}
	
	@RequestMapping(value = "registproduct", method = {RequestMethod.POST,RequestMethod.GET})
	public String registproduct(ProductVO vo,MultipartFile prdtfile,HttpSession session) 
	{
		service.registproduct(vo,prdtfile,session);
		return "mylist";
	}
	
	@RequestMapping(value = "setplist", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<ProductVO> setplist(HttpSession session) 
	{
		ArrayList<ProductVO> list = service.setplist(session);
		return list;
	}
	
	@RequestMapping(value = "setslist", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<ProductVO> setslist(HttpSession session) 
	{
		ArrayList<ProductVO> list = service.setslist(session);
		return list;
	}
	
	
	@RequestMapping(value = "sortlist", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<ProductVO> sortlist(@RequestBody HashMap<String, String> map,HttpSession session) 
	{
		ArrayList<ProductVO> list = service.sortlist(map,session);
		return list;
	}
	
	@RequestMapping(value = "detailform", method = {RequestMethod.POST,RequestMethod.GET})
	public String detailform(ProductVO vo,Model model) 
	{
		vo = service.selectone(vo);
		int totalqt = service.totalvalue(vo);
		int totalend = service.totalend(vo);
		int totalpro = service.totalpro(vo);
		int totalready = service.totalready(vo);
		int totalpay = service.totalpay(vo);
		int totalconf = service.totalconf(vo);
		model.addAttribute("prdt", vo);
		model.addAttribute("totalqt", totalqt);
		model.addAttribute("totalend", totalend);
		model.addAttribute("totalpro", totalpro);
		model.addAttribute("totalready", totalready);
		model.addAttribute("totalpay", totalpay);
		model.addAttribute("totalconf", totalconf);
		return "detailform";
	}
	
	@RequestMapping(value = "selectone", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ProductVO selectone(ProductVO vo,Model model) 
	{
		vo = service.selectone(vo);
		return vo;
	}
	
	@RequestMapping(value = "detailship", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ArrayList<OrderVO> detailship(OrderVO vo) 
	{
		System.out.println(vo);
		ArrayList<OrderVO> result = service.detailship(vo);
		System.out.println(result);
		return result;
	}
	
	
	
	@RequestMapping(value = "/excelDown.do", method ={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public void exceldown(@RequestBody ArrayList<String> list,HttpServletResponse response) throws Exception
	{
		
		ArrayList<ExcelVO> result = service.getlist(list);
		
		
		Workbook wb = new HSSFWorkbook();
		org.apache.poi.ss.usermodel.Sheet sheet = wb.createSheet("주문");
		Row row =null;
		Cell cell=null;
		int rowNo=0;
		
		CellStyle headstyle=wb.createCellStyle();
		headstyle.setBorderTop(BorderStyle.THIN);
		headstyle.setBorderBottom(BorderStyle.THIN);
		headstyle.setBorderLeft(BorderStyle.THIN);
		headstyle.setBorderRight(BorderStyle.THIN);
		headstyle.setAlignment(HorizontalAlignment.CENTER);
		
		CellStyle bodystyle = wb.createCellStyle();
		bodystyle.setBorderTop(BorderStyle.THIN);
		bodystyle.setBorderBottom(BorderStyle.THIN);
		bodystyle.setBorderLeft(BorderStyle.THIN);
		bodystyle.setBorderRight(BorderStyle.THIN);
		bodystyle.setAlignment(HorizontalAlignment.CENTER);
		
		row=sheet.createRow(rowNo++);
		cell=row.createCell(0);
		cell.setCellStyle(headstyle);
		cell.setCellValue("이름");
		cell=row.createCell(1);
		cell.setCellStyle(headstyle);
		cell.setCellValue("우편번호");
		cell=row.createCell(2);
		cell.setCellStyle(headstyle);
		cell.setCellValue("주소");
		cell=row.createCell(3);
		cell.setCellStyle(headstyle);
		cell.setCellValue("연락처");
		cell=row.createCell(4);
		cell.setCellStyle(headstyle);
		cell.setCellValue("내용품명");
		
		for(ExcelVO vo:result)
		{
			row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodystyle);
	        cell.setCellValue(vo.getName());
	        cell = row.createCell(1);
	        cell.setCellStyle(bodystyle);
	        cell.setCellValue(vo.getAddressnum());
	        cell = row.createCell(2);
	        cell.setCellStyle(bodystyle);
	        cell.setCellValue(vo.getAddress());
	        cell = row.createCell(3);
	        cell.setCellStyle(bodystyle);
	        cell.setCellValue(vo.getTel());
	        cell = row.createCell(4);
	        cell.setCellStyle(bodystyle);
	        cell.setCellValue(vo.getTitle());
		}
		File file = new File("C:\\test\\우체국.xls");
        FileOutputStream fos = null;
        fos = new FileOutputStream(file);
        file.mkdirs();
        wb.write(fos);
        fos.close();
    	wb.close();
		
		/*response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=우체국파일.xls");
		wb.write(response.getOutputStream());*/
		
	}
	
}
