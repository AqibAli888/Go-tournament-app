class Team
{
  String? Name;
  String? level;
  String? added;
  Team({
     this.Name,
    this.added,
     this.level
});

  Team.fromJson(Map<String,dynamic>json)
  {
    Name=json["Name"];
    added=json["added"];
    level=json["level"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Name"]=this.Name;
    data["added"]=this.added;
    data["level"]=this.level;
    return data;
  }
}