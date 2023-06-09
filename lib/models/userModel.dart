class CusUser {
  String? uid;
  String? uname;
  String? totaldev;
  String? uemail;
  String? uphone;
  String? address;
  String? city;
  String? state;
  String? pincode;

  CusUser(
      {this.uid,
      this.uname,
      this.totaldev,
      this.uemail,
      this.uphone,
      this.address,
      this.city,
      this.state,
      this.pincode});

  CusUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uname = json['uname'];
    totaldev = json['totaldev'];
    uemail = json['uemail'];
    uphone = json['uphone'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['uname'] = this.uname;
    data['totaldev'] = this.totaldev;
    data['uemail'] = this.uemail;
    data['uphone'] = this.uphone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}
