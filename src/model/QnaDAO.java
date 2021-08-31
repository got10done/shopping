package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class QnaDAO {
	//���� �亯
	public void update2(QnaVO vo) {
		try {
			String sql="update qna set answer=?, adate=systimestamp where qid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,vo.getAnswer());
			ps.setInt(2, vo.getQid());
			
			ps.execute();
			
		}catch(Exception e) {
			System.out.println("���Ǵ亯 ���� : "+e.toString());
		}
	}
	//���� �亯 ����
		public void update3(QnaVO vo) {
			try {
				String sql="update qna set answer='-', adate=systimestamp where qid=?";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setInt(1, vo.getQid());
				ps.execute();
				
			}catch(Exception e) {
				System.out.println("���Ǵ亯 ���� : "+e.toString());
			}
		}
	//���� ����
	public void delete(int qid) {
		try {
			String sql="delete from qna where qid=?";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setInt(1, qid);	//������ ���̵�
			ps.execute();
		}catch(Exception e) {
			System.out.println("���� : "+e.toString());
		}
	}
	
	//���Ǽ���
		public void update(QnaVO vo) {
			try {
				String sql="update qna set content=?, rdate=systimestamp where qid=?";
				PreparedStatement ps=DB.con.prepareStatement(sql);
				ps.setString(1,vo.getContent());
				ps.setInt(2, vo.getQid());
				
				ps.execute();
				
			}catch(Exception e) {
				System.out.println("���� : "+e.toString());
			}
		}
	//�����Է�
	public void insert(QnaVO vo) {
		try {
			String sql="insert into qna(qid,pid,content,writer) values(seq2.nextval,?,?,?)";
			PreparedStatement ps=DB.con.prepareStatement(sql);
			ps.setString(1,vo.getProd_id());
			ps.setString(2, vo.getContent());
			ps.setString(3, vo.getWriter());

			ps.execute();
			
		}catch(Exception e) {
			System.out.println("���� : "+e.toString());
		}
	}
	
	//���� ���
		public JSONObject list(SqlVO vo, String prod_id) { //Ư�� �Խñۿ� �ִ� ���̵� �޾ƿ;��Ѵ�.
			JSONObject jObject=new JSONObject();	//�� DAO�� �⺻������ JSON ������ Ÿ������ �����ؾ߰ڴٴ� ����� ���۵Ǵ°���.
			try {
				String sql="{call rlist(?,?,?,?,?,?,?,?,?,?)}";
				CallableStatement cs=DB.con.prepareCall(sql);
				cs.setString(1,"qna");	
				cs.setString(2,"writer");
				cs.setString(3,"");
				cs.setInt(4,vo.getPage());
				cs.setInt(5,vo.getPerpage());
				cs.setString(6,"qid");
				cs.setString(7,"desc");	//�ֽ� ���Ǽ����� �����Ҷ� ��������
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
					obj.put("qid",rs.getInt("qid"));
					obj.put("content",rs.getString("content"));
					obj.put("writer",rs.getString("writer"));
					obj.put("rdate",sdf.format(rs.getTimestamp("rdate")));
					obj.put("rn",rs.getInt("rn"));
					obj.put("answer",rs.getString("answer"));	//'-'�� �⺻��
					obj.put("adate",sdf.format(rs.getTimestamp("adate"))); //sysdate�� �⺻��
					
					
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
