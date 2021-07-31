import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:openfoodfacts/model/IngredientsAnalysisTags.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:workify/controllers/authServices.dart';
import 'package:workify/theme/theme.dart';
import 'package:workify/views/mealPlan/productOverview.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  //! set this to false if you want to scan in barcodes.
  bool debug = true;

  Map veganScore = {
    VeganStatus.VEGAN: "Vegan",
    VeganStatus.MAYBE_VEGAN: "Maybe",
    VeganStatus.NON_VEGAN: "Non-Vegan",
    VeganStatus.VEGAN_STATUS_UNKNOWN: "Unknown",
  };

  ProductResult? productResult;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Map nutrientsScoreColor = {
    'a': Colors.green,
    'b': Colors.green.shade200,
    'c': Colors.yellow.shade200,
    'd': Colors.yellow,
    'e': Colors.red,
  };

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  List<Color> novaScoreColor = [
    Colors.green,
    Colors.green.shade400,
    Colors.yellow.shade400,
    Colors.red,
  ];
  List<Color> goodBadScore = [Colors.red, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'QR CODE SCANNER',
            style: TextStyle(
              color: Apptheme.mainButonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              LineIcons.arrowLeft,
              color: Colors.black,
            ),
          ),
          backgroundColor: Apptheme.mainCardColor,
        ),
        body: SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * .7,
          minHeight: AppBar().preferredSize.height + 10,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.0),
            topRight: Radius.circular(18.0),
          ),
          panel: productResult != null
              ? ProductOverView(product: productResult!.product!)
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: SizedBox(height: 5),
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.3),
                            borderRadius: BorderRadius.circular(24.0),
                            boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Scan In a Product Barcode'),
                  ],
                ),
          body: _buildQrView(context),
        ));
  }

  Column productScoreCircle({score: String, scoreTitle: String, color: Colors}) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 30,
          backgroundColor: color,
          child: score == null
              ? Text(
                  '?',
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  '${score}',
                  textScaleFactor: score.toString().length > 4 ? .8 : 1,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
        SizedBox(height: 5),
        RichText(
          textAlign: TextAlign.center,
          maxLines: 2,
          softWrap: true,
          textScaleFactor: .8,
          text: TextSpan(
            text: '$scoreTitle',
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[],
          ),
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      getProductResult(qrCode: '0049022861954');
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
        getProductResult(qrCode: scanData.code);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<ProductResult?> getProductResult({qrCode: String}) async {
    log('starting ===================== OPENAPITRACK');
    String resultString = qrCode;
    var newProductResult = await OpenFoodAPIClient.getProduct(ProductQueryConfiguration(resultString, language: OpenFoodFactsLanguage.ENGLISH, fields: [ProductField.ALL]));

    log('ending ===================== OPENAPITRACK');

    if (newProductResult == 1) {
      print("Error retreiving the product : ${productResult!.status}");
      return newProductResult;
    } else {
      setState(() {
        productResult = newProductResult;
      });
      sendProductResults();
      return newProductResult;
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  sendProductResults() async {
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(AuthServices.userUID)
        .collection('UserAddedProduct')
        .doc(productResult!.product!.productName)
        .set(productResult!.product!.toData())
        .then(
          (value) => FirebaseFirestore.instance
              .collection('UserInfo')
              .doc(AuthServices.userUID)
              .collection('UserAddedProduct')
              .doc(productResult!.product!.productName)
              .update(productResult!.product!.nutriments!.toData()),
        );
  }

  productDetailsSmallCardList({listQuerry: List, title: String}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          listQuerry != null
              ? Container(
                  child: Wrap(
                    children: listQuerry
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.fromLTRB(2, 2, 0, 0),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Apptheme.secondaryAccent,
                              ),
                              child: Text(
                                '${item}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                        .toList()
                        .cast<Widget>(),
                  ),
                )
              : Text('No $title found'),
        ],
      ),
    );
  }
}
