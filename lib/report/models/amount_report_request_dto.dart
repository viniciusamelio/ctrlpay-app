class AmountReportRequestDto {

    DateTime begin;
    DateTime end;
    int idUser;

    Map<String,dynamic> toJson(){
        Map<String,dynamic> json = {};
        json["begin"] = begin.toString();
        json['end'] = end.add(Duration(hours: 24)).toString();
        print(json['end']);
        json['id_user'] = idUser;
        return json;
    }
}