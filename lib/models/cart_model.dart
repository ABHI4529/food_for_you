class CartModel {
  String? cafeName;
  List<Items>? items;

  CartModel({this.cafeName, this.items});

  CartModel.fromJson(Map<String, dynamic> json) {
    cafeName = json['cafe_name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cafe_name'] = this.cafeName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? itemName;
  double? itemPrice;
  String? itemDescription;
  String? itemImg;
  String? spice;
  String? texture;
  String? allergy;

  Items(
      {this.itemName,
      this.itemPrice,
      this.itemDescription,
      this.itemImg,
      this.spice,
      this.texture,
      this.allergy});

  Items.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    itemDescription = json['item_description'];
    itemImg = json['item_img'];
    spice = json['spice'];
    texture = json['texture'];
    allergy = json['allergy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['item_description'] = this.itemDescription;
    data['item_img'] = this.itemImg;
    data['spice'] = this.spice;
    data['texture'] = this.texture;
    data['allergy'] = this.allergy;
    return data;
  }
}
