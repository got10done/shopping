package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ReplyDAO {
	//댓글 삭제
	public void delete(int rid) {
		try {
			String sql="delete from reply where rid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, rid);	//댓글의 아이디
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
	}
	
	//댓글수정
		public void update(ReplyVO vo, Double score) {
			try {
				
				String sql="update reply set content=?, rdate=systimestamp, score=?, editchk=1 where rid=?";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setString(1,vo.getContent());
				ps.setDouble(2, score);
				System.out.println("score"+score);
				ps.setInt(3, vo.getRid());
				
				ps.execute();
				
			}catch(Exception e) {
				System.out.println("오류 : "+e.toString());
			}
		}
	//댓글입력
	public void insert(ReplyVO vo,Double score) {
		try {
			String sql="insert into reply(rid,pid,content,writer,score) values(seq.nextval,?,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,vo.getProd_id());
			ps.setString(2, vo.getContent());
			ps.setString(3, vo.getWriter());
			ps.setDouble(4, score);
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
	}
	
	//댓글 목록
		public JSONObject list(SqlVO vo, String prod_id) { //특정 게시글에 있는 아이디도 받아와야한다.
			JSONObject jObject=new JSONObject();	//이 DAO는 기본적으로 JSON 데이터 타입으로 저장해야겠다는 설계로 시작되는거임.
			try {
				String sql="{call rlist(?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs=DB.con.prepareCall(sql);
				cs.setString(1,"reply");	
				cs.setString(2,"writer");
				cs.setString(3,"");
				cs.setInt(4,vo.getPage());
				cs.setInt(5,vo.getPerpage());
				cs.setString(6,"rid");
				cs.setString(7,"desc");	//최신 댓글순으로 보려할때 고정값들
				cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
				cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);
				cs.setString(10, prod_id);
				cs.execute();	
				//System.out.println(cs.getString(9)); - 이 값을 가져오는걸로 봐서 cs.execute()는 실행된다.
				ResultSet rs=(ResultSet)cs.getObject(8);	
				
				JSONArray array=new JSONArray();	//cs에서 가져온 결과값들을 저장할 json array를 별도로 생성
				while(rs.next()) {
					JSONObject obj=new JSONObject();	//array에 그냥 넣는게 아니라 json 형태로 또다시 패키징해서 넣는다!
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd a hh:mm:ss");
					obj.put("rid",rs.getInt("rid"));
					obj.put("content",rs.getString("content"));
					obj.put("writer",rs.getString("writer"));
					obj.put("rdate",sdf.format(rs.getTimestamp("rdate")));
					obj.put("rn",rs.getInt("rn"));
					obj.put("score",rs.getDouble("score"));
					obj.put("editchk",rs.getInt("editchk")); //editChk 대문자 소문자 구분 잘하기!
					
					array.add(obj);		//array에 추가하려면 add로!
				}
				//System.out.println("......?");
				jObject.put("array",array);		//array라는 이름으로 최종 저장공간에 저장해줌 - 이때 array는 json데이터의 호칭이 됨
				
				int count=cs.getInt(9);
				
				jObject.put("count",count);  //count라는 이름으로 최종 저장공간에 저장해줌 - 이때 count 역시 json데이터의 호칭이 됨
				//System.out.println(jObject.get("array"));
				//System.out.println(jObject.get("count"));
			}catch(Exception e){
				System.out.println("에러1: "+e.toString());
			}
			
			return jObject;
		}
	}
