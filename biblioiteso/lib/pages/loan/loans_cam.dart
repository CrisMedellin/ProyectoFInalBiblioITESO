import 'package:biblioiteso/pages/loan/Bloc/loans/loans_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class LoansCamera extends StatefulWidget {
  LoansCamera({
    Key? key,
  }) : super(key: key);

  @override
  State<LoansCamera> createState() => _CameraState();
}

class _CameraState extends State<LoansCamera> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  QRViewController? controller;

  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final LoanBloc = BlocProvider.of<LoansBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: QRView(
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderWidth: 3.0,
                    overlayColor: const Color.fromRGBO(0, 0, 0, 80),
                    borderRadius: 15,
                    borderLength: 40,
                  ),
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? FloatingActionButton(
                    onPressed: () {
                      LoanBloc.add(UpdateBookToReturnEvent(bookToReturn: result!.code.toString()));
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.save),
                  )
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
