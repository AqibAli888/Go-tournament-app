class Standing_Table_model
{
  String? Team_Name;
  String? Level;
  int?point;
  Standing_Table_model({
    required this.Level,
    required this.point,
    required this.Team_Name
  });

  Standing_Table_model.fromJson(Map<String,dynamic>json)
  {
    Team_Name=json["Team_Name"];
    Level=json["Level"];
    point=json["point"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Team_Name"]=this.Team_Name;
    data["Level"]=this.Level;
    data["point"]=this.point;
    return data;
  }

}