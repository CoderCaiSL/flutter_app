class SearchDelEntity {
	SearchDelResult result;
	String code;
	String message;

	SearchDelEntity({this.result, this.code, this.message});

	SearchDelEntity.fromJson(Map<String, dynamic> json) {
		result = json['result'] != null ? new SearchDelResult.fromJson(json['result']) : null;
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

class SearchDelResult {
	SearchDelResultGoods goods;
	int collect;
	int goodsNum;

	SearchDelResult({this.goods, this.collect, this.goodsNum});

	SearchDelResult.fromJson(Map<String, dynamic> json) {
		goods = json['goods'] != null ? new SearchDelResultGoods.fromJson(json['goods']) : null;
		collect = json['collect'];
		goodsNum = json['goodsNum'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.goods != null) {
      data['goods'] = this.goods.toJson();
    }
		data['collect'] = this.collect;
		data['goodsNum'] = this.goodsNum;
		return data;
	}
}

class SearchDelResultGoods {
	int classify;
	int largessGoodsNum;
	int integralLargessRatio;
	double originalPrice;
	int salesVolume;
	int largessGoods;
	String subhead;
	String video;
	int type;
	String foretasteGoods;
	int installPrice;
	String minImage;
	double franking;
	double price;
	int integralDeduction;
	String details;
	int id;
	int state;
	String sku;
	int stock;
	double subMoney;
	int largessGoodsId;
	int integralLargess;
	int fullSub;
	String name;
	double fullMoney;
	String detailsImage;

	SearchDelResultGoods({this.classify, this.largessGoodsNum, this.integralLargessRatio, this.originalPrice, this.salesVolume, this.largessGoods, this.subhead, this.video, this.type, this.foretasteGoods, this.installPrice, this.minImage, this.franking, this.price, this.integralDeduction, this.details, this.id, this.state, this.sku, this.stock, this.subMoney, this.largessGoodsId, this.integralLargess, this.fullSub, this.name, this.fullMoney, this.detailsImage});

	SearchDelResultGoods.fromJson(Map<String, dynamic> json) {
		classify = json['classify'];
		largessGoodsNum = json['largessGoodsNum'];
		integralLargessRatio = json['integralLargessRatio'];
		originalPrice = json['originalPrice'];
		salesVolume = json['salesVolume'];
		largessGoods = json['largessGoods'];
		subhead = json['subhead'];
		video = json['video'];
		type = json['type'];
		foretasteGoods = json['foretasteGoods'];
		installPrice = json['installPrice'];
		minImage = json['minImage'];
		franking = json['franking'];
		price = json['price'];
		integralDeduction = json['integralDeduction'];
		details = json['details'];
		id = json['id'];
		state = json['state'];
		sku = json['sku'];
		stock = json['stock'];
		subMoney = json['subMoney'];
		largessGoodsId = json['largessGoodsId'];
		integralLargess = json['integralLargess'];
		fullSub = json['fullSub'];
		name = json['name'];
		fullMoney = json['fullMoney'];
		detailsImage = json['detailsImage'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['classify'] = this.classify;
		data['largessGoodsNum'] = this.largessGoodsNum;
		data['integralLargessRatio'] = this.integralLargessRatio;
		data['originalPrice'] = this.originalPrice;
		data['salesVolume'] = this.salesVolume;
		data['largessGoods'] = this.largessGoods;
		data['subhead'] = this.subhead;
		data['video'] = this.video;
		data['type'] = this.type;
		data['foretasteGoods'] = this.foretasteGoods;
		data['installPrice'] = this.installPrice;
		data['minImage'] = this.minImage;
		data['franking'] = this.franking;
		data['price'] = this.price;
		data['integralDeduction'] = this.integralDeduction;
		data['details'] = this.details;
		data['id'] = this.id;
		data['state'] = this.state;
		data['sku'] = this.sku;
		data['stock'] = this.stock;
		data['subMoney'] = this.subMoney;
		data['largessGoodsId'] = this.largessGoodsId;
		data['integralLargess'] = this.integralLargess;
		data['fullSub'] = this.fullSub;
		data['name'] = this.name;
		data['fullMoney'] = this.fullMoney;
		data['detailsImage'] = this.detailsImage;
		return data;
	}
}
