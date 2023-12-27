import 'package:expense_tracker/Controller/Providers/data_display_provider.dart';
import 'package:expense_tracker/Controller/Providers/name_tag_provider.dart';
import 'package:expense_tracker/Services/user_preference.dart';
import 'package:expense_tracker/Pages/addPage/addpage.dart';
import 'package:expense_tracker/Pages/Insightpage/insightpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controller/Providers/range_select_provider.dart';
import 'Controller/Providers/pie_chart_controller.dart';
import 'Pages/Homepage/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NameTagNotifer()),
        ChangeNotifierProvider(create: (context) => RangeSelectNotifier()),
        ChangeNotifierProvider(create: (context) =>DataNotifer()),
        ChangeNotifierProvider(create: (context) => PieChartController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
        routes: {
          '/homepage': (context) => const HomePage(),
          '/addpage': (context) => const AddPage(),
          '/insightpage': (context) => const InsightPage(),
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myindex = 0;
  List<Widget> pages = [const HomePage(), const AddPage(), const InsightPage()];
  @override
  void initState() {
    context.read<DataNotifer>().setTodayItems();
    context.read<PieChartController>().setMonthValues();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[myindex],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, blurRadius: 8, offset: Offset(0, -8))
              ]),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () => setState(() {
                            myindex = 0;
                          }),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.home,
                            size: 30,
                            color: myindex != 0 ? Colors.grey : Colors.black,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: myindex != 0 ? Colors.grey : Colors.black,
                            ),
                          ),
                        ]),
                      ))),
              Expanded(
                  flex: 1,
                  child: Transform.translate(
                    offset: const Offset(0.0, -32.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/addpage'),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () => setState(() {
                            myindex = 2;
                          }),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.insights,
                              color: myindex != 2 ? Colors.grey : Colors.black,
                              size: 30,
                            ),
                            Text(
                              'Insights',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: myindex != 2
                                      ? Colors.grey
                                      : Colors.black),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
