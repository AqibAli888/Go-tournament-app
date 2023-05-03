class User_Detail_model
{
  String? Name;
  String? Phone;
  String? address;
  String? useremail;

  User_Detail_model({
    this.Name,
    this.Phone,
    this.address,
    this.useremail
  });

  User_Detail_model.fromJson(Map<String,dynamic>json)
  {
    Name=json["Name"];
    Phone=json["Phone"];
    address=json["address"];
    useremail=json["useremail"];
  }
  Map<String,dynamic>toJson()
  {
    final Map<String,dynamic>data=Map<String,dynamic>();
    data["Name"]=this.Name;
    data["Phone"]=this.Phone;
    data["addressName"]=this.address;
    data["useremail"]=this.useremail;

    return data;
  }
}