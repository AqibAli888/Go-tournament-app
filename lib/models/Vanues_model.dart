class Vanues
{
  String? Name;
  String?vanuename;
  String? Location;
  String? id;
  Vanues({
    this.vanuename,
    this.Name,
    this.Location,
    this.id
  });

  Vanues.fromJson(Map<String,dynamic>json)
  {
    Name=json["Name"];
    Location=json["Location"];
    vanuename=json["vanuename"];
    id=json["id"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Name"]=this.Name;
    data["vanuename"]=this.vanuename;
    data["Location"]=this.Location;
    data["id"]=this.id;
    return data;
  }
}