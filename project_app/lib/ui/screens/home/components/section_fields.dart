import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/components/card_field.dart';
import 'package:project_app/ui/screens/field/field_screen.dart';

import 'custom_search_bar.dart';

class SectionFields extends StatefulWidget {
  final List<Field>? fields;

  const SectionFields({Key? key, @required this.fields}) : super(key: key);

  @override
  _SectionFieldsState createState() => _SectionFieldsState();
}

class _SectionFieldsState extends State<SectionFields> {
  void _onTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FieldScreen(
          isOwner: false,
          fieldId: widget.fields![index].id!,
        ),
      ),
    );
  }

  List<String> lst = List.generate(100, (index) => index.toString());

  @override
  Widget build(BuildContext context) {
    print('${widget.fields!.length} dddddd');
    return Container(
      // child: ListView(
      //   padding: EdgeInsets.zero,
      //   children: [
      //     ...List.generate(
      //       lst.length,
      //       (index) => Text(lst[index]),
      //     ),
      //   ],
      // ),
      // child: Column(
      //   children: [
      //     ...List.generate(
      //       lst.length,
      //       (index) => Text(lst[index]),
      //     ),
      //   ],
      // ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.fields!.length == 0 ? 0 : widget.fields!.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          // child: Text(widget.fields![index].title!),
          child: CardField(
            isOwner: false,
            field: widget.fields![index],
            onTap: () => _onTap(index),
            onRemove: () => print('remove'),
          ),
        ),
      ),
    );
    // return Column(
    //   children: [
    //     ...List.generate(
    //       widget.fields!.length,
    //       (index) => Column(
    //         children: [
    //           index == 0 ? SizedBox() : SizedBox(),
    //           // index == 0 ? CustomSearchBar() : SizedBox(),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: CardField(
    //               isOwner: false,
    //               field: widget.fields![index],
    //               onTap: () => _onTap(index),
    //               onRemove: () => print('remove'),
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }
}
