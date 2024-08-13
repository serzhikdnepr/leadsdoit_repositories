import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/l10n.dart';
import '../../../utils/styles.dart';

class SearchWidget extends StatefulWidget {
  final Function(String text) onSearchChanged;

  const SearchWidget({super.key, required this.onSearchChanged});

  @override
  _AddCardWebViewState createState() => _AddCardWebViewState();
}

class _AddCardWebViewState extends State<SearchWidget> {
  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    focusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(() {});
    focusNode.dispose();
    _searchQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: _searchQueryController,
      maxLines: 1,
      autofocus: false,
      style: searchStyle,
      onChanged: (value) {
        widget.onSearchChanged(value);
        setState(() {});
      },
      decoration: inputDecoration(
          S.of(context).search,
          focusNode.hasFocus,
          _searchQueryController.text.isNotEmpty
              ? () {
                  _searchQueryController.text = "";
                  widget.onSearchChanged("");
                  setState(() {});
                }
              : null),
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(128),
      ],
    );
  }
}
