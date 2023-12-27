import 'package:expense_tracker/Controller/Providers/pie_chart_controller.dart';
import 'package:expense_tracker/Controller/db_terms.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Providers/data_display_provider.dart';

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
                      : Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          width: width * 0.9,
                          height: 100,
                          child: Card(
                            elevation: 6,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    // FlippingAvatar(),
                                     CircleAvatar(
                                        radius: 35,
                                        backgroundImage: AssetImage(
                                            'assets/Logos/${value.displayableItems[index]
                                              [DBTerms.trackerColCategory]}.jpg')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            value.displayableItems[index]
                                                [DBTerms.trackerColDescription],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 18),
                                          ),
                                          Text(value.displayableItems[index]
                                              [DBTerms.trackerColCategory])
                                        ]),
                                    const Spacer(),
                                    Text(
                                      '₹${value.displayableItems[index][DBTerms.trackerColAmount].toString()}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    )
                                  ],
                                ),
                                value.displayableItems[index]
                                                  [DBTerms.trackerColCategory]!="Income"?Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  // width: 100,
                                  child: Consumer<PieChartController>(
                                      builder: (context, valueOfBudget, child) {
                                   
                                    return LinearProgressIndicator(
                                      value: valueOfBudget.budget[
                                              value.displayableItems[index]
                                                  [DBTerms.trackerColCategory]]
                                          ['progress'],
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          valueOfBudget.progressColor[valueOfBudget.budget[value
                                                      .displayableItems[index]
                                                  [DBTerms.trackerColCategory]]
                                              ['progresscolor']]),
                                    );
                                  }),
                                ):const SizedBox(),
                              ],
                            ),
                          ),
                        );
                });
              }
            }),
      ),
    );
  }
}
