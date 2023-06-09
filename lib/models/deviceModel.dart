class DeviceModel {
  String? deviceid;
  String? dname;
  String? dstate;
  String? temp;

  DeviceModel({this.deviceid, this.dname, this.dstate, this.temp});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    deviceid = json['deviceid'];
    dname = json['dname'];
    dstate = json['dstate'];
    temp = json['temp'];
  }

  get status => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceid'] = this.deviceid;
    data['dname'] = this.dname;
    data['dstate'] = this.dstate;
    data['temp'] = this.temp;
    return data;
  }
}


