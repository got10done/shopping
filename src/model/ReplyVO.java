package model;

import java.util.Date;

public class ReplyVO extends ProductVO{		//상품의 자식 클래스
	private int rid;
	//private String id; 상속받아서 안써도됨
	private Date rdate;
	private String content;
	private String writer;
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
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
		return "ReplyVO [rid=" + rid + ", rdate=" + rdate + ", content=" + content + ", writer=" + writer + "]";
	}

}