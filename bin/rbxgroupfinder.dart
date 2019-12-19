import 'dart:io';

import 'package:rbxgroupfinder/src/rbx_group_finder.dart';

void main(List<String> args) async {
  List<int> groupIdsWithoutOwner = [];
  String searchTerm;
  String howManyPages;
  //List<int> groupIdsWithRobux = [];
  var groupSearchLimit = 100;
  var groupList;
  var untilPage = 10;
  var page = 0;

  print('Enter search term: ');
  searchTerm = stdin.readLineSync();
  print('How many pages do you want this script to loop through? (Each page is 100 groups)');
  howManyPages = stdin.readLineSync();

  untilPage = int.parse(howManyPages);

  print('');

  while (page < untilPage) {
    print('Page ' + (page + 1).toString() + '/' + untilPage.toString());
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

  if (groupIdsWithoutOwner.length != 0) {
    print('');
    print('Here are group ids without owner:');
    for (var i = 0; i < groupIdsWithoutOwner.length; i++) {
      print(groupIdsWithoutOwner[i]);
    }
  } else {
    print('No groups without owner were found');
    exit(0);
  }
  print('');
  print('Press enter to continue');
  stdin.readLineSync();
}