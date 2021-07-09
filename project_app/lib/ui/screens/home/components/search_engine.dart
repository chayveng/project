import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
          color: navyPrimaryColor,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: navyPrimaryColor,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  late String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  late final List<Field> listExample;

  Search(this.listExample);

  List<Field> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Field> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(
            listExample.where(
              (element) {
                // field[0].title!.contains(query);
                return element.title!.contains(query);
                // return element.contains(query);
              },
            ),
          );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          suggestionList[index].title!,
        ),
        onTap: () {
          selectedResult = suggestionList[index].title!;
          print('ssssss');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FieldScreen(
                isOwner: false,
                fieldId: suggestionList[index].id!,
              ),
            ),
          );
          // showResults(context);
        },
      ),
    );
  }
}
