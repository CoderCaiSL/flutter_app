class PayBeanEntity {
	PayBeanResult result;
	String code;
	String message;

	PayBeanEntity({this.result, this.code, this.message});

	PayBeanEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new PayBeanResult.fromJson(json['result']) : null;
		code = json['code'];
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.result != null) {
      data['result'] = this.result.toJson();
    }
		data['code'] = this.code;
		data['message'] = this.message;
		return data;
	}
}

class PayBeanResult {
	String package;
	String appid;
	String sign;
	int partnerid;
	String prepayid;
	String noncestr;
	int timestamp;

	PayBeanResult({this.package, this.appid, this.sign, this.partnerid, this.prepayid, this.noncestr, this.timestamp});

	PayBeanResult.fromJson(Map<String, dynamic> json) {
		package = json['package'];
		appid = json['appid'];
		sign = json['sign'];
		partnerid = json['partnerid'];
		prepayid = json['prepayid'];
		noncestr = json['noncestr'];
		timestamp = json['timestamp'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['package'] = this.package;
		data['appid'] = this.appid;
		data['sign'] = this.sign;
		data['partnerid'] = this.partnerid;
		data['prepayid'] = this.prepayid;
		data['noncestr'] = this.noncestr;
		data['timestamp'] = this.timestamp;
		return data;
	}
}
