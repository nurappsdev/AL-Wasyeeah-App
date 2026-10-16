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
  final double? toolbarHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.leading,
    this.bottom,
    this.toolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          // left + right soft shadow
          // BoxShadow(
          //   color: Colors.black.withValues(alpha: 0.06),
          //   blurRadius: 8,
          //   spreadRadius: 0,
          //   offset: const Offset(0, 0),
          // ),
        ],
      ),
      child: AppBar(
        elevation: 0, // important
        toolbarHeight: toolbarHeight,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        bottom: bottom,
        leading: leading ??
            (showBackButton
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF25282B)
                            : Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF384046)
                              : Colors.black.withValues(alpha: 0.08),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: isDark ? 0.3 : 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
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
  Size get preferredSize => Size.fromHeight((toolbarHeight ?? kToolbarHeight) +
      (bottom?.preferredSize.height ?? 0.0));
}
