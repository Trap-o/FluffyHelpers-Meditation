// import 'package:flutter/material.dart';
//
// import '../../../constants/app_button_styles.dart';
// import '../../../constants/app_colors.dart';
// import '../../../constants/app_routes.dart';
// import '../../../constants/app_text_styles.dart';
//
// const String devCredits =
//   'Додаток було розроблено студентами Софією Киричок та Віталієм Яценко '
//   'в межах переддипломної практики під керівництвом ФОП "Бабич О.В."';
//
// class AppDetailsDialog extends StatelessWidget {
//   const AppDetailsDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       alignment: Alignment.center,
//       backgroundColor: AppColors.secondaryBackground,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Про додаток",
//               style: AppTextStyles.title
//             ),
//             const SizedBox(height: 20),
//             Text(
//               devCredits,
//               style: AppTextStyles.body,
//               textAlign: TextAlign.justify,
//               textDirection: TextDirection.ltr,
//               softWrap: true,
//               overflow: TextOverflow.visible,
//               textWidthBasis: TextWidthBasis.parent,
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       style: AppButtonStyles.secondary,
//                       child: const Text("OK"),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, AppRoutes.webBrowser);
//                       },
//                       style: AppButtonStyles.primary,
//                       child: const Text(
//                         "GitHub",
//                         softWrap: true,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }