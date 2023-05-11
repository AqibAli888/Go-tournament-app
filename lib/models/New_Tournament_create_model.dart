class New_Tournament_model
{
  String? Tournament_Name;
  String?format;
  String?time;
  String?Start_tournament;
  String?End_tournament;
  String?Location;


  New_Tournament_model({
    this.Tournament_Name,
    this.Start_tournament,
    this.End_tournament,
    this.format,
    this.time,
    this.Location
  });

  New_Tournament_model.fromJson(Map<String,dynamic>json)
  {
    Tournament_Name=json["Tournament_Name"];
    Start_tournament=json["Start_tournament"];
    End_tournament=json["End_tournament"];
    format=json["format"];
    time=json["time"];
    Location=json["Location"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Tournament_Name"]=this.Tournament_Name;
    data["Start_tournament"]=this.Start_tournament;
    data["End_tournament"]=this.End_tournament;
    data["format"]=this.format;
    data["Location"]=this.Location;
    data["time"]=this.time;

    return data;
  }
}