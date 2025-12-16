import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown({
    super.key,

    // REQUIRED
    required this.items,
    required this.label,
    required this.hint,
    required this.itemToString,

    // VALUE
    this.value,
    this.onChanged,
    this.isValueSelected,

    // UI
    this.leadingBuilder,

    // STATE
    this.enabled = true,
    this.hasError = false,
    this.errorText,

    // DIMENSIONS
    this.height = 48,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.contentPadding = const EdgeInsets.symmetric(vertical: 4),
    this.maxMenuHeight = 280,

    // SEARCH
    this.showSearchBox = true,
    this.searchHint = "Search…",

    // COLORS
    this.primaryColor = const Color(0xFF3B82F6),
    this.successColor = const Color(0xFF22C55E),
    this.borderColor = const Color(0xFFD1D5DB),
    this.errorColor = const Color(0xFFEF4444),
    this.textColor = const Color(0xFF111827),
    this.mutedColor = const Color(0xFF6B7280),
    this.backgroundColor = Colors.white,

    // TEXT
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  });

  final List<T> items;
  final String label;
  final String hint;
  final T? value;
  final String Function(T) itemToString;
  final ValueChanged<T?>? onChanged;
  final bool Function(T?)? isValueSelected;

  final Widget? Function(T item)? leadingBuilder;

  final bool enabled;
  final bool hasError;
  final String? errorText;

  final double height;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final double maxMenuHeight;

  final bool showSearchBox;
  final String searchHint;

  final Color primaryColor;
  final Color successColor;
  final Color borderColor;
  final Color errorColor;
  final Color textColor;
  final Color mutedColor;
  final Color backgroundColor;

  final TextStyle textStyle;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool _open = false;

  bool _isSelected(T item) => widget.value == item;

  Color _borderColor(bool hasValue) {
    if (widget.hasError) return widget.errorColor;
    if (_open) return widget.primaryColor;
    if (hasValue) return widget.successColor;
    return widget.borderColor;
  }

  /// ✅ GUARANTEED visible glow
  List<BoxShadow> _glow(bool hasValue) {
    if (widget.hasError) {
      return [
        // BoxShadow(
        //   color: widget.errorColor.withOpacity(0.35),
        //   blurRadius: 0.5,
        //   spreadRadius: 3,
        // ),
      ];
    }

    if (_open) {
      return [
        BoxShadow(
          color: widget.primaryColor.withOpacity(0.35),
          blurRadius: 0.5,
          spreadRadius: 3,
        ),
      ];
    } else {
      return [];
    }

    if (hasValue) {
      return [
        // BoxShadow(
        //   color: widget.successColor.withOpacity(0.30),
        //   blurRadius: 0.5,
        //   spreadRadius: 3,
        // ),
      ];
    }

    // 🩶 DEFAULT / HINT glow (FIXED)
    return [
      // BoxShadow(
      //   color: Colors.black.withOpacity(0.08),
      //   blurRadius: 0.5,
      //   spreadRadius: 3,
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue =
        widget.isValueSelected?.call(widget.value) ?? widget.value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSearch<T>(
          enabled: widget.enabled,
          items: (filter, props) => widget.items,
          selectedItem: widget.value,
          compareFn: (a, b) => a == b,
          onChanged: widget.onChanged,
          itemAsString: (item) => item == null ? "" : widget.itemToString(item),
          decoratorProps: const DropDownDecoratorProps(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          suffixProps: const DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(isVisible: false),
          ),
          dropdownBuilder: (context, selected) {
            final text =
                selected != null ? widget.itemToString(selected) : widget.hint;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                height: widget.height,
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: _borderColor(hasValue),
                    width: 2,
                  ),
                  boxShadow: _glow(hasValue),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: widget.contentPadding,
                        child: Text(
                          text,
                          overflow: TextOverflow.ellipsis,
                          style: widget.textStyle.copyWith(
                            color: selected != null
                                ? widget.textColor
                                : widget.mutedColor,
                          ),
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 160),
                      turns: _open ? 0.5 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: widget.hasError
                            ? widget.errorColor
                            : widget.mutedColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          popupProps: PopupProps.menu(
            showSearchBox: widget.showSearchBox,
            constraints: BoxConstraints(maxHeight: widget.maxMenuHeight),
          ),
          onBeforePopupOpening: (_) {
            setState(() => _open = true);
            return Future.value(true);
          },
          onBeforeChange: (_, __) {
            setState(() => _open = false);
            return Future.value(true);
          },
        ),
        if (widget.hasError && widget.errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: widget.errorColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
