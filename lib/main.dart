import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(SidebarXExampleApp());
}

class SidebarXExampleApp extends StatelessWidget {
  SidebarXExampleApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beez POS Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: Text(_getTitleByIndex(_controller.selectedIndex)),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.white.withOpacity(0.7))),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: Text(extended ? "Beez POS Admin" : "Beez",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 20),
              )),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.dashboard,
          label: 'Dashboard',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.home_mini,
          label: 'Products',
        ),
        const SidebarXItem(
          icon: Icons.card_giftcard,
          label: 'Orders',
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;
  List<Map<String, String>> data = [
    {
      "title": "Orders",
      "count": "52",
    },
    {
      "title": "Sales",
      "count": "₹ 4598",
    },
    {
      "title": "Payment-upi",
      "count": "43",
    },
    {
      "title": "Payment-cash",
      "count": "6",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                              ),
                              border: Border.all(color: white)),
                          child: Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: "Search",
                                  hintStyle: GoogleFonts.lato(
                                      textStyle: const TextStyle(color: white)),
                                  suffixIcon: const Icon(
                                    Icons.search,
                                    color: white,
                                  )),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                tooltip: 'Profile',
                                icon: const Icon(
                                  Icons.person_3_rounded,
                                  color: white,
                                )),
                            IconButton(
                                onPressed: () {},
                                tooltip: 'Dark mode',
                                icon: const Icon(
                                  Icons.dark_mode,
                                  color: white,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  divider,
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.2,
                          margin: const EdgeInsets.only(
                              bottom: 10, right: 10, left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).canvasColor,
                            boxShadow: const [BoxShadow()],
                          ),
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      data[index]['title']
                                          .toString()
                                          .toUpperCase(),
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            color: white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: white,
                                      ),
                                      Text(
                                        "20 %",
                                        style: GoogleFonts.lato(
                                            textStyle:
                                                const TextStyle(color: white)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    child: Text(data[index]['count'].toString(),
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("View all orders",
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                          color: white,
                                          fontSize: 13,
                                        ),
                                      )),
                                  const Icon(
                                    Icons.shopping_cart_checkout_outlined,
                                    color: white,
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 5),
                          width: MediaQuery.of(context).size.width * 0.34,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).canvasColor,
                            boxShadow: const [BoxShadow()],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Revenue",
                                      style: GoogleFonts.lato(
                                        textStyle: const TextStyle(
                                            color: white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  const Icon(
                                    Icons.more_vert,
                                    color: white,
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                child: CircularPercentIndicator(
                                  radius: 55.0,
                                  lineWidth: 5.0,
                                  percent: 0.70,
                                  center: const Text(
                                    "70%",
                                    style:
                                        TextStyle(color: white, fontSize: 17),
                                  ),
                                  progressColor: Colors.orange,
                                ),
                              ),
                              Text("Total sales made today",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      color: white,
                                      fontSize: 16,
                                    ),
                                  )),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "₹ 459",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.27,
                                child: Text(
                                  "Previous transactions processing , latest transactions may not be included.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                          color: white, fontSize: 13)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text("Yesterday",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.keyboard_arrow_up,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            "₹ 759",
                                            style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                    color: Colors.green)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Last Week",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.keyboard_arrow_up,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            "₹ 2400",
                                            style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                    color: Colors.green)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Last Month",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            "₹ 7759",
                                            style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                    color: Colors.red)),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.49,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).canvasColor,
                            boxShadow: const [BoxShadow()],
                          ),
                          child: SfSparkLineChart(
                            lowPointColor: white,
                            //Enable the trackball
                            trackball: const SparkChartTrackball(
                                activationMode: SparkChartActivationMode.tap),
                            //Enable marker
                            marker: const SparkChartMarker(
                                displayMode: SparkChartMarkerDisplayMode.all),
                            //Enable data label
                            labelDisplayMode: SparkChartLabelDisplayMode.all,
                            data: const <double>[
                              1,
                              5,
                              -6,
                              0,
                              1,
                              -2,
                              7,
                              -7,
                              -4,
                              -10,
                              13,
                              -6,
                              7,
                              5,
                              11,
                              5,
                              3
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.83,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).canvasColor,
                      boxShadow: const [BoxShadow()],
                    ),
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Latest Transactions',
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      color: white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                        DataTable(columns: [
                          DataColumn(
                            label: Text(
                              'Bill No',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(color: white)),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Quantity',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(color: white)),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Date',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(color: white)),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(color: white)),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Payment Method',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(color: white)),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Payment Status',
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(color: white)),
                            ),
                          ),
                        ], rows: [
                          for (int i = 0; i < 5; i++)
                            DataRow(cells: [
                              DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  '1',
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(color: white)),
                                ),
                              )),
                              DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  '10',
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(color: white)),
                                ),
                              )),
                              DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  DateTime.now().toString(),
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(color: white)),
                                ),
                              )),
                              DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  '865\$',
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(color: white)),
                                ),
                              )),
                              DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  'CASH',
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(color: white)),
                                ),
                              )),
                              DataCell(SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(
                                  'Paid',
                                  style: GoogleFonts.lato(
                                      textStyle: const TextStyle(color: white)),
                                ),
                              )),
                            ]),
                        ])
                      ],
                    ),
                  )
                ],
              ),
            );

          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Products';
    case 2:
      return 'Orders';
    case 3:
      return 'Favorites';
    case 4:
      return 'Custom iconWidget';
    case 5:
      return 'Profile';
    case 6:
      return 'Settings';
    default:
      return 'Not found page';
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
