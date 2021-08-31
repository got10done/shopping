package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONObject;

public class UserDAO {
	// 아이디 검색 ㅡㅡ
	public JSONObject read2(String id) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="select * from userinfo where id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				jObject.put("user_id",rs.getString("id"));
			}else {
				jObject.put("user_id","");
			}
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
		return jObject;
	}
	//register 회원가입
	public void insert(UserVO v) {
	
		try {
			String sql="insert into userinfo(id, pass, name, tel, address, email) values(?,?,?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, v.getId());
			ps.setString(2, v.getPass());
			ps.setString(3, v.getName());
			ps.setString(4, v.getTel());
			ps.setString(5, v.getAddress());
			ps.setString(6, v.getEmail());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("회원가입 오류:"+e.toString());
		}

	}
	
	//login
	public UserVO read(String id) {
		UserVO vo=new UserVO();
		try {
			String sql="select * from userinfo where id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setId(rs.getString("id"));
				vo.setPass(rs.getString("pass"));
				vo.setEmail(rs.getString("email"));
				vo.setTel(rs.getString("tel"));
				vo.setAddress(rs.getString("address"));
				vo.setName(rs.getString("name"));
				
			}
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
		return vo;
	}
}
