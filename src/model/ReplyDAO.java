package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ReplyDAO {
	//��� ����
	public void delete(int rid) {
		try {
			String sql="delete from reply where rid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, rid);	//����� ���̵�
			ps.execute();
		}catch(Exception e) {
			System.out.println("���� : "+e.toString());
		}
	}
	
	//��ۼ���
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
				System.out.println("���� : "+e.toString());
			}
		}
	//����Է�
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
			System.out.println("���� : "+e.toString());
		}
	}
	
	//��� ���
		public JSONObject list(SqlVO vo, String prod_id) { //Ư�� �Խñۿ� �ִ� ���̵� �޾ƿ;��Ѵ�.
			JSONObject jObject=new JSONObject();	//�� DAO�� �⺻������ JSON ������ Ÿ������ �����ؾ߰ڴٴ� ����� ���۵Ǵ°���.
			try {
				String sql="{call rlist(?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs=DB.con.prepareCall(sql);
				cs.setString(1,"reply");	
				cs.setString(2,"writer");
				cs.setString(3,"");
				cs.setInt(4,vo.getPage());
				cs.setInt(5,vo.getPerpage());
				cs.setString(6,"rid");
				cs.setString(7,"desc");	//�ֽ� ��ۼ����� �����Ҷ� ��������
				cs.registerOutParameter(8, oracle.jdbc.OracleTypes.CURSOR);
				cs.registerOutParameter(9, oracle.jdbc.OracleTypes.INTEGER);
				cs.setString(10, prod_id);
				cs.execute();	
				//System.out.println(cs.getString(9)); - �� ���� �������°ɷ� ���� cs.execute()�� ����ȴ�.
				ResultSet rs=(ResultSet)cs.getObject(8);	
				
				JSONArray array=new JSONArray();	//cs���� ������ ��������� ������ json array�� ������ ����
				while(rs.next()) {
					JSONObject obj=new JSONObject();	//array�� �׳� �ִ°� �ƴ϶� json ���·� �Ǵٽ� ��Ű¡�ؼ� �ִ´�!
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd a hh:mm:ss");
					obj.put("rid",rs.getInt("rid"));
					obj.put("content",rs.getString("content"));
					obj.put("writer",rs.getString("writer"));
					obj.put("rdate",sdf.format(rs.getTimestamp("rdate")));
					obj.put("rn",rs.getInt("rn"));
					obj.put("score",rs.getDouble("score"));
					obj.put("editchk",rs.getInt("editchk")); //editChk �빮�� �ҹ��� ���� ���ϱ�!
					
					array.add(obj);		//array�� �߰��Ϸ��� add��!
				}
				//System.out.println("......?");
				jObject.put("array",array);		//array��� �̸����� ���� ��������� �������� - �̶� array�� json�������� ȣĪ�� ��
				
				int count=cs.getInt(9);
				
				jObject.put("count",count);  //count��� �̸����� ���� ��������� �������� - �̶� count ���� json�������� ȣĪ�� ��
				//System.out.println(jObject.get("array"));
				//System.out.println(jObject.get("count"));
			}catch(Exception e){
				System.out.println("����1: "+e.toString());
			}
			
			return jObject;
		}
	}
