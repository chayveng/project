import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/home/components/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  List<Field> field = [
    Field(title: 'kk'),
    Field(title: 'pogk'),
    Field(title: 'ad')
  ];
  final List<String> list = List.generate(100, (index) => '$index');

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            elevation: 10,
            backgroundColor: orangeColor,
            title: Text('Text Screen'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print('search');
                  showSearch(context: context, delegate: Search(widget.field));
                },
              ),
            ],
          ),

          // Container(
          //   color: Colors.red,
          //   child: CustomSearchBar(
          //     onTap: () {
          //       showSearch(context: context, delegate: Search(widget.list));
          //     },
          //   ),
          // ),
          Container(
            height: sized(context).height,
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(widget.list[index]),
              ),
            ),
          )
        ],
      ),
    );
    //   ListView.builder(
    //   itemCount: widget.list.length,
    //   itemBuilder: (context, index) => ListTile(
    //     title: Text(
    //       widget.list[index],
    //     ),
    //   ),
    // );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
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

  // List<String> recentList = ['00', '11'];
  List<Field> field = [
    Field(title: 'kk'),
    Field(title: 'pogk'),
    Field(title: 'ad')
  ];

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
          // showResults(context);
        },
      ),
    );
  }
}
