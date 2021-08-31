package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
@WebServlet(value={"/reply/list.json", "/reply/insert","/reply/delete","/reply/update"})
public class Reply extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ReplyDAO dao=new ReplyDAO();
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();	//response Ȱ�� ������ ���� �� �������� ����ؾ��ϹǷ� �� ��ġ�� �������ش�.
		
		SqlVO vo=new SqlVO(); 	//servlet �ȿ��� ��Ű¡�� �� ���� ����
		String path=request.getServletPath();	//doGet doPost ���� �ι� �����ؾ��Ѵ�.
		
		switch(path) {
		
		case "/reply/list.json":
			vo.setPage(Integer.parseInt(request.getParameter("page")));
			vo.setPerpage(5);
			String prod_id=request.getParameter("prod_id");
			//System.out.println(prod_id);
			//System.out.println(vo.toString());
			out.println(dao.list(vo, prod_id));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String path=request.getServletPath();
				
		switch(path) {
		case "/reply/update":
			ReplyVO vo=new ReplyVO();
			vo.setRid(Integer.parseInt(request.getParameter("rid")));
			vo.setContent(request.getParameter("content"));
			vo.setWriter(request.getParameter("writer"));
			Double score=Double.parseDouble(request.getParameter("score"));
			System.out.println(vo.toString()+score);
			dao.update(vo,score);
			break;
		case "/reply/delete":
			dao.delete(Integer.parseInt(request.getParameter("rid")));
			break;
		
		case "/reply/insert":	//�Է��ϴ� ȭ���� ���� ���صּ� doGet�� /reply/insert �ּҸ� Ư�� â(html)�� ������ص� ��
			vo=new ReplyVO();
			vo.setProd_id(request.getParameter("prod_id"));
			vo.setContent(request.getParameter("content"));
			vo.setWriter(request.getParameter("writer"));
			score=Double.parseDouble(request.getParameter("score"));
			//System.out.println(vo.toString());
			dao.insert(vo,score);		//Reply servlet�� read���� �Է¹�ư�� ������ �� �۵��ϴ� �Ŵ�!
			
			break;
		}
	}
}
