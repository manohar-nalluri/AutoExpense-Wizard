import 'package:expense_tracker/Controller/contorller_global_export.dart';
import 'package:expense_tracker/Controller/Providers/pie_chart_controller.dart';
import 'package:flutter/material.dart';

Future showYearPicker(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          content: SizedBox(
              height: 300,
              width: 300,
              child: YearPicker(
                  firstDate: DateTime.parse('20000101'),
                  lastDate: DateTime.parse('20991201'),
                  selectedDate: DateTime.now(),
                  onChanged: (date) {
                    context
                        .read<PieChartController>()
                        .setSelectedYear(date.year);
                    Navigator.pop(context);
                  })),
        );
      });
}
