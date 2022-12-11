import 'package:flutter/material.dart';
import 'package:sliver_bar_chart/sliver_bar_chart.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final ScrollController _scrollController = ScrollController();
  late final List<BarChartData> _barValues;

  final double _minHeight = AppBar().preferredSize.height;
  final double _xAxisTextRotationAngle = 180.0;
  final int _yAxisIntervalCount = 8;
  double _maxHeight = 200.0;
  double _maxWidth = 5.0;

  final bool _restrain = true;
  final bool _fluctuating = false;
  bool _isScrolling = true;

  final int _sliverListChildCount = 20;

  @override
  void initState() {
    super.initState();
    _setupBarChartValues();

    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset.roundToDouble() < 100.0) {
          _maxHeight = 500.0;
          _maxWidth = 10.0;
          _isScrolling = true;
        } else {
          if (_scrollController.offset.roundToDouble() >= 400.0) {
            _maxWidth = _scrollController.offset - 10;
          }
          _isScrolling = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 11,
      child: Container(
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
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverBarChart(
                        scrolling: false,
                        restrain: _restrain,
                        fluctuating: _fluctuating,
                        minHeight: 0,
                        maxHeight: 200,
                        maxWidth: _maxWidth,
                        barWidget: BarChartWidget(
                          maxHeight: 200,
                          minHeight: 0,
                          barValues: _barValues,
                          isScrolling: _isScrolling,
                          yAxisIntervalCount: _yAxisIntervalCount,
                          xAxisTextRotationAngle: _xAxisTextRotationAngle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              //  color: Colors.green,
                              border: Border(
                                top: BorderSide(width: 5, color: Colors.green),
                                bottom:
                                    BorderSide(width: 5, color: Colors.green),
                                left: BorderSide(width: 5, color: Colors.green),
                                right:
                                    BorderSide(width: 5, color: Colors.green),
                              ),

                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "9025",
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
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green,
                          ),
                          child: Center(
                              child: Text(
                            "Show full sales history",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setupBarChartValues() {
    _barValues = [
      BarChartData(
        x: 'Sat',
        y: 770.0,
        barColor: Colors.green,
      ),
      BarChartData(
        x: 'Sun',
        y: 340.0,
        barColor: Colors.green,
      ),
      BarChartData(
        x: 'MOn',
        y: 1000.0,
        barColor: Colors.green,
      ),
      BarChartData(
        x: 'Tue',
        y: 100.0,
        barColor: Colors.green,
      ),
      BarChartData(
        x: 'Wed',
        y: 650.0,
        barColor: Colors.green,
      ),
      BarChartData(
        x: 'Thu',
        y: 200.0,
        barColor: Colors.green,
      ),
      BarChartData(
        x: 'Fri',
        y: 450.0,
        barColor: Colors.green,
      ),
    ];
  }
}
