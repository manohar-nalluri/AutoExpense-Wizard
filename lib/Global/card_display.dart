import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/Providers/data_display_provider.dart';
import '../Controller/Providers/pie_chart_controller.dart';
import '../Controller/db_terms.dart';

Container cardDisplay(double width, DataNotifer value, int index, bool wizard) {
  late var data;
  if (wizard) {
    data = value.wizardItems;
  } else {
    data = value.displayableItems;
  }
  return Container(
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
                      'assets/Logos/${data[index][DBTerms.trackerColCategory]}.jpg')),
              const SizedBox(
                width: 10,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      data[index][DBTerms.trackerColDescription],
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 18),
                    ),
                    Text(data[index][DBTerms.trackerColCategory])
                  ]),
              const Spacer(),
              Text(
                '₹${data[index][DBTerms.trackerColAmount].toString()}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                width: 14,
              )
            ],
          ),
          data[index][DBTerms.trackerColCategory] != "Income"
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  // width: 100,
                  child: Consumer<PieChartController>(
                      builder: (context, valueOfBudget, child) {
                    return LinearProgressIndicator(
                      value: valueOfBudget
                              .budget[data[index][DBTerms.trackerColCategory]]
                          ['progress'],
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(valueOfBudget
                          .progressColor[valueOfBudget
                              .budget[data[index][DBTerms.trackerColCategory]]
                          ['progresscolor']]),
                    );
                  }),
                )
              : const SizedBox(),
        ],
      ),
    ),
  );
}
