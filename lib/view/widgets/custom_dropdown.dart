import 'package:dropdown_search/dropdown_search.dart';
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

    // STATE
    this.enabled = true,
    this.hasError = false,
    this.errorText,

    // DIMENSIONS
    this.borderRadius = 8,
    this.maxMenuHeight = 280,

    // SEARCH
    this.showSearchBox = true,
    this.searchHint = "Search…",

    // COLORS
  });

  final List<T> items;
  final String? label;
  final String hint;
  final T? value;
  final String Function(T) itemToString;
  final ValueChanged<T?>? onChanged;
  final bool Function(T?)? isValueSelected;

  final bool enabled;
  final bool hasError;
  final String? errorText;

  final double borderRadius;
  final double maxMenuHeight;

  final bool showSearchBox;
  final String searchHint;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool get _hasValue =>
      widget.isValueSelected?.call(widget.value) ?? widget.value != null;

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color enabledColor = _hasValue ? Colors.green : Colors.grey[300]!;

    return DropdownSearch<T>(
      enabled: widget.enabled,
      items: (filter, props) => widget.items,
      selectedItem: widget.value,
      compareFn: (a, b) => a == b,
      onChanged: widget.onChanged,
      itemAsString: (item) => item == null ? "" : widget.itemToString(item),
      dropdownBuilder: (context, selectedItem) {
        final bool hasValue = selectedItem != null;

        return Text(
          hasValue ? widget.itemToString(selectedItem) : widget.hint,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: hasValue ? FontWeight.bold : FontWeight.w400,
            color: hasValue ? Colors.black : Colors.grey[500],
          ),
        );
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: widget.label,
          isDense: true,
          enabledBorder: _border(enabledColor),
          focusedBorder: _border(Colors.blue),
          errorBorder: _border(Colors.red),
          focusedErrorBorder: _border(Colors.red),
          errorText: widget.hasError ? widget.errorText : null,
          labelStyle: TextStyle(color: Colors.grey[200]),
        ),
      ),
      popupProps: PopupProps.menu(
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: widget.searchHint,
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
        showSelectedItems: true,
        showSearchBox: widget.showSearchBox,
        constraints: BoxConstraints(maxHeight: widget.maxMenuHeight),
      ),
    );
  }
}
