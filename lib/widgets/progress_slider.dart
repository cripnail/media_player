// import 'package:flutter/material.dart';
//
// class ProgressSlider extends StatelessWidget {
//   const ProgressSlider({
//     Key? key,
//     required this.textStyle,
//   }) : super(key: key);
//
//   final TextStyle textStyle;
//
//   @override
//   Widget build(BuildContext context) {
//     const textStyle = TextStyle(color: Colors.white);
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text('00:00', style: textStyle),
//               Text('10:10', style: textStyle),
//             ],
//           ),
//         ),
//         SizedBox(
//           width: 300,
//           height: 25,
//           child: Slider(
//             min: 0,
//             max: 280,
//             value: 150,
//             activeColor: Colors.white,
//             inactiveColor: Colors.grey,
//             onChanged: (value) {},
//           ),
//         )
//       ],
//     );
//   }
// }
