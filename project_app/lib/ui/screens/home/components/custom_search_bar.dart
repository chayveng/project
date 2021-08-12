import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/home/components/search_engine.dart';

import '../../../../constants.dart';

class CustomSearchBar extends StatelessWidget {
  final List<Field>? fields;

  const CustomSearchBar({
    Key? key,
   @required this.fields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: whiteColor,
        title: Text('หน้าหลัก'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('search');
              showSearch(context: context, delegate: Search(fields!));
            },
          ),
        ],
    );
  }

  // Widget searchField(Size sized) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 5),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(10),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: whiteColor,
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.5),
  //               spreadRadius: 2,
  //               blurRadius: 7,
  //               offset: Offset(0, 5),
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: TextField(
  //           decoration: InputDecoration(
  //             hintText: 'Search',
  //             enabledBorder: InputBorder.none,
  //             focusedBorder: InputBorder.none,
  //             prefixIcon: Icon(Icons.search),
  //             contentPadding: EdgeInsets.only(top: 16),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
