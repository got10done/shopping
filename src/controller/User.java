package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;
@WebServlet(value={"/user/login","/user/logout","/user/register","/user/read"})
public class User extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDAO dao=new UserDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session=request.getSession();
		String path=request.getServletPath();
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=null;
		switch(path) {
		case "/user/read": //만약 오류난다면 .json 해보기
			String user_id=request.getParameter("user_id");
			out.println(dao.read2(user_id));
			
			break;
		case "/user/register":
			request.setAttribute("pageName", "/user/register.jsp");
			dis=request.getRequestDispatcher("/home.jsp");
			dis.forward(request, response);
			break;
			
		case "/user/logout":
			session.setAttribute("user",null);

			response.sendRedirect("/home");
			break;
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		UserVO vo=dao.read(request.getParameter("id"));
		String path=request.getServletPath();
		
		switch(path) {
		case "/user/register":
			UserVO v=new UserVO();
			v.setId(request.getParameter("id"));
			v.setPass(request.getParameter("pass"));
			v.setName(request.getParameter("name"));
			v.setTel(request.getParameter("tel"));
			v.setAddress(request.getParameter("address"));
			v.setEmail(request.getParameter("email"));
			System.out.println(v.toString());
			
			dao.insert(v);
			break;
		case "/user/login":
			int result=0;
			if(vo.getId()!=null) {
				if(vo.getPass().equals(request.getParameter("pass"))) {
					result=1;
					HttpSession session=request.getSession();
					session.setAttribute("user", vo);
				}else {
					result=2;
				}
			}
			PrintWriter out=response.getWriter();
			out.print(result); //로그인결과를 브라우저에 저장하여 활용
			break;
		}
	}

}
