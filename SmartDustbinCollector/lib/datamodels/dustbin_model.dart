class DustbinModel{
  String id;
  double height;
  double distance;
  String email;
  String name;
  String address;
  int percentFull;

  DustbinModel.fromJson(this.id, Map<String, dynamic> m){
    height = m['height']?.toDouble();
    distance = m['distance']?.toDouble();
    email = m['email']??"Not registered";
    name = m['name']??"Not registered";
    address = m['address']??"Not registered";
    if(height!=null && distance!=null){
      percentFull = ((1-distance/height)*100).round();
    }else{
      percentFull = 0;
    }
  }
}