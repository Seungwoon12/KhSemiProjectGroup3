//아직 시험중이기 때문에 나중에 되면 올리고 지금은 이것저것 추가하고 삭제하는 중

package movi.beans;

public class ProfileDto {
	private int profile_no;
	private String profile_upload_name;
	private String profile_save_name;
	private long profile_size;
	private String profile_type;
	private int profile_member_no;
	public int getProfile_no() {
		return profile_no;
	}
	public void setProfile_no(int profile_no) {
		this.profile_no = profile_no;
	}
	public String getProfile_upload_name() {
		return profile_upload_name;
	}
	public void setProfile_upload_name(String profile_upload_name) {
		this.profile_upload_name = profile_upload_name;
	}
	public String getProfile_save_name() {
		return profile_save_name;
	}
	public void setProfile_save_name(String profile_save_name) {
		this.profile_save_name = profile_save_name;
	}
	public long getProfile_size() {
		return profile_size;
	}
	public void setProfile_size(long profile_size) {
		this.profile_size = profile_size;
	}
	public String getProfile_type() {
		return profile_type;
	}
	public void setProfile_type(String profile_type) {
		this.profile_type = profile_type;
	}
	public int getProfile_member_no() {
		return profile_member_no;
	}
	public void setProfile_member_no(int profile_member_no) {
		this.profile_member_no = profile_member_no;
	}
	public ProfileDto() {
		super();
	}
}
