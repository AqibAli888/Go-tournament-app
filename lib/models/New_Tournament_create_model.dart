class New_Tournament_model
{
  String? Tournament_Name;
  String?format;
  String?time;


  New_Tournament_model({
    this.Tournament_Name,
    this.format,
    this.time
  });

  New_Tournament_model.fromJson(Map<String,dynamic>json)
  {
    Tournament_Name=json["Tournament_Name"];
    format=json["format"];
    time=json["time"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Tournament_Name"]=this.Tournament_Name;
    data["format"]=this.format;
    data["time"]=this.time;

    return data;
  }
}