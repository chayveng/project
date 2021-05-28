import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

class SectionGeneral extends StatelessWidget {
  const SectionGeneral({Key key}) : super(key: key);

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
          buildFormData(
            title: 'Title',
            detail: 'Arena plus',
          ),
          buildFormData(
            title: 'Detail',
            detail:
                'ซอคเกอร์ คิวบ์ สาขา ม.ขอนแก่น เป็นสนามฟุตบอลหญ้าเทียม เปิดบริการ 24 ชั่วโมง มีทั้งIndoor และOutdoor ตั้งอยู่ใกล้กับ',
          ),
          buildFormData(
            title: 'Address',
            detail:
                '3/7 ราษฎร์คนึง 8 ตำบล ศิลา อำเภอเมืองขอนแก่น ขอนแก่น 40000',
          ),
          buildFormData(
            title: 'office hours',
            detail: '09:00 - 02:00',
          ),
          buildFormData(
            title: 'price range',
            detail: '101-500 Baht',
          ),
          buildFormData(
            title: 'Tal',
            detail: '080-3114111',
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle(iconData: Icons.location_on,text: 'Location'),
                SizedBox(height: 8.0),
                Container(
                  width: sized(context).width,
                  height: 300,
                  color: Colors.grey.shade400,
                  child: Center(child: Text('Map'),),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
