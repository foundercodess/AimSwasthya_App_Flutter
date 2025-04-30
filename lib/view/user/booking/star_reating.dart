//
// import 'package:flutter/material.dart';
//
// class StarRating extends StatefulWidget {
//   final double initialRating;
//   final double size;
//
//   const StarRating({
//     super.key,
//     this.initialRating = 4.0,
//     this.size = 12.0,
//   });
//
//   @override
//   _StarRatingState createState() => _StarRatingState();
// }
//
// class _StarRatingState extends State<StarRating> {
//   late double rating;
//
//   @override
//   void initState() {
//     super.initState();
//     rating = widget.initialRating;
//   }
//
//   void _handleStarTap(int index) {
//     setState(() {
//       rating = index + 1.0;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(5, (index) {
//         return GestureDetector(
//           onTap: () => _handleStarTap(index),
//           child: Icon(
//             index < rating ? Icons.star : Icons.star_border,
//             color: index < rating ? const Color(0xffFFE500) : Colors.white,
//             size: widget.size,
//           ),
//         );
//       }),
//     );
//   }
// }
