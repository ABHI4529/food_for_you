import 'package:food_for_you/models/cart_model.dart';

class OrderModel {
  String? orderId;
  DateTime? orderTime;
  String? cafeName;
  String? userId;
  bool? isComplete;
  String? orderUpdate;
  List<Items>? items;

  OrderModel(
      {this.orderId,
      this.orderTime,
      this.cafeName,
      this.isComplete,
      this.orderUpdate,
      this.userId,
      this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderTime = json['order_time'];
    userId = json['user_id'];
    cafeName = json['cafe_name'];
    isComplete = json['isComplete'];
    orderUpdate = json['order_update'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_time'] = this.orderTime;
    data['cafe_name'] = this.cafeName;
    data['isComplete'] = this.isComplete;
    data['user_id'] = this.userId;
    data['order_update'] = this.orderUpdate;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
