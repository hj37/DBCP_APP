package mybean;
//여러 데이터를 하나로 묶어서 처리할 SawonDto클래스
//DB에 있는 내용을 클래스 단위로 저장할 클래스

public class SawonDto {
	private int no; //사원 식별 번호
	private String id; //사원 id
	private String name; //사원 name
	private String pass; //사원 pass
	private int age; //사원 age
	private String addr; //사원 주소
	private String extension; //사원 내선번호
	private String dept; //부서번호
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	
	
	
}
