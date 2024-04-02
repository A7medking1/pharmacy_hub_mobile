import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pharmacy_hub/src/core/payment_service/paypal/paypal_service.dart';

class PaypalCheckoutView extends StatefulWidget {
  final Function onSuccess, onCancel, onError;
  final String? note, clientId, secretKey;

  final Widget? loadingIndicator;
  final List? transactions;
  final bool? sandboxMode;

  const PaypalCheckoutView({
    super.key,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    required this.transactions,
    required this.clientId,
    required this.secretKey,
    this.sandboxMode = true,
    this.note = '',
    this.loadingIndicator,
  });

  @override
  State<StatefulWidget> createState() {
    return PaypalCheckoutViewState();
  }
}

class PaypalCheckoutViewState extends State<PaypalCheckoutView> {
  String? checkoutUrl;
  String navUrl = '';
  String executeUrl = '';
  String accessToken = '';
  bool loading = true;
  bool pageLoading = true;
  bool loadingError = false;
  late PaypalServices services;
  int pressed = 0;
  double progress = 0;
  final String returnURL = 'https://www.youtube.com';
  final String cancelURL = 'https://www.facebook.com';

  late InAppWebViewController webView;

  Map getOrderParams() {
    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": widget.transactions,
      "note_to_payer": widget.note,
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  void initState() {
    services = PaypalServices(
      sandboxMode: widget.sandboxMode!,
      clientId: widget.clientId!,
      secretKey: widget.secretKey!,
    );

    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        Map getToken = await services.getAccessToken();

        if (getToken['token'] != null) {
          accessToken = getToken['token'];
          final body = getOrderParams();
          final res = await services.createPaypalPayment(body, accessToken);

          if (res["approvalUrl"] != null) {
            setState(() {
              checkoutUrl = res["approvalUrl"];
              executeUrl = res["executeUrl"];
            });
          } else {
            widget.onError(res);
          }
        } else {
          widget.onError("${getToken['message']}");
        }
      } catch (e) {
        widget.onError(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Paypal Payment",
          ),
        ),
        body: Stack(
          children: <Widget>[
            InAppWebView(
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final url = navigationAction.request.url;

                if (url.toString().contains(returnURL)) {
                  executePayment(url, context);
                  return NavigationActionPolicy.CANCEL;
                }
                if (url.toString().contains(cancelURL)) {
                  return NavigationActionPolicy.CANCEL;
                } else {
                  return NavigationActionPolicy.ALLOW;
                }
              },
              initialUrlRequest: URLRequest(url: WebUri(checkoutUrl!)),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onCloseWindow: (InAppWebViewController controller) {
                widget.onCancel();
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
            progress < 1
                ? SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      value: progress,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Paypal Payment",
          ),
        ),
        body: Center(
            child:
                widget.loadingIndicator ?? const CircularProgressIndicator()),
      );
    }
  }

  void executePayment(Uri? url, BuildContext context) {
    final payerID = url!.queryParameters['PayerID'];
    if (payerID != null) {
      services.executePayment(executeUrl, payerID, accessToken).then(
        (id) {
          if (id['error'] == false) {
            widget.onSuccess(id);
          } else {
            widget.onError(id);
          }
        },
      );
    } else {
      widget.onError('Something went wront PayerID == null');
    }
  }
}

/*

Navigator.of(context).push(MaterialPageRoute(
builder: (BuildContext context) => PaypalCheckoutView(
clientId:
"AaLQ7pM6-3U4_Ne33WnfUm0ydlYGGRwf4NMUZGcbflClqQIukbN3im_Cwt8opDfcke7py_V-FfIouo8Y",
secretKey:
"ELaGyXNG7bnNDg7LBtenWZiMPELUQEitSxgyf5MbS25mJrZJw-3O3GX4Eu9as0tcQtssPXhFtyQ9sq2d",
transactions: const [
{
"amount": {
"total": '100',
"currency": "USD",
"details": {
"subtotal": '100',
"shipping": '0',
"shipping_discount": 0
}
},
"description": "The payment transaction description.",
// "payment_options": {
//   "allowed_payment_method":
//       "INSTANT_FUNDING_SOURCE"
// },
"item_list": {
"items": [
{
"name": "Apple",
"quantity": 4,
"price": '10',
"currency": "USD"
},
{
"name": "Pineapple",
"quantity": 5,
"price": '12',
"currency": "USD"
}
],
}
}
],
note: "Contact us for any questions on your order.",
onSuccess: (Map params) async {
log("onSuccess: $params");
Navigator.pop(context);
},
onError: (error) {
log("onError: $error");
Navigator.pop(context);
},
onCancel: () {
print('cancelled:');
Navigator.pop(context);
},
),
));*/
