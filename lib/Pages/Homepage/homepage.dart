import 'package:expense_tracker/Pages/Homepage/data_shower.dart';
import 'package:expense_tracker/Pages/Homepage/name_tag_changer.dart';
import 'package:expense_tracker/Pages/Homepage/range_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Providers/data_display_provider.dart';
import '../../Controller/Providers/name_tag_provider.dart';
import '../../Controller/Providers/range_select_provider.dart';

class HomePage extends StatelessWidget {
 const HomePage({super.key});



  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        //Profile picture Good mrng Text
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            // Icon(Icons.person),
            Consumer<NameTagNotifer>(builder: (context, value, child) {
              return GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return const NameTagChanger();
                      }),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/ProfilePic/${value.pic}.jpg'),
                    radius: 40,
                  ));
            }),

            const SizedBox(width: 20),
            Consumer<NameTagNotifer>(builder: (context, value, child) {
              return Expanded(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Good Morning,${value.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Text(
                      'Track Your Expensed on the go',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              );
            })
          ],
        ),

        const SizedBox(
          height: 20,
        ),
        //Date selector
        Consumer<RangeSelectNotifier>(builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () => {
                        value.setSelected(0),
                        context.read<DataNotifer>().setTodayItems(),
                      },
                  child: const RangeDisplay(
                    index: 0,
                  )),
              GestureDetector(
                  onTap: () => {
                        value.setSelected(1),
                        context.read<DataNotifer>().setThisWeekItems(),
                      },
                  child: const RangeDisplay(
                    index: 1,
                  )),
              GestureDetector(
                  onTap: () => {
                        value.setSelected(2),
                        context.read<DataNotifer>().setThisMonthItems()
                      },
                  child: const RangeDisplay(
                    index: 2,
                  )),
              Consumer<DataNotifer>(
                  builder: (context, valueOfDataNotifier, child) {
                return GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: valueOfDataNotifier.selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        {
                          value.setSelected(3);
                          valueOfDataNotifier.setSelectedDate(picked);
                        }
                      }
                    },
                    child: const RangeDisplay(
                      index: 3,
                    ));
              }),
            ],
          );
        }),

        const SizedBox(
          height: 30,
        ),
        //

        Container(
          width: width * 0.9,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(18)),
          child: Center(
            child: Consumer<DataNotifer>(builder: (context, value, child) {
              return Text(
                '₹${value.totalAmount.toString()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
                maxLines: 1,
                overflow: TextOverflow.visible,
              );
            }),
          ),
        ),

        //
        const SizedBox(
          height: 30,
        ),
        //Date
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            Consumer<RangeSelectNotifier>(builder: (context, value, child) {
              return Consumer<DataNotifer>(
                builder: (context,valueOfDataNotifier,child) {
                  return Text(
                    valueOfDataNotifier.displayFormattedDates[value.selected],
                    style:
                        const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  );
                }
              );
            }),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const DataShower(),
      ],
    );
  }
}
