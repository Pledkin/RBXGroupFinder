import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

Future<dynamic> getGroupList(String searchTerm, int limit, String cursor) async {
  var url;

  if (cursor != '') {
    url = 'https://groups.roblox.com/v1/groups/search?keyword=' + searchTerm + '&limit=' + limit.toString() + '&cursor=' + cursor;
  } else if (cursor == '') {
    url = 'https://groups.roblox.com/v1/groups/search?keyword=' + searchTerm + '&limit=' + limit.toString();
  }

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed');
  }
}

Future<dynamic> getGroupDetails(int groupId) async {
  var url = 'https://groups.roblox.com/v1/groups/' + groupId.toString();

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse;
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw Exception('Failed');
  }
}

Future<dynamic> getGroupFunds(int groupId) {
  
}