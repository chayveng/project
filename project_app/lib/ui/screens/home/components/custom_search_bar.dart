import 'package:flutter/material.dart';

import '../../../../constants.dart';

class CustomSearchBar extends StatelessWidget {
  final GestureTapCallback? onTap;
  const CustomSearchBar({
    Key? key, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return searchField(sized);
  }

  Widget searchField(Size sized) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: onTap,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.only(top: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
