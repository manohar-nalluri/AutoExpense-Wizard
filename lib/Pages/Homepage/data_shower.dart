import 'package:expense_tracker/Controller/Providers/pie_chart_controller.dart';
import 'package:expense_tracker/Controller/db_terms.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Providers/data_display_provider.dart';
import '../../Global/card_display.dart';

class DataShower extends StatelessWidget {
  const DataShower({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: width * 0.9,
        child: ListView.builder(
            itemCount: context.watch<DataNotifer>().displayableItemsLength + 1,
            itemBuilder: (context, index) {
              if (context.read<DataNotifer>().displayableItemsLength == 0) {
                return const Center(
                  child: Text('No Records Founds',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),),
                );
              } else {
                return Consumer<DataNotifer>(builder: (builder, value, child) {
                  return index == value.displayableItemsLength
                      ? const SizedBox(
                          height: 28,
                        )
                      : cardDisplay(width, value, index,false);
                });
              }
            }),
      ),
    );
  }
}
