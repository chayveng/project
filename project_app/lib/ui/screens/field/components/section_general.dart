import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/field/components/section_location.dart';

class SectionGeneral extends StatelessWidget {
  final Field field;

  const SectionGeneral({Key key, @required this.field}) : super(key: key);

  Widget buildFormData({String title, String detail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(text: title),
        Text(detail),
      ],
    );
  }

  Widget buildTitle({IconData iconData, String text}) {
    return Row(
      children: [
        iconData != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(iconData),
              )
            : SizedBox(),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(iconData: Icons.circle_notifications, text: 'General'),
          SizedBox(height: 10),
          buildFormData(
            title: 'Title',
            detail: '${field.title}',
          ),
          buildFormData(
            title: 'Detail',
            detail: '${field.detail}',
          ),
          buildFormData(
            title: 'Address',
            detail:
                '${field.address}',
          ),
          buildFormData(
            title: 'office hours',
            detail: '${field.hours}',
          ),
          buildFormData(
            title: 'price range',
            detail: '${field.price}',
          ),
          buildFormData(
            title: 'Tal',
            detail: '${field.tel}',
          ),
          SizedBox(height: 10),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle(iconData: Icons.location_on, text: 'Location'),
                SizedBox(height: 8.0),
                Container(
                  width: sized(context).width,
                  height: 300,
                  color: Colors.grey.shade400,
                  child: SectionLocation(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
