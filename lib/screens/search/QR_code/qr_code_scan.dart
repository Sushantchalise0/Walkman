// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRCodeScan extends StatefulWidget {
//   @override
//   _QRCodeScanState createState() => _QRCodeScanState();
// }

// class _QRCodeScanState extends State<QRCodeScan> {
//   var qrText = '';
//   QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scan QR Code'),
//         centerTitle: true,
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Expanded(
//               flex: 5,
//               child: QRView(
//                 key: qrKey,
//                 overlay: QrScannerOverlayShape(
//                     overlayColor: Colors.grey,
//                     borderRadius: 10,
//                     borderColor: Colors.green,
//                     borderLength: 30,
//                     borderWidth: 10,
//                     cutOutSize: 300),
//                 onQRViewCreated: _onQRViewCreated,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     if (controller != null) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }
