package model;

import java.util.Date;

public class QnaVO extends ProductVO{		//��ǰ�� �ڽ� Ŭ����
	private int qid;
	//private String id; ��ӹ޾Ƽ� �Ƚᵵ��
	private Date rdate;
	private String content;
	private String writer;
	private String answer; //�亯����
	private Date adate;
	
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Date getAdate() {
		return adate;
	}
	public void setAdate(Date adate) {
		this.adate = adate;
	}
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	@Override
	public String toString() {
		return "QnaVO [qid=" + qid + ", rdate=" + rdate + ", content=" + content + ", writer=" + writer + ", answer="
				+ answer + ", adate=" + adate + "]";
	}
	

}