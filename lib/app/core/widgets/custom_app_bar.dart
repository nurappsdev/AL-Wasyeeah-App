// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showBackButton;
//   final List<Widget>? actions;
//   final Widget? leading;
//   final PreferredSizeWidget? bottom;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.showBackButton = true,
//     this.actions,
//     this.leading,
//     this.bottom,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(title),
//       bottom: bottom,
//       leading: leading ??
//           (showBackButton
//               ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha:0.05),
//                           blurRadius: 4,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back_ios_new, size: 18),
//                       onPressed: () {
//                         if (Navigator.of(context).canPop()) {
//                           Navigator.of(context).pop();
//                         } else {
//                           Get.back();
//                         }
//                       },
//                     ),
//                   ),
//                 )
//               : null),
//       actions: actions,
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.leading,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          // left + right soft shadow
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: AppBar(
        elevation: 0, // important
        title: Text(title),
        bottom: bottom,
        leading: leading ??
            (showBackButton
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        onPressed: () {
                          if (Navigator.of(context).canPop()) {
                            Navigator.of(context).pop();
                          } else {
                            Get.back();
                          }
                        },
                      ),
                    ),
                  )
                : null),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
