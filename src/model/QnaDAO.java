package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class QnaDAO {
	//문의 답변
	public void update2(QnaVO vo) {
		try {
			String sql="update qna set answer=?, adate=systimestamp where qid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,vo.getAnswer());
			ps.setInt(2, vo.getQid());
			
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("문의답변 오류 : "+e.toString());
		}
	}
	//문의 답변 삭제
		public void update3(QnaVO vo) {
			try {
				String sql="update qna set answer='-', adate=systimestamp where qid=?";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setInt(1, vo.getQid());
				ps.execute();
				
			}catch(Exception e) {
				System.out.println("문의답변 오류 : "+e.toString());
			}
		}
	//문의 삭제
	public void delete(int qid) {
		try {
			String sql="delete from qna where qid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, qid);	//문의의 아이디
			ps.execute();
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
	}
	
	//문의수정
		public void update(QnaVO vo) {
			try {
				String sql="update qna set content=?, rdate=systimestamp where qid=?";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setString(1,vo.getContent());
				ps.setInt(2, vo.getQid());
				
				ps.execute();
				
			}catch(Exception e) {
				System.out.println("오류 : "+e.toString());
			}
		}
	//문의입력
	public void insert(QnaVO vo) {
		try {
			String sql="insert into qna(qid,pid,content,writer) values(seq2.nextval,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,vo.getProd_id());
			ps.setString(2, vo.getContent());
			ps.setString(3, vo.getWriter());

			ps.execute();
			
		}catch(Exception e) {
			System.out.println("오류 : "+e.toString());
		}
	}
	
	//문의 목록
		public JSONObject list(SqlVO vo, String prod_id) { //특정 게시글에 있는 아이디도 받아와야한다.
			JSONObject jObject=new JSONObject();	//이 DAO는 기본적으로 JSON 데이터 타입으로 저장해야겠다는 설계로 시작되는거임.
			try {
				String sql="{call rlist(?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs=DB.con.prepareCall(sql);
				cs.setString(1,"qna");	
				cs.setString(2,"writer");
				cs.setString(3,"");
				cs.setInt(4,vo.getPage());
				cs.setInt(5,vo.getPerpage());
				cs.setString(6,"qid");
				cs.setString(7,"desc");	//최신 문의순으로 보려할때 고정값들
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
					obj.put("qid",rs.getInt("qid"));
					obj.put("content",rs.getString("content"));
					obj.put("writer",rs.getString("writer"));
					obj.put("rdate",sdf.format(rs.getTimestamp("rdate")));
					obj.put("rn",rs.getInt("rn"));
					obj.put("answer",rs.getString("answer"));	//'-'가 기본값
					obj.put("adate",sdf.format(rs.getTimestamp("adate"))); //sysdate가 기본값
					
					
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
