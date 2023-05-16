class Match_Detail_model
{
  String? id;
  String? Date;
  String?Time;
  String? team0;
  String? team1;
  String? result;
  String? Match_Type;
  Match_Detail_model({
    required this.id,
    required this.Time,
    required this.result,
    required this.team0,
    required this.team1,
    required this.Match_Type,
    required this.Date,


  });

  Match_Detail_model.fromJson(Map<String,dynamic>json)
  {
    id=json["id"];
    result=json["result"];
    Match_Type=json["Match_Type"];
    Time=json["Time"];
    team0=json["team0"];
    Date=json["Date"];

    team1=json["team1"];

  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["id"]=this.id;
    data["team0"]=this.team0;
    data["Match_Type"]=this.Match_Type;
    data["Time"]=this.Time;
    data["result"]=this.result;
    data["Date"]=this.Date;
    data["team1"]=this.team1;

    return data;
  }

}