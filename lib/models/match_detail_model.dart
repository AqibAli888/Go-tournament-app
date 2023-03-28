class Match_Detail_model
{
  String? id;
  String? team0;
  bool?team0_win;
  String? team1;
  String? result;
  bool?team1_win;
  Match_Detail_model({
    required this.id,
    required this.result,
    required this.team0,
    required this.team1,
    required this.team0_win,
    required this.team1_win

  });

  Match_Detail_model.fromJson(Map<String,dynamic>json)
  {
    id=json["id"];
    result=json["result"];
    team0=json["team0"];
    team0_win=json["team0_win"];
    team1=json["team1"];
    team1_win=json["team1_win"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["id"]=this.id;
    data["team0"]=this.team0;
    data["result"]=this.result;
    data["team0_win"]=this.team0_win;
    data["team1"]=this.team1;
    data["team1_win"]=this.team1_win;
    return data;
  }

}