import 'package:flutter/material.dart';
import 'package:project_app/core/models/Field.dart';
import 'package:project_app/ui/screens/field/components/title_bar.dart';

class SectionInfo extends StatelessWidget {
  final Field? field;
  const SectionInfo({Key? key,@required this.field}) : super(key: key);

  Widget buildTitle({IconData? iconData, String? text}) {
    return Row(
      children: [
        iconData != null
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Icon(iconData),
        )
            : SizedBox(),
        Text(
          text!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  Widget buildFormData({String? title, String? detail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle(text: title!),
        Text(detail!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
<<<<<<< HEAD
          TitleBar(icon: Icons.info, title: 'ข้อมูลสนาม'),
          SizedBox(height: 8),
          buildFormData(title: 'ชื่อสนาม', detail: '${field!.title}'),
          buildFormData(title: 'รายละเอียดสนาม', detail: '${field!.detail}'),
          buildFormData(title: 'เวลาเปิด/ปิด', detail: '${field!.hours}'),
          buildFormData(title: 'ราคา', detail: '${field!.price}'),
          buildFormData(title: 'โทร', detail: '${field!.tel}'),
=======
          TitleBar(icon: Icons.info, title: 'Info'),
          SizedBox(height: 8),
          buildFormData(title: 'Title', detail: '${field!.title}'),
          buildFormData(title: 'Detail', detail: '${field!.detail}'),
          buildFormData(title: 'Address', detail: '${field!.address}'),
          buildFormData(title: 'office hours', detail: '${field!.hours}'),
          buildFormData(title: 'price range', detail: '${field!.price}'),
          buildFormData(title: 'Tal', detail: '${field!.tel}'),
>>>>>>> master
        ],
      ),
    );
  }
}
