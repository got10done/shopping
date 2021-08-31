package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
@WebServlet(value={"/qna/list.json", "/qna/insert","/qna/delete","/qna/update","/qna/update2","/qna/update3"})
public class Qna extends HttpServlet {
	private static final long serialVersionUID = 1L;
    QnaDAO dao=new QnaDAO();
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();	//response Ȱ�� ������ ���� �� �������� ����ؾ��ϹǷ� �� ��ġ�� �������ش�.
		
		SqlVO vo=new SqlVO(); 	//servlet �ȿ��� ��Ű¡�� �� ���� ����
		String path=request.getServletPath();	//doGet doPost ���� �ι� �����ؾ��Ѵ�.
		
		switch(path) {
		
		case "/qna/list.json":
			vo.setPage(Integer.parseInt(request.getParameter("page")));
			vo.setPerpage(5);
			String prod_id=request.getParameter("prod_id");
			//System.out.println("prod_id"+prod_id);
			//System.out.println(vo.toString());
			out.println(dao.list(vo, prod_id));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String path=request.getServletPath();
				
		switch(path) {
		case "/qna/update3":
			QnaVO vo=new QnaVO();
			vo.setQid(Integer.parseInt(request.getParameter("qid")));
			System.out.println(vo.toString());
			dao.update3(vo);
			break;
		case "/qna/update2":
			vo=new QnaVO();
			vo.setQid(Integer.parseInt(request.getParameter("qid")));
			vo.setAnswer(request.getParameter("answer"));
			System.out.println(vo.toString());
			dao.update2(vo);
			break;
		case "/qna/update":
			vo=new QnaVO();
			vo.setQid(Integer.parseInt(request.getParameter("qid")));
			vo.setContent(request.getParameter("content"));
			vo.setWriter(request.getParameter("writer"));
			
			System.out.println(vo.toString());
			dao.update(vo);
			break;
		case "/qna/delete":
			dao.delete(Integer.parseInt(request.getParameter("qid")));
			break;
		
		case "/qna/insert":	//�Է��ϴ� ȭ���� ���� ���صּ� doGet�� /qna/insert �ּҸ� Ư�� â(html)�� ������ص� ��
			vo=new QnaVO();
			vo.setProd_id(request.getParameter("prod_id"));
			vo.setContent(request.getParameter("content"));
			vo.setWriter(request.getParameter("writer"));
			
			System.out.println(vo.toString());
			dao.insert(vo);		//Reply servlet�� read���� �Է¹�ư�� ������ �� �۵��ϴ� �Ŵ�!
			
			break;
		}
	}
}
