// import 'package:flutter/material.dart';
// import 'package:intro_slider/intro_slider.dart';

// class IntroductionScreen extends StatefulWidget {
//   @override
//   _IntroductionScreenState createState() => _IntroductionScreenState();
// }

// class _IntroductionScreenState extends State<IntroductionScreen> {
//   List<Slide> slides = new List();

//   @override
//   void initState() {
//     super.initState();

//     slides.add(
//       new Slide(
//         title: "Walkman",
//         description:
//             "Allow miles wound place the leave had. To sitting subject no improve studied limited",
//         pathImage: "assets/images/onboarding0.png",
//         backgroundColor: Color(0xFF005A21),
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "Walkman",
//         description:
//             "Ye indulgence unreserved connection alteration appearance",
//         pathImage: "assets/images/onboarding1.png",
//         backgroundColor: Color(0xFF005A21),
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "Walkman",
//         description:
//             "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
//         pathImage: "assets/images/onboarding2.png",
//         backgroundColor: Color(0xFF005A21),
//       ),
//     );
//   }

//   void onDonePress() {
//     Navigator.pushNamed(context, '/auth');
//   }

//   void onSkipPress() {
//     Navigator.pushNamed(context, '/auth');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new IntroSlider(
//       slides: this.slides,
//       onDonePress: this.onDonePress,
//       onSkipPress: this.onSkipPress,
//     );
//   }
// }
