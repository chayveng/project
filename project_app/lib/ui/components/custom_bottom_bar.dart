import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_app/ui/screens/home/home_screen.dart';
import 'package:project_app/ui/screens/other/other_screen.dart';

import '../../constants.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentIndex = 0;
  final tabs = [

  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'other',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
// class CustomBottomBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size sized = MediaQuery.of(context).size;
//     return Container(
//       color: orangePrimaryColor,
//       child: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 30),
//           height: 56,
//           color: orangePrimaryColor,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               BottomNavIcon(
//                 label: 'Home',
//                 iconData: Icons.home_outlined,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                       type: PageTransitionType.fade,
//                       child: HomeScreen(),
//                     ),
//                   );
//                 },
//               ),
//               BottomNavIcon(
//                 label: 'Booking',
//                 iconData: Icons.calendar_today_outlined,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                       type: PageTransitionType.fade,
//                       child: BookingScreen(),
//                     ),
//                   );
//                 },
//               ),
//               BottomNavIcon(
//                 label: 'Other',
//                 iconData: Icons.person_outline,
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     PageTransition(
//                       type: PageTransitionType.fade,
//                       child: OtherScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class BottomNavIcon extends StatelessWidget {
  final String? label;
  final IconData? iconData;
  final GestureTapCallback? onTap;

  const BottomNavIcon({
    Key? key,
    @required this.label,
    @required this.iconData,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              iconData,
              size: 22,
              color: navyPrimaryColor,
            ),
            SizedBox(height: 2),
            Text(
              label!,
              style: TextStyle(
                fontSize: 12,
                color: navyPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
