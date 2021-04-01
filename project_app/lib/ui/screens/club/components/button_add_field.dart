import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Club.dart';
import 'package:project_app/ui/components/rounded_button.dart';
import 'package:project_app/ui/screens/createField/create_field.dart';

class ButtonAddField extends StatelessWidget {
  const ButtonAddField({
    Key key,
    @required this.isOwner,
    @required this.club,
  }) : super(key: key);

  final bool isOwner;
  final Club club;

  @override
  Widget build(BuildContext context) {
    return isOwner
        ? Center(
            child: Container(
              width: sized(context).width * 0.9,
              child: RoundedButton(
                text: 'Add Field',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateField(
                        clubId: club.id,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : SizedBox();
  }
}
