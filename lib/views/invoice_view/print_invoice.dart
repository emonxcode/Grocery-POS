import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/product.dart';

class PrintPage extends StatefulWidget {
  List<Product>? products;
  PrintPage({super.key, this.products});

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  BluetoothPrint _bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> _bluetoothDevices = [];
  String? _deviceMsg = "";
  final f = NumberFormat("\$###,###.00", "en_us");

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((context) {
      initPrinter();
    });
  }

  Future<void> initPrinter() async {
    _bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    if (!mounted) return;
    _bluetoothPrint.scanResults.listen((value) {
    if (!mounted) return;
    setState(() {_bluetoothDevices = value;});

      if (_bluetoothDevices.isEmpty) {
        setState(() {
          _deviceMsg = "Scanning devices...";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 254),
      appBar: AppBar(
        title: Text(
          "Select device",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 5,
        backgroundColor: Color.fromARGB(255, 234, 234, 254),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: _bluetoothDevices.isEmpty
          ? Center(
              child: Text(_deviceMsg!),
            )
          : ListView.builder(
              itemCount: _bluetoothDevices.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(_bluetoothDevices[i].name!),
                  subtitle: Text(_bluetoothDevices[i].address!),
                  onTap: () {
                    startPrint(_bluetoothDevices[i]);
                  },
                );
              },
            ),
    );
  }

  Future<void> startPrint(BluetoothDevice? device) async {
    if (device != null && device.address != null) {
      await _bluetoothPrint.connect(device);

      List<LineText> lines = [];

      lines.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "Grocery POS",
          weight: 2,
          width: 2,
          height: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ),
      );

      for (int i = 0; i < widget.products!.length; i++) {
        lines.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: widget.products![i].pName,
            width: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          ),
        );
        lines.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content:
                "${f.format(widget.products![i].pSalePrice!)} x ${f.format(widget.products![i].pQuantity!)}",
            width: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          ),
        );
      }
    }
  }
}
