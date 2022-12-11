import 'package:flutter/material.dart';
class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 14,
      child: Container(color: Colors.blue),
    );
  }
}