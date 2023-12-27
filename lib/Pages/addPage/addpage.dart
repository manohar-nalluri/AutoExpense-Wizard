import 'package:expense_tracker/Controller/Providers/pie_chart_controller.dart';
import 'package:expense_tracker/Global/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Controller/Providers/data_display_provider.dart';
import '../../Controller/Providers/range_select_provider.dart';
import '../../Controller/db_terms.dart';
import '../../Controller/edit_tracker.dart';
import '../../Global/red_and_green.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController nlpTextController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios)),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    ExpenseTrackerSheet currentdata = ExpenseTrackerSheet();
                    currentdata.type = 'Credit';
                    editSheet(context, width, height, currentdata);
                  },
                  child: const GreenContainer(
                    children: [
                      Icon(
                        Icons.insights,
                        size: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Add Income',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ExpenseTrackerSheet currentSheet = ExpenseTrackerSheet();
                    currentSheet.type = 'Debit';
                    editSheet(context, width, height, currentSheet);
                  },
                  child: RedContainer(
                    children: [
                      const Text(
                        'Add Expense',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                        child: Transform.rotate(
                          angle: 180 * 3.1415926535 / 180,
                          child: const Icon(
                            Icons.insights,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Icon(Icons.arrow_forward_ios,size: 15,color: Colors.white,),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            SizedBox(
              width: width * 0.8,
              child: TextField(
                controller: nlpTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(32)),
                  hintText: 'Working Under Process',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> editSheet(BuildContext context, double width, double height,
      ExpenseTrackerSheet data) {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    var listToUse = data.type == 'Credit'
        ? ExpenseTrackerSheet.categeryIncome
        : ExpenseTrackerSheet.catogeryExpense;
    dateController.text = selectedDate.toString().split(' ')[0];
    String selectedCategory = '';

    return showModalBottomSheet(
        context: context,
        builder: ((context) {
          return SizedBox(
            height: height * 0.7,
            child: Scaffold(
              body: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        data.type == 'Credit'
                            ? ExpenseTrackerSheet.topIncome
                            : ExpenseTrackerSheet.topExpense,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                      child: Column(children: [
                        SizedBox(
                          width: width * 0.9,
                          child: TextFormField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                                labelText: ExpenseTrackerSheet.description),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width * 0.9,
                          child: TextFormField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                labelText: ExpenseTrackerSheet.amount),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width * 0.9,
                          child: StatefulBuilder(
                              builder: (context, StateSetter setState) {
                            return TextFormField(
                              readOnly: true,
                              controller: dateController,
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );

                                if (picked != null && picked != selectedDate) {
                                  setState(() {
                                    dateController.text =
                                        picked.toString().split(' ')[0];
                                    selectedDate = picked;
                                  });
                                }
                              },
                              decoration: const InputDecoration(
                                  labelText: ExpenseTrackerSheet.date,
                                  suffixIcon: Icon(Icons.calendar_today)),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: width * 0.05),
                                child: const Text(
                                  'Catogerys',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ))),
                        const SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(builder:
                            (statefulbuilderContext, StateSetter setState) {
                          return SizedBox(
                            width: width * 0.9,
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: listToUse
                                  .map((item) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategory = item;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: selectedCategory == item
                                                  ? Colors.black
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 8, 10, 8),
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                                color: selectedCategory == item
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        )
                      ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            if (descriptionController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.transparent,
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 0,
                                  content: CustomSnackBar(
                                      errorMsg: 'Forgot to add description'),
                                ),
                              );
                            } else if (amountController.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.transparent,
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 0,
                                  content: CustomSnackBar(
                                      errorMsg: 'Forgot to add money'),
                                ),
                              );
                            } else if (selectedCategory == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.transparent,
                                  behavior: SnackBarBehavior.floating,
                                  elevation: 0,
                                  content: CustomSnackBar(
                                      errorMsg: 'Forgot to select a catogery'),
                                ),
                              );
                            } else {
                              Map<String, dynamic> row = {
                                DBTerms.trackerColDescription:
                                    descriptionController.text,
                                DBTerms.trackerColAmount: amountController.text,
                                DBTerms.trackerColDate: dateController.text,
                                DBTerms.trackerColCategory: selectedCategory,
                                DBTerms.trackerColType: data.type,
                              };
                              // await _dbhelper.insert(row);
                              int selected =
                                  context.read<RangeSelectNotifier>().selected;
                              context
                                  .read<DataNotifer>()
                                  .insertIntoDBAndRefresh(
                                      row, selected, DateTime.now());
                              context
                                  .read<PieChartController>()
                                  .setMonthValues();
                              if (context
                                          .read<PieChartController>()
                                          .selectedMonth !=
                                      DateTime.now().month &&
                                  context
                                          .read<PieChartController>()
                                          .selectedYear !=
                                      DateTime.now().year) {
                                context
                                    .read<PieChartController>()
                                    .updateComplete();
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: data.type == 'Credit'
                              ? const GreenContainer(children: [
                                  Text(
                                    'Add Income',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ])
                              : const RedContainer(children: [
                                  Text(
                                    'Add Expense',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ])),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        }));
  }
}
