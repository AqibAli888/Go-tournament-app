class All_Tournament_Showing_model
{
  String? Tournament_Name;
  String? id;
  String?end;
  String?format;
  String? time;
  All_Tournament_Showing_model({
    this.Tournament_Name,
    this.id,
    this.format,
    this.time,
    this.end
  });

  All_Tournament_Showing_model.fromJson(Map<String,dynamic>json)
  {
    Tournament_Name=json["Tournament_Name"];
    id=json["id"];
    format=json["format"];
    time=json["time"];
    format=json["format"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Tournament_Name"]=this.Tournament_Name;
    data["id"]=this.id;
    data["format"]=this.format;
    data["time"]=this.time;
    data["end"]=this.end;
    return data;
  }
}