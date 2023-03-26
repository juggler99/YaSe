import 'dart:convert';
import 'package:flutter_application_1/model/account.dart';
import 'package:http/http.dart' as http;
const String randomPersonUrl = "https://randomuser.me/api/";

class DataService {
  Future<List<Account>>fetchData(int amount) async {    
    String url = "$randomPersonUrl?results=${amount.toString()}";
    var targetUri = Uri.parse(url);
    http.Response response = await http.get(targetUri);
    if (response.statusCode == 200) {
      Map dataMap = jsonDecode(response.body);
      List<dynamic> data = dataMap['results'];
      return data.map((json) => Account.fromJsonRandomPerson(json)).toList();
    }
    else{
      throw Exception("Error fetching data: ${response.statusCode}");
    }
  }
}

