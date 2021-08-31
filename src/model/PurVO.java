package model;

public class PurVO extends UserVO{
	private String order_id;
	private String name;
	private String address;
	private String email;
	private String tel;
	private String pdate;
	private String paytype;
	private String status;
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String statys) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "PurVO [order_id=" + order_id + ", name=" + name + ", address=" + address + ", email=" + email + ", tel="
				+ tel + ", pdate=" + pdate + ", paytype=" + paytype + ", status=" + status + "]";
	}
	
}
