package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;

import org.json.simple.*;

public class ProductDAO {
	//상품삭제
	public void delete(String prod_id) {
		try {
			String sql="delete from product where prod_id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,prod_id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
		
	}
	//상품정보수정
	public void update(ProductVO vo) {
		try {
			String sql="update product set prod_name=?,company=?,price1=?,price2=?,prod_del=?,mall_id=?,detail=?,image=? where prod_id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(9,vo.getProd_id());
			ps.setString(1,vo.getProd_name());
			ps.setString(2,vo.getCompany());
			ps.setInt(3,vo.getPrice1());
			ps.setInt(4,vo.getPrice2());
			ps.setString(5,vo.getProd_del());
			ps.setString(6,vo.getMall_id());
			ps.setString(7,vo.getDetail());
			ps.setString(8,vo.getImage());
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
		
	}
	//상품정보
	public ProductVO read(String prod_id) {
		ProductVO vo=new ProductVO();
		try {
			String sql="select * from pmall where prod_id=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,prod_id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setProd_id(rs.getString("prod_id"));
				vo.setProd_name(rs.getString("prod_name"));
				vo.setProd_del(rs.getString("prod_del"));
				vo.setCompany(rs.getString("company"));
				vo.setMall_name(rs.getString("mall_name"));
				vo.setMall_id(rs.getString("mall_id"));
				vo.setPrice1(rs.getInt("price1"));
				vo.setPrice2(rs.getInt("price2"));
				vo.setImage(rs.getString("image"));
				vo.setDetail(rs.getString("detail"));
			}
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
		return vo;
	}
	//상품 등록
	public void insert(ProductVO vo) {
		try {
			String sql="insert into product(prod_id,prod_name,company,price1,price2,prod_del,mall_id,detail,image) values(?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,vo.getProd_id());
			ps.setString(2,vo.getProd_name());
			ps.setString(3,vo.getCompany());
			ps.setInt(4,vo.getPrice1());
			ps.setInt(5,vo.getPrice2());
			ps.setString(6,"0");
			ps.setString(7,vo.getMall_id());
			ps.setString(8,vo.getDetail());
			ps.setString(9,vo.getImage());
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
		
}
	
	//가구코드등록 - 코드 최대값 - 상품코드 자동화를 위해(integer화 해서 +1 할거임)
		public String getCodeP() {
			String prod_id="P001";
			try {
				String sql="select count(*) cnt from product";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ResultSet rs=ps.executeQuery();
				if(rs.next()) {
					int lastId=rs.getInt("cnt");
					prod_id="P"+(lastId+121);
				}
			}catch(Exception e) {
				System.out.println("오류 : "+e.toString());
			}
			return prod_id;
		}
	//책코드등록 - 코드 최대값 - 상품코드 자동화를 위해(integer화 해서 +1 할거임)
		public String getCodeB() {
			String prod_id="B001";
			try {
				String sql="select count(*) cnt from product";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ResultSet rs=ps.executeQuery();
				if(rs.next()) {
					int lastId=rs.getInt("cnt");
					prod_id="B"+(lastId+121);
				}
			}catch(Exception e) {
				System.out.println("오류 : "+e.toString());
			}
			return prod_id;
		}
	//가전제품코드등록 - 코드 최대값 - 상품코드 자동화를 위해(integer화 해서 +1 할거임)
		public String getCodeE() {
			String prod_id="E001";
			try {
				String sql="select count(*) cnt from product";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ResultSet rs=ps.executeQuery();
				if(rs.next()) {
					int lastId=rs.getInt("cnt");
					prod_id="E"+(lastId+121);
				}
			}catch(Exception e) {
				System.out.println("오류 : "+e.toString());
			}
			return prod_id;
		}
	//상품 목록
	public JSONObject list(SqlVO vo) {
		JSONObject jObject=new JSONObject();
		try {
			String sql="{call list(?,?,?,?,?,?,?,?,?)}";
			CallableStatement cs=DB.con.prepareCall(sql);
			cs.setString(1, "pmall");
			cs.setString(2, vo.getKey());
			cs.setString(3, vo.getWord());
			cs.setInt(4, vo.getPage());
			cs.setInt(5, vo.getPerpage());
			cs.setString(6, vo.getOrder());
			cs.setString(7, vo.getDesc());
			cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
			cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);
			cs.execute();
			
			ResultSet rs=(ResultSet)cs.getObject(8);
			JSONArray array=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				//DecimalFormat df=new DecimalFormat("#,###원");
				obj.put("prod_id", rs.getString("prod_id"));
				obj.put("prod_name", rs.getString("prod_name"));
				obj.put("image", rs.getString("image"));
				obj.put("price1", rs.getInt("price1"));
				obj.put("price2", rs.getInt("price2"));
				//obj.put("price1", df.format(rs.getInt("price1")));
				//obj.put("price2", df.format(rs.getInt("price2")));
				obj.put("prod_del", rs.getString("prod_del"));
				obj.put("mall_name", rs.getString("mall_name"));
				obj.put("company", rs.getString("company"));
				array.add(obj);
			}
			jObject.put("array", array);
			
			int count=cs.getInt(9);
			jObject.put("count", count);
		}catch(Exception e) {
			System.out.println("오류:" + e.toString());
		}
		return jObject;
	}
}
