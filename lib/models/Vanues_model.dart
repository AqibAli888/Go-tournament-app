class Vanues
{
  String? Name;
  String?vanuename;
  String? Location;
  Vanues({
    this.vanuename,
    this.Name,
    this.Location
  });

  Vanues.fromJson(Map<String,dynamic>json)
  {
    Name=json["Name"];
    Location=json["Location"];
    vanuename=json["vanuename"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Name"]=this.Name;
    data["vanuename"]=this.vanuename;
    data["Location"]=this.Location;
    return data;
  }
}