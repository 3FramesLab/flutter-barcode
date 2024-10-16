import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWithFreeze extends StatefulWidget {
  const BarcodeScannerWithFreeze({super.key});

  @override
  State<BarcodeScannerWithFreeze> createState() =>
      _BarcodeScannerWithFreezeState();
}

class _BarcodeScannerWithFreezeState extends State<BarcodeScannerWithFreeze> {
  MobileScannerController mobileScannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              controller: mobileScannerController,
              onDetect: onDetect,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_nextPage, _reScan],
          )
        ],
      ),
    );
  }

  Widget get _nextPage => ElevatedButton(
        onPressed: () {
          mobileScannerController.start();
        },
        child: const Text('Next Page'),
      );

  Widget get _reScan => ElevatedButton(
        onPressed: () async {
          print('debug-print: resume scanning...');
          await mobileScannerController.resumeScanning();
          print('debug-print: resumed scanning');
        },
        child: const Text('Re-Scan'),
      );

  void onDetect(BarcodeCapture barcodeCapture) {
    print('debug-print: scanned value: ${barcodeCapture.barcodes[0].rawValue}');

    print('debug-print: stop scanning...');
    mobileScannerController.stopScanning();
    print('debug-print: stopped scanning');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobileScannerController.dispose();
    super.dispose();
  }
}
