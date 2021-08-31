package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.ProductDAO;
import model.SqlVO;

import model.*;
@WebServlet(value={"/","/home1","/home2","/home3", "/pro/list.json", "/pro/list", "/pro/insert", "/pro/insert1", "/pro/insert2", "/pro/insert3","/pro/update","/pro/read","/pro/delete","/pro/client"})
public class Product extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    ProductDAO dao=new ProductDAO();   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		String path=request.getServletPath();
		RequestDispatcher dis=null;
		
		switch(path) {
		case "/pro/client":
			HttpSession session=request.getSession();
			session.setAttribute("user", session.getAttribute("user"));
			request.setAttribute("pageName", "/pro/client.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request,response);
			break;
		case "/pro/delete":
			ProductVO oldVO=dao.read(request.getParameter("prod_id")); //���� ������ ������(read) ���ε� �̹��� ����� ����.
			dao.delete(request.getParameter("prod_id"));
			if(oldVO.getImage()!=null) {
				File file=new File("c:/image/"+oldVO.getImage());	//�����ϱ� ���� ����
				file.delete();
			}
			response.sendRedirect("/home");
			break;
		case "/pro/read":
			session=request.getSession();
			session.setAttribute("user", session.getAttribute("user"));
			request.setAttribute("vo", dao.read(request.getParameter("prod_id")));
			request.setAttribute("blogPage", "/pro/blog.jsp");
			request.setAttribute("qnaPage", "/pro/qna.jsp");
			request.setAttribute("pageName", "/pro/read.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		
			
		case "/pro/insert1":
			request.setAttribute("prod_id", dao.getCodeP());
			request.setAttribute("pageName", "/pro/insert1.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/pro/insert2":
			request.setAttribute("prod_id", dao.getCodeB());
			request.setAttribute("pageName", "/pro/insert2.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/pro/insert3":
			request.setAttribute("prod_id", dao.getCodeE());
			request.setAttribute("pageName", "/pro/insert3.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		
		
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			SqlVO svo=new SqlVO();
			svo.setKey(request.getParameter("key"));
			svo.setWord(request.getParameter("word"));
			svo.setPage(Integer.parseInt(request.getParameter("page")));
			svo.setPerpage(Integer.parseInt(request.getParameter("perpage")));
			svo.setOrder(request.getParameter("order"));
			svo.setDesc(request.getParameter("desc"));
			//System.out.println(svo.toString());
			out.println(dao.list(svo));
			break;
		
		
		case "/": //����ǰ ���
			session=request.getSession();
			session.setAttribute("user", session.getAttribute("user"));
			request.setAttribute("pageName", "/pro/home.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/home1":
			session=request.getSession();
			session.setAttribute("user", session.getAttribute("user"));
			request.setAttribute("pageName", "/pro/home1.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/home2":
			session=request.getSession();
			session.setAttribute("user", session.getAttribute("user"));
			request.setAttribute("pageName", "/pro/home2.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		case "/home3":
			session=request.getSession();
			session.setAttribute("user", session.getAttribute("user"));
			request.setAttribute("pageName", "/pro/home3.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String path=request.getServletPath();
		
		MultipartRequest multi=new MultipartRequest(request, "c:/image", 1024*1024*10,"UTF-8",new DefaultFileRenamePolicy()); //���̺귯���� cos.jar �� �־�� �����ϴ�!
		System.out.println("filename "+multi.getFilesystemName("image"));
		ProductVO vo=new ProductVO();
		vo.setProd_id(multi.getParameter("prod_id"));
		
		vo.setProd_name(multi.getParameter("prod_name"));
		vo.setCompany(multi.getParameter("company"));
		vo.setMall_id(multi.getParameter("mall_id"));
		vo.setPrice1(Integer.parseInt(multi.getParameter("price1")));
		vo.setPrice2(Integer.parseInt(multi.getParameter("price2")));
		vo.setDetail(multi.getParameter("detail"));
		
		//System.out.println(vo.getDetail());
		
		String prod_del=multi.getParameter("prod_del")==null?"0":"1";
		vo.setProd_del(prod_del);
		vo.setImage(multi.getFilesystemName("image"));
		switch(path) {
		case "/pro/update":	//�̹��� �Ȱǵ帮�� vo.getImage()�� null�� �Ǿ ���� ����������Ѵ�.
			ProductVO oldVO=dao.read(vo.getProd_id());//���� ������ read�ؼ�
			
			if(multi.getFilesystemName("image")==null) {
				vo.setImage(oldVO.getImage());	//���� �̹��� �������� �缳�����ش�.
				System.out.println("oldVO.getImage "+oldVO.getImage());
				System.out.println("vo.getImage "+vo.getImage());
			}else { //���� ���ε��� �̹����� ���� ��
				if(oldVO.getImage() != null) {	//���� �̹����� ���� ��� 
					File file=new File("c:/image/"+oldVO.getImage());
					file.delete();
				}
			}
			dao.update(vo);
			break;
		case "/pro/insert":
			dao.insert(vo);
			//System.out.println(vo.toString());
			break;
		}
		response.sendRedirect("/home");
	}
}
