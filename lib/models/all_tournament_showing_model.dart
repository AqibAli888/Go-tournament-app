class All_Tournament_Showing_model
{
  String? Tournament_Name;
  String? End_tournament;
  String? Location;
  String? Start_tournament;
  String? id;
  String?format;
  All_Tournament_Showing_model({
    this.Tournament_Name,
    this.id,
    this.format,
    this.End_tournament,
    this.Start_tournament,
    this.Location

  });

  All_Tournament_Showing_model.fromJson(Map<String,dynamic>json)
  {
    Tournament_Name=json["Tournament_Name"];
    id=json["id"];
    format=json["format"];
    End_tournament=json["End_tournament"];
    Location=json["Location"];
    Start_tournament=json["Start_tournament"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Tournament_Name"]=this.Tournament_Name;
    data["id"]=this.id;
    data["format"]=this.format;
    data["End_tournament"]=this.End_tournament;
    data["Location"]=this.Location;
    data["Start_tournament"]=this.Start_tournament;
    return data;
  }
}