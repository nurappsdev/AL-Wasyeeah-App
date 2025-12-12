
import 'package:al_wasyeah/view/screen/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/controllers.dart';
import 'helpers/di.dart' as di;
import 'helpers/app_routes.dart';
import 'themes/theme.dart';
import 'utils/utils.dart';
import 'view/screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Stripe.publishableKey = AppConstants.publishAbleKey;
//   // DependencyInjection di = DependencyInjection();
//   // di.dependencies();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(const MyApp());
//
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       builder: (context, child) {
//         return GetMaterialApp(
//           debugShowCheckedModeBanner: false,
//           translations: Languages(), // Use your Languages class here
//           locale: Locale('bn', 'US'), // Default locale
//           fallbackLocale: Locale('en', 'US'),
//           title: 'Service App',
//           home: const SplashScreen(),
//           getPages: AppRoutes.routes,
//           theme: light(),
//           themeMode: ThemeMode.light,
//         );
//       },
//       designSize: const Size(393, 852),
//     );
//   }
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Map<String, Map<String, String>> _languages = await di.init();


  runApp(DemoPage()/*MyApp(
    languages: _languages,
  )*/);
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(360, 690),
//       // minTextAdapt: true,
//       // splitScreenMode: true,
//       builder: (_, child) {
//         return GetMaterialApp(
//           translations: Languages(), // Use your Languages class here
//           locale: Locale('en', 'US'), // Default locale
//           fallbackLocale: Locale('en', 'US'), // Fallback if locale not found
//           theme: light(),
//           debugShowCheckedModeBanner: false,
//           getPages: RoutePages.routes,
//           initialRoute: RouteNames.splashScreen,
//           initialBinding: ControllerBindings(),
//         );
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
                title: "App Name",
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                theme: light(),
                getPages: AppRoutes.routes,
                initialRoute: AppRoutes.firstSplashScreen,
                initialBinding: ControllerBindings(),
                // theme: themeController.darkTheme ? dark(): light(),
              
                defaultTransition: Transition.topLevel,
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode),
                transitionDuration: const Duration(milliseconds: 500),
              );

          });
    });
  }
}



class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String? selectedCountry;

  final countries = const [
    "Pakistan",
    "India",
    "Bangladesh",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        body: Center(
          child: SizedBox(
            width: 258,
            child: FancyDropdownSearch<String>(
  items: const ["Apple", "Banana", "Cherry"],
  label: "Fruit",
  hint: "Select a fruit",
  value: selectedCountry,
  itemToString: (v) => v,
  onChanged: (v) => setState(() => selectedCountry = v),
)
,
          ),
        ),
      ),
    );
  }
}




class FancyDropdownSearch<T> extends StatefulWidget {
  const FancyDropdownSearch({
    super.key,
    required this.items,
    required this.label,
    required this.hint,
    required this.itemToString,
    this.leadingBuilder,
    this.value,
    this.onChanged,
    this.maxMenuHeight = 280,
    this.enabled = true,
  });

  final List<T> items;
  final String label;
  final String hint;
  final String Function(T item) itemToString;
  final Widget? Function(T item)? leadingBuilder;

  final T? value;
  final ValueChanged<T?>? onChanged;

  final double maxMenuHeight;
  final bool enabled;

  @override
  State<FancyDropdownSearch<T>> createState() => _FancyDropdownSearchState<T>();
}

class _FancyDropdownSearchState<T> extends State<FancyDropdownSearch<T>> {
  bool _open = false;

  // colors
  static const _primary = Color(0xFF3B82F6);
  static const _success = Color(0xFF22C55E);
  static const _border = Color(0xFFD7DDE8);
  static const _text = Color(0xFF101828);
  static const _muted = Color(0xFF667085);

  static const TextStyle _textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: _text,
  );

  bool _isSelected(T item, T? selected) {
    if (selected == null) return false;
    // Prefer identity/equality. If your T doesn't implement == properly,
    // swap to comparing itemToString.
    return item == selected;
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.value != null;

    final borderColor = _open
        ? _primary
        : (hasValue ? _success : _border);

    final glow = _open
        ? [
            BoxShadow(
              color: _primary.withOpacity(.25),
              blurRadius: 18,
              spreadRadius: 2,
            )
          ]
        : (hasValue
            ? [
                BoxShadow(
                  color: _success.withOpacity(.25),
                  blurRadius: 18,
                  spreadRadius: 2,
                )
              ]
            : <BoxShadow>[]);

    final showLabel = _open || hasValue;
    final displayText = hasValue
        ? widget.itemToString(widget.value as T)
        : widget.hint;

    return DropdownSearch<T>(
      enabled: widget.enabled,
      items: (filter, infiniteScrollProps) => widget.items,

      selectedItem: widget.value,
      onChanged: widget.onChanged,

      itemAsString: (item) => item == null ? "" : widget.itemToString(item),

      // Track open/close to paint border/glow + floating label state
      // onPopupOpening: () {
      //   setState(() => _open = true);
      // },
      // onPopupDismissed: () {
      //   setState(() => _open = false);
      // },

      // Remove default underline/borders – we render our own field container
      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
      ),

      dropdownBuilder: (context, selectedItem) {
        final has = selectedItem != null;
        final txt = has ? widget.itemToString(selectedItem) : widget.hint;

        return Container(
          height: 58,
          padding: const EdgeInsets.only(left: 16, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
            boxShadow: glow,
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 160),
                left: 0,
                top: showLabel ? 10 : 19,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  opacity: showLabel ? 1 : 0,
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      color: _muted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: showLabel ? 18 : 0),
                      child: Text(
                        txt,
                        style: _textStyle.copyWith(
                          color: has ? _text : _muted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 160),
                    turns: _open ? 0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: _muted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },

      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        constraints: BoxConstraints(maxHeight: widget.maxMenuHeight),

        // ✅ No auto-focus -> keyboard won't open automatically
        searchFieldProps: TextFieldProps(
          autofocus: false,
          decoration: InputDecoration(
            hintText: "Search…",
            hintStyle: const TextStyle(
              color: _muted,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black.withOpacity(.10)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black.withOpacity(.10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _primary, width: 1.5),
            ),
          ),
        ),

        // ✅ Outer popup card (same as yours)
        containerBuilder: (ctx, popupWidget) {
          return Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black.withOpacity(.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.12),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: popupWidget,
            ),
          );
        },

        // ✅ Search area background (top strip like your design)
        // searchBoxDecoration: BoxDecoration(
        //   color: const Color(0xFFFAFAFA),
        //   borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
        //   border: Border(bottom: BorderSide(color: Color(0x0F000000))),
        // ),

        // ✅ “No results” style
        emptyBuilder: (context, searchEntry) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No results", style: TextStyle(color: _muted)),
          );
        },

        // ✅ Row design (leading + selected highlight + check)
        itemBuilder: (context, item, isDisabled, isSelected) {
          final selected = _isSelected(item, widget.value);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: isDisabled
                  ? null
                  : () {
                      // dropdown_search handles selection internally,
                      // so just close by selecting; onChanged will fire.
                      Navigator.of(context).pop(item);
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFFEEF4FF) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    if (widget.leadingBuilder != null) ...[
                      SizedBox(
                        width: 24,
                        child: Center(child: widget.leadingBuilder!(item)),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: Text(
                        widget.itemToString(item),
                        style: _textStyle,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 120),
                      opacity: selected ? 1 : 0,
                      child: const Icon(
                        Icons.check_rounded,
                        color: _primary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


// class FancySearchDropdown<T> extends StatefulWidget {
//   const FancySearchDropdown({
//     super.key,
//     required this.items,
//     required this.label,
//     required this.hint,
//     required this.itemToString,
//     this.leadingBuilder,
//     this.value,
//     this.onChanged,
//     this.maxMenuHeight = 280,
//   });

//   final List<T> items;
//   final String label;
//   final String hint;
//   final String Function(T item) itemToString;
//   final Widget? Function(T item)? leadingBuilder;

//   final T? value;
//   final ValueChanged<T?>? onChanged;

//   final double maxMenuHeight;

//   @override
//   State<FancySearchDropdown<T>> createState() => _FancySearchDropdownState<T>();
// }

// class _FancySearchDropdownState<T> extends State<FancySearchDropdown<T>> {
//   final LayerLink _layerLink = LayerLink();
//   final GlobalKey _fieldKey = GlobalKey();

//   OverlayEntry? _entry;
//   bool _open = false;

//   // colors
//   static const _primary = Color(0xFF3B82F6);
//   static const _success = Color(0xFF22C55E);
//   static const _border = Color(0xFFD7DDE8);
//   static const _text = Color(0xFF101828);
//   static const _muted = Color(0xFF667085);

//   static const TextStyle _textStyle = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: _text,
//   );

//   @override
//   void dispose() {
//     _removeOverlay();
//     super.dispose();
//   }

//   void _toggle() => _open ? _close() : _openMenu();

//   Size _fieldSize() {
//     final ctx = _fieldKey.currentContext;
//     if (ctx == null) return const Size(360, 58);
//     final box = ctx.findRenderObject() as RenderBox?;
//     if (box == null) return const Size(360, 58);
//     return box.size;
//   }

//   void _openMenu() {
//     if (_open) return;
//     _open = true;
//     setState(() {});

//     final fieldSize = _fieldSize();

//     _entry = OverlayEntry(
//       builder: (context) {
//         return Stack(
//           children: [
//             Positioned.fill(
//               child: GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 onTap: _close,
//               ),
//             ),
//             CompositedTransformFollower(
//               link: _layerLink,
//               showWhenUnlinked: false,
//               offset: Offset(0, fieldSize.height + 10), // perfectly below field
//               child: Material(
//                 color: Colors.transparent,
//                 child: _PopupMenu<T>(
//                   width: fieldSize.width, // ✅ always aligned with button width
//                   maxHeight: widget.maxMenuHeight,
//                   items: widget.items,
//                   value: widget.value,
//                   itemToString: widget.itemToString,
//                   leadingBuilder: widget.leadingBuilder,
//                   onSelect: (v) {
//                     widget.onChanged?.call(v);
//                     _close();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );

//     Overlay.of(context, rootOverlay: true).insert(_entry!);
//   }

//   void _close() {
//     if (!_open) return;
//     _open = false;
//     _removeOverlay();
//     if (mounted) setState(() {});
//   }

//   void _removeOverlay() {
//     _entry?.remove();
//     _entry = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hasValue = widget.value != null;

//     final Color borderColor = _open ? _primary : (hasValue ? _success : _border);

//     final List<BoxShadow> glow = _open
//         ? [BoxShadow(color: _primary.withOpacity(.25), blurRadius: 18, spreadRadius: 2)]
//         : (hasValue
//             ? [BoxShadow(color: _success.withOpacity(.25), blurRadius: 18, spreadRadius: 2)]
//             : []);

//     final bool showLabel = _open || hasValue;
//     final String displayText = hasValue ? widget.itemToString(widget.value as T) : widget.hint;

//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: _toggle,
//         child: Container(
//           key: _fieldKey,
//           height: 58,
//           padding: const EdgeInsets.only(left: 16, right: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: borderColor, width: 2),
//             boxShadow: glow,
//           ),
//           child: Stack(
//             children: [
//               // floating label
//               AnimatedPositioned(
//                 duration: const Duration(milliseconds: 160),
//                 left: 0,
//                 top: showLabel ? 10 : 19,
//                 child: AnimatedOpacity(
//                   duration: const Duration(milliseconds: 160),
//                   opacity: showLabel ? 1 : 0,
//                   child: Text(
//                     widget.label,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       height: 1,
//                       color: _muted,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),

//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: showLabel ? 18 : 0),
//                       // ✅ Not editable anymore: pure Text
//                       child: Text(
//                         displayText,
//                         style: _textStyle.copyWith(
//                           color: hasValue ? _text : _muted,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 6),
//                   AnimatedRotation(
//                     duration: const Duration(milliseconds: 160),
//                     turns: _open ? 0.5 : 0,
//                     child: const Icon(Icons.keyboard_arrow_down_rounded, color: _muted),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _PopupMenu<T> extends StatefulWidget {
//   const _PopupMenu({
//     required this.width,
//     required this.maxHeight,
//     required this.items,
//     required this.value,
//     required this.itemToString,
//     required this.onSelect,
//     this.leadingBuilder,
//   });

//   final double width;
//   final double maxHeight;
//   final List<T> items;
//   final T? value;
//   final String Function(T item) itemToString;
//   final Widget? Function(T item)? leadingBuilder;
//   final ValueChanged<T> onSelect;

//   @override
//   State<_PopupMenu<T>> createState() => _PopupMenuState<T>();
// }

// class _PopupMenuState<T> extends State<_PopupMenu<T>> {
//   final TextEditingController _search = TextEditingController();
//   List<T> _filtered = [];

//   static const _primary = Color(0xFF3B82F6);
//   static const _muted = Color(0xFF667085);
//   static const _text = Color(0xFF101828);

//   static const TextStyle _textStyle = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w500,
//     color: _text,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _filtered = widget.items;
//     _search.addListener(_applyFilter);
//   }

//   @override
//   void dispose() {
//     _search.removeListener(_applyFilter);
//     _search.dispose();
//     super.dispose();
//   }

//   void _applyFilter() {
//     final q = _search.text.trim().toLowerCase();
//     setState(() {
//       _filtered = q.isEmpty
//           ? widget.items
//           : widget.items
//               .where((e) => widget.itemToString(e).toLowerCase().contains(q))
//               .toList();
//     });
//   }

//   bool _isSelected(T item) {
//     if (widget.value == null) return false;
//     return widget.itemToString(item) == widget.itemToString(widget.value as T);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       constraints: BoxConstraints(maxHeight: widget.maxHeight),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         border: Border.all(color: Colors.black.withOpacity(.08)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.12),
//             blurRadius: 24,
//             offset: const Offset(0, 12),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // ✅ Search is visible but NOT auto-focused (no keyboard on open)
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFAFAFA),
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
//               border: Border(bottom: BorderSide(color: Colors.black.withOpacity(.06))),
//             ),
//             child: TextField(
//               controller: _search,
//               decoration: InputDecoration(
//                 hintText: "Search…",
//                 hintStyle: const TextStyle(color: _muted, fontWeight: FontWeight.w500),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.black.withOpacity(.10)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(color: Colors.black.withOpacity(.10)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: _primary, width: 1.5),
//                 ),
//               ),
//             ),
//           ),

//           Flexible(
//             child: _filtered.isEmpty
//                 ? const Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Text("No results", style: TextStyle(color: _muted)),
//                   )
//                 : ListView.separated(
//                     padding: const EdgeInsets.all(10),
//                     itemCount: _filtered.length,
//                     separatorBuilder: (_, __) => const SizedBox(height: 6),
//                     itemBuilder: (context, i) {
//                       final item = _filtered[i];
//                       final selected = _isSelected(item);

//                       return InkWell(
//                         borderRadius: BorderRadius.circular(12),
//                         onTap: () => widget.onSelect(item),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                           decoration: BoxDecoration(
//                             color: selected ? const Color(0xFFEEF4FF) : Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             children: [
//                               if (widget.leadingBuilder != null) ...[
//                                 SizedBox(width: 24, child: Center(child: widget.leadingBuilder!(item))),
//                                 const SizedBox(width: 10),
//                               ],
//                               Expanded(child: Text(widget.itemToString(item), style: _textStyle)),
//                               AnimatedOpacity(
//                                 duration: const Duration(milliseconds: 120),
//                                 opacity: selected ? 1 : 0,
//                                 child: const Icon(Icons.check_rounded, color: _primary, size: 20),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

