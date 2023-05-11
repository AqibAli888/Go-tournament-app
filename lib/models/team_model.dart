class Team
{
  String? Name;
  String? id;
  Team({
     this.Name,
     this.id,

});

  Team.fromJson(Map<String,dynamic>json)
  {
    Name=json["Name"];
    id=json["id"];

  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Name"]=this.Name;
    data["id"]=this.id;

    return data;
  }
}