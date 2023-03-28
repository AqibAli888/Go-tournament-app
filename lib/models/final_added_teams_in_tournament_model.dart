class Final_added_teams
{
  String? Team_Name;
  String? Level;
  Final_added_teams({
    this.Team_Name,
    this.Level
  });

  Final_added_teams.fromJson(Map<String,dynamic>json)
  {
    Team_Name=json["Team_Name"];
    Level=json["Level"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Team_Name"]=this.Team_Name;
    data["Level"]=this.Level;
    return data;
  }
}