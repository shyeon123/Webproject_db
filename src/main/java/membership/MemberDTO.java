package membership;


/*
 DTO(Data Trancefer Object)
 jsp와 자바 파일간에 데이터를 전달하기 위한 객체로 자바빈 규약의 의해 제작한다
 
  자바빈즈 규약
  1. 자바빈드는 기본(디폴트) 패키지 이외의 패키지에 속해야한다.
  2. 멤버변수 (속성) 의 접근 지정자는 private 으로 선언한다.
  3, 기본 생성자가 있어야한다.ㄴ
  4. 멤버변수에 업근할수있는 getter/setter 가 있어야한다.
  5. getter/setter 는 public 접근 지정자를 가져야한다.
 */
public class MemberDTO {
	//멤버변수 : member 테이블의 컬럼과 동일하게 생성
	private String id;
	private String pass;
	private String name;
	private String regidate;
	
	/*
	 생성자의 경우 꼭 필요한 경우가 아니라면 생성하지 않는다.
	 생성자를 직접 정의하지 않으면 컴파일러에 의해 디폴트(기본) 생성자가 
	 자동으로 추가 되기 때문이다. 
	  */
	
	/*
	 정보 은닉된 멤버변수에 접근하기 위해 public 으로 정의된 
	 getter/setter 메서드를 정의한다 
	 */
	public String getId() {
		return id;
	}
	public String getPass() {
		return pass;
	}
	public String getName() {
		return name;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setId(String id) {
		this.id=id;
	}
	public void setPass(String pass) {
		this.pass=pass;
	}
	public void setName(String name) {
		this.name=name;
	}
	public void setRegidate(String regidate) {
		this.regidate=regidate;
			
	}
}
