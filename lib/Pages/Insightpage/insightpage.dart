
import 'package:expense_tracker/Controller/contorller_global_export.dart';
import 'package:expense_tracker/Controller/Providers/pie_chart_controller.dart';
import 'package:expense_tracker/Global/red_and_green.dart';
import 'package:expense_tracker/Pages/Insightpage/show_year_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Global/custom_snackbar.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final List<String> year = [
    'Jan',
    "Feb",
    'Mar',
    "Apr",
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController amountController = TextEditingController();
    String selectedCategory = '';
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              showYearPicker(context);
            },
            child: Row(
              children: [
                Consumer<PieChartController>(builder: (context, value, child) {
                  return Text(value.selectedYear.toString());
                }),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: ((context) {
                    return SizedBox(
                        height: height * 0.6,
                        child: Scaffold(
                          body: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                const Text(
                                  'Add Budget',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Icon(Icons.cancel_rounded)),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                              ],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: width * 0.9,
                                      child: TextFormField(
                                        controller: amountController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                            labelText:
                                                ExpenseTrackerSheet.amount),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    StatefulBuilder(builder:
                                        (statefulbuilderContext,
                                            StateSetter setState) {
                                      return SizedBox(
                                        width: width * 0.9,
                                        child: Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: ExpenseTrackerSheet
                                              .catogeryExpense
                                              .map((item) => GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedCategory = item;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              selectedCategory ==
                                                                      item
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 8, 10, 8),
                                                      child: Text(
                                                        item,
                                                        style: TextStyle(
                                                            color:
                                                                selectedCategory ==
                                                                        item
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (amountController.text == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.transparent,
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 0,
                                      content: CustomSnackBar(
                                          errorMsg: 'Forgot to Add money'),
                                    ),
                                  );
                                } else if (selectedCategory == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.transparent,
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 0,
                                      content: CustomSnackBar(
                                          errorMsg:
                                              'Forgot to select a catogery'),
                                    ),
                                  );
                                } else {
                                  context.read<PieChartController>().setBudget(
                                      selectedCategory,
                                      int.parse(amountController.text));
                                  Navigator.pop(context);
                                }
                              },
                              child: const RedContainer(children: [
                                Text('Add Budget',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ]),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ]),
                        ));
                  }));
            },
            child: const RedContainer(children: [
              Text('Add Budget',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500))
            ]),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      const SizedBox(
        height: 20,
      ),
      //Months
      SizedBox(
        height: 50,
        child: Center(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: year.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () => context
                    .read<PieChartController>()
                    .setSelectedMonth(index + 1),
                child: Consumer<PieChartController>(
                    builder: (context, value, child) {
                  return Container(
                    width: 60,
                    height: 30,
                    margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    decoration: BoxDecoration(
                        color: value.selectedMonth - 1 == index
                            ? Colors.black
                            : Colors.white,
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      year[index],
                      style: TextStyle(
                          color: value.selectedMonth - 1 == index
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16),
                    )),
                  );
                }),
              );
            }),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      //Pie-Chart
      Consumer<PieChartController>(builder: (context, value, child) {
        return SizedBox(
          height: 300,
          child: value.hasValues == true
              ? PieChart(
                  PieChartData(
                    sections: value.catogeryExpense.entries
                        .map<PieChartSectionData>((key) {
                      return PieChartSectionData(
                          value: (key.value['value']).toDouble(),
                          color: value.color[key.value["color"]]);
                    }).toList(),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 750),
                  swapAnimationCurve: Curves.easeInOutQuint,
                )
              : const Text(
                  'No data available',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                ),
        );
      }),
      const SizedBox(
        height: 20,
      ),

      //Budget and Category Details
      Expanded(
          child: Consumer<PieChartController>(builder: (context, value, child) {
        var keys = value.catogeryExpense.keys.toList();
        return value.hasValues == true?ListView.builder(
            itemCount: value.catogeryExpense.length,
            itemBuilder: ((BuildContext context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        color: value.color[value.catogeryExpense[keys[index]]['color']],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        keys[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '     -Used ${value.catogeryExpense[keys[index]]['value']} of BUDGET:${value.catogeryExpense[keys[index]]['budget'] == -1 ? 'Infinite' : value.catogeryExpense[keys[index]]['budget']}',
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            })):const SizedBox();
      })),
      const SizedBox(
        height: 20,
      )
    ]);
  }
}
