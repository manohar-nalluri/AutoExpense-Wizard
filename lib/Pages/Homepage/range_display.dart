import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Providers/range_select_provider.dart';

class RangeDisplay extends StatelessWidget {
  final int index;
  const RangeDisplay({
    required this.index,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RangeSelectNotifier>(
      builder: (context,value,child) {
        return Container(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
                color: value.selected == index ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black45)),
            child: Text(
              value.selectedText[index],
              style:
                  TextStyle(color: value.selected == index ? Colors.white : Colors.black),
            ));
      }
    );
  }
}
