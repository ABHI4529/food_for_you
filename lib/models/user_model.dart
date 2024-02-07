class UserModel {
  String? userEmail;
  String? userId;
  String? userName;
  DateTime? createdTime;

  UserModel({this.userEmail, this.userId, this.userName, this.createdTime});

  UserModel.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'];
    userId = json['userId'];
    userName = json['userName'];
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userEmail'] = this.userEmail;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['createdTime'] = this.createdTime;
    return data;
  }
}
