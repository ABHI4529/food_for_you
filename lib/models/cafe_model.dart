class CafeModel {
  int? hotelId;
  String? address;
  String? addressURL;
  int? qualtity;
  int? quantity;
  int? authenticity;
  int? spicy;
  int? texture;
  int? ambience;

  CafeModel(
      {this.hotelId,
      this.address,
      this.addressURL,
      this.qualtity,
      this.quantity,
      this.authenticity,
      this.spicy,
      this.texture,
      this.ambience});

  CafeModel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotelId'];
    address = json['address'];
    addressURL = json['addressURL'];
    qualtity = json['qualtity'];
    quantity = json['quantity'];
    authenticity = json['authenticity'];
    spicy = json['spicy'];
    texture = json['texture'];
    ambience = json['ambience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotelId'] = this.hotelId;
    data['address'] = this.address;
    data['addressURL'] = this.addressURL;
    data['qualtity'] = this.qualtity;
    data['quantity'] = this.quantity;
    data['authenticity'] = this.authenticity;
    data['spicy'] = this.spicy;
    data['texture'] = this.texture;
    data['ambience'] = this.ambience;
    return data;
  }
}
