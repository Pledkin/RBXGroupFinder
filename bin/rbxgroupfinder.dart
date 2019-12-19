import 'dart:io';

import 'package:rbxgroupfinder/src/rbx_group_finder.dart';

void main(List<String> args) async {
  List<int> groupIdsWithoutOwner = [];
  String searchTerm;
  //List<int> groupIdsWithRobux = [];
  var groupSearchLimit = 100;
  var groupList;
  var untilPage = 10;
  var page = 0;

  print('Enter search term: ');
  searchTerm = stdin.readLineSync();

  while (page < untilPage) {
    print('Page: ' + (page + 1).toString());
    if (page == 0) {
      groupList = await getGroupList(searchTerm, groupSearchLimit, '');
    } else {
      groupList = await getGroupList(searchTerm, groupSearchLimit, groupList['nextPageCursor']);
    }
    for (var i = 0; i < groupSearchLimit; i++) {
      var group = groupList['data'][i];
      var groupDetails = await getGroupDetails(group['id']);
      var groupOwnerJson = groupDetails['owner'];
      if (groupDetails['publicEntryAllowed'] == true) {
        if (groupOwnerJson == null) {
          groupIdsWithoutOwner.add(group['id']);
        }
      }
    }
    page++;
  }

  print(groupIdsWithoutOwner);
}