import 'package:wasiyyat/app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown({
    super.key,

    // REQUIRED
    required this.items,
    this.label,
    required this.hint,
    required this.itemToString,

    // VALUE
    this.value,
    this.onChanged,
    this.isValueSelected,
    this.validator,

    // STATE
    this.enabled = true,

    // DIMENSIONS
    this.borderRadius = 8,
    this.maxMenuHeight = 280,

    // SEARCH
    this.showSearchBox = true,
    this.searchHint,
  });

  final List<T> items;
  final String? label;
  final String hint;
  final T? value;
  final String Function(T) itemToString;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final bool Function(T?)? isValueSelected;

  final bool enabled;

  final double borderRadius;
  final double maxMenuHeight;

  final bool showSearchBox;
  final String? searchHint;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  bool get _hasValue =>
      widget.isValueSelected?.call(widget.value) ?? widget.value != null;

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  void _toggleDropdown(FormFieldState<T> state) {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown(state);
    }
  }

  void _openDropdown(FormFieldState<T> state) {
    FocusScope.of(context).unfocus();

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    _overlayEntry = _createOverlayEntry(renderBox.size, state);
    overlay.insert(_overlayEntry!);

    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry(
    Size targetSize,
    FormFieldState<T> state,
  ) {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Dismiss when tapping outside
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeDropdown,
                child: const SizedBox.expand(),
              ),
            ),
            // Positioned dropdown menu
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 4),
              child: _DropdownOverlayContent<T>(
                targetWidth: targetSize.width,
                items: widget.items,
                selectedItem: widget.value,
                itemToString: widget.itemToString,
                showSearchBox: widget.showSearchBox,
                searchHint: widget.searchHint ??
                    "${AppLocalizations.of(context)?.search ?? 'Search'}...",
                borderRadius: widget.borderRadius,
                maxMenuHeight: widget.maxMenuHeight,
                onSelected: (item) {
                  state.didChange(item); // Important: Update FormField value

                  widget.onChanged?.call(item); // Update GetX observable

                  _closeDropdown();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    if (_isOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color enabledColor = _hasValue
        ? Colors.green
        : (isDark ? Colors.grey[700]! : Colors.grey[300]!);

    return CompositedTransformTarget(
      link: _layerLink,
      child: FormField<T>(
        initialValue: widget.value,
        validator: widget.validator,
        builder: (FormFieldState<T> state) {
          final hasError = state.hasError;
          final borderColor = hasError
              ? Colors.red
              : (_isOpen ? const Color(0xff058240) : enabledColor);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: widget.enabled ? () => _toggleDropdown(state) : null,
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                child: InputDecorator(
                  isEmpty: !_hasValue,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    filled: true,
                    fillColor: isDark ? const Color(0xFF25282B) : Colors.white,
                    isDense: true,
                    enabled: widget.enabled,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    enabledBorder: _border(borderColor),
                    focusedBorder: _border(const Color(0xff058240)),
                    disabledBorder:
                        _border(isDark ? Colors.grey[800]! : Colors.grey[200]!),
                    errorBorder: _border(Colors.red),
                    focusedErrorBorder: _border(Colors.red),
                    labelStyle: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    suffixIcon: Icon(
                      _isOpen
                          ? Icons.arrow_drop_up_rounded
                          : Icons.arrow_drop_down_rounded,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      size: 26.sp,
                    ),
                  ),
                  child: Text(
                    _hasValue && widget.value != null
                        ? widget.itemToString(widget.value as T)
                        : widget.hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: _hasValue ? FontWeight.bold : FontWeight.w400,
                      color: _hasValue
                          ? (isDark ? Colors.white : Colors.black)
                          : (isDark ? Colors.grey[400] : Colors.grey[500]),
                    ),
                  ),
                ),
              ),
              if (hasError)
                Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 4.h),
                  child: Text(
                    state.errorText ?? '',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 11.sp,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DropdownOverlayContent<T> extends StatefulWidget {
  const _DropdownOverlayContent({
    required this.targetWidth,
    required this.items,
    required this.selectedItem,
    required this.itemToString,
    required this.showSearchBox,
    required this.searchHint,
    required this.borderRadius,
    required this.maxMenuHeight,
    required this.onSelected,
  });

  final double targetWidth;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemToString;
  final bool showSearchBox;
  final String searchHint;
  final double borderRadius;
  final double maxMenuHeight;
  final ValueChanged<T> onSelected;

  @override
  State<_DropdownOverlayContent<T>> createState() =>
      _DropdownOverlayContentState<T>();
}

class _DropdownOverlayContentState<T>
    extends State<_DropdownOverlayContent<T>> {
  late final TextEditingController _searchController;
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(covariant _DropdownOverlayContent<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _filteredItems = widget.items;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredItems = widget.items;
      } else {
        final lower = query.toLowerCase();
        _filteredItems = widget.items.where((item) {
          final str = widget.itemToString(item).toLowerCase();
          return str.contains(lower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? const Color(0xFF384046) : Colors.grey[300]!;

    return Material(
      elevation: 6,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      color: Theme.of(context).cardColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: widget.targetWidth,
          maxHeight: widget.maxMenuHeight.h,
        ),
        child: SizedBox(
          width: widget.targetWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showSearchBox)
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.searchHint,
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[500],
                        fontSize: 12.sp,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 18.sp,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius.r),
                        borderSide: const BorderSide(color: Color(0xff058240)),
                      ),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
              Flexible(
                child: _filteredItems.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          AppLocalizations.of(context)?.something_went_wrong !=
                                  null
                              ? "No data found"
                              : "No data found",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          final isSelected = widget.selectedItem == item;

                          return InkWell(
                            onTap: () => widget.onSelected(item),
                            child: Container(
                              color: isSelected
                                  ? (isDark
                                      ? Colors.white.withValues(alpha: 0.08)
                                      : Colors.grey.withValues(alpha: 0.08))
                                  : Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.itemToString(item),
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                        color: isSelected
                                            ? const Color(0xff058240)
                                            : (isDark
                                                ? Colors.white
                                                : Colors.black87),
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check,
                                      size: 16.sp,
                                      color: const Color(0xff058240),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
