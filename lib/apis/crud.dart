import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  getData(
    url,
  ) async {
    try {
      var response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      }
      print(response.statusCode);
    } catch (e) {
      print("The Error is $e");
    }

//const String linkServerName2 = "https://waelabohamza.com/coursephp" ;
  }

  postData(url, data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      }
      print(response.statusCode);
    } catch (e) {
      print("The Error is $e");
    }

//const String linkServerName2 = "https://waelabohamza.com/coursephp" ;
  }
}

// ToDo
const String linkServerName = "http://10.0.2.2/todoapp";
const String linkView = "$linkServerName/todo/view.php";
const String linkAdd = "$linkServerName/todo/add.php";
const String linkEdit = "$linkServerName/todo/update.php";
const String linkDelete = "$linkServerName/todo/delete.php";
