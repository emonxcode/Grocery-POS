import 'package:flutter/material.dart';
import 'package:grocery_pos/controller/salesController.dart';
import 'package:grocery_pos/models/sale.dart';
import 'package:grocery_pos/views/mobile/reports/bloc/report_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliver_bar_chart/sliver_bar_chart.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  ReportBloc reportBloc = ReportBloc();
  final ScrollController _scrollController = ScrollController();
  late final List<BarChartData> _barValues;
  List<Sale> sales = [];

  int? totalSaleToday = 0;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    await reportBloc.fetchSalesList();
    sales = reportBloc.salesList;
    _recentTrasactions;
  }

  List<Sale> get _recentTrasactions {
    var listOfRecentTx;

    listOfRecentTx = sales.where((tx) {
      return DateTime.parse(tx.saleDate!)
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();

    return listOfRecentTx;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 11,
        child: StreamBuilder<int>(
            stream: reportBloc.totalSalesStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                padding: EdgeInsets.all(5),
                                child: Chart(_recentTrasactions),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                height: 150,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 130,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            //  color: Colors.green,
                                            border: Border(
                                              top: BorderSide(
                                                  width: 8,
                                                  color: Colors.green),
                                              bottom: BorderSide(
                                                  width: 8,
                                                  color: Colors.green),
                                              left: BorderSide(
                                                  width: 8,
                                                  color: Colors.green),
                                              right: BorderSide(
                                                  width: 8,
                                                  color: Colors.green),
                                            ),

                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "TK",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "TOTAL",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "SALES",
                                              style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "TODAY",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    // SizedBox(height: 8),
                                    // GestureDetector(
                                    //   onTap: () {},
                                    //   child: Container(
                                    //     height: 40,
                                    //     width: double.infinity,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(30),
                                    //       color: Colors.green,
                                    //     ),
                                    //     child: Center(
                                    //         child: Text(
                                    //       "Show full sales history",
                                    //       style: TextStyle(
                                    //           fontSize: 20,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.white),
                                    //     )),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("All Sales ::"),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.64,
                              child: ListView.builder(
                                itemCount: sales.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 4,
                                    child: ListTile(
                                      title:
                                          Text(sales[index].saleProductList!),
                                      subtitle: Row(
                                        children: [
                                          Text("Amount :: " +
                                              sales[index]
                                                  .saleTotalAmount
                                                  .toString()),
                                          Spacer(),
                                          Text("Date :: " +
                                              DateFormat("dd/MM/yyy  HH:mm:ss")
                                                  .format(DateTime.parse(
                                                      sales[index].saleDate!))),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text("Loading..."),
                    );
            }));
  }
}

class Chart extends StatelessWidget {
  List<Sale> recentTransactions;
  Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      DateTime weekDay = DateTime.now().subtract(Duration(
          days: index)); // 0 index means today and 1,2,3... is previous days

      var totalSum = 0.0;
      // start a loop of transactions then filter specific days transactions and add sum value of filterd trans.
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].saleTotalAmount != null) {
          if (DateTime.parse(recentTransactions[i].saleDate!).day ==
                  weekDay.day &&
              DateTime.parse(recentTransactions[i].saleDate!).month ==
                  weekDay.month &&
              DateTime.parse(recentTransactions[i].saleDate!).year ==
                  weekDay.year) {
            totalSum += recentTransactions[i].saleTotalAmount!;
          }
        }
      }
      return {'day': DateFormat('E').format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, item) {
      return previousValue + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'].toString(),
                  totalSpending: (data['amount'] as double),
                  totalPerchantageOfSpending: maxSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / maxSpending,
                ),
              );
            }).toList(),
          )),
    );
  }
}

class ChartBar extends StatelessWidget {
  final String? label;
  final double? totalSpending;
  final double? totalPerchantageOfSpending;

  ChartBar({this.label, this.totalSpending, this.totalPerchantageOfSpending});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(
                child: Text("\$${totalSpending!.toStringAsFixed(0)}")),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 20,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    //border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(6),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: constraints.maxHeight * 0.6,
                    width: 20,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: totalPerchantageOfSpending,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            // child: FittedBox(child: Text(label!)),
            child: Text(label!, style: TextStyle(fontSize: 18)),
          ),
        ],
      );
    });
  }
}
