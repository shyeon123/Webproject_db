package blog;

public class UserDTO {
    private String userId;
    private String userPwd;
    private String userName;
    private String email;
    private String phone;

    // Getter and Setter
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUserPwd() { return userPwd; }
    public void setUserPwd(String userPwd) { this.userPwd = userPwd; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
