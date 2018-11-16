package ca.anygroup.beans;

public class User {
	private String email;
	private String name;
	private String company;
	
	
	
	
	

	public User(String email, String name, String company) {
		super();
		this.email = email;
		this.name = name;
		this.company = company;
	}
	

	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
