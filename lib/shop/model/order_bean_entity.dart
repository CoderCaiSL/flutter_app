class OrderBeanEntity {
	OrderBeanResult result;
	String code;
	String message;

	OrderBeanEntity({this.result, this.code, this.message});

	OrderBeanEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new OrderBeanResult.fromJson(json['result']) : null;
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

class OrderBeanResult {
	String orderNum;

	OrderBeanResult({this.orderNum});

	OrderBeanResult.fromJson(Map<String, dynamic> json) {
		orderNum = json['orderNum'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['orderNum'] = this.orderNum;
		return data;
	}
}
