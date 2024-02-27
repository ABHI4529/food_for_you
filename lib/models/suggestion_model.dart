class SuggestionModel {
  String? cafeName;
  String? cafeAddress;
  String? userId;
  String? userName;

  SuggestionModel(
      {this.cafeName, this.cafeAddress, this.userId, this.userName});

  SuggestionModel.fromJson(Map<String, dynamic> json) {
    cafeName = json['cafe_name'];
    cafeAddress = json['cafe_address'];
    userId = json['user_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cafe_name'] = this.cafeName;
    data['cafe_address'] = this.cafeAddress;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    return data;
  }
}
