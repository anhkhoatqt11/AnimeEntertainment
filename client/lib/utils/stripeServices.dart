// import 'dart:convert';

// import 'package:http/http.dart' as http;


// class StripeService {
  // String secertKey =
  //     "pk_test_51ODjQDIaNBrc2Pq6swUhpnLcB0RimBk8SuNGKLX7nr8Q6pap5FiKRe21VW9iXd1mB41FE7vcnYZcajBxLtv24xt600TnsvCavV";
  // String publishableKey =
  //     "sk_test_51ODjQDIaNBrc2Pq6ycuVZfFbWOvKfwaS5F56OsT3CnfCCAEOLeCndkduEPXBj0wZTRoeJw637kCBn1PX0NsL7JSv00v5jcG5kM"; 


//        Future<dynamic> createCheckoutSession (
//         List<dynamic> productItems,
//         totalAmount,) async {
//             final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

//             String lineItems = "";
//             int index = 0;

//             productItems.forEach(
//               (val) {
//                 var productPrime = (val["productPrime"] *100).round().toString();
//                 lineItems += "&line_items[$index][price_data][product_data][name]={$val['productName]}";
//                 lineItems += "&line_items[$index][price_data][unit_amount]=$productPrime";
//                 lineItems += "&line_items[$index][price_data][product_data][currency]=usd";
//                 lineItems += "&line_items[$index][qty]=${val['qty'].toString()}";
//                 index++;
//               },
//             );


//             final response = await http.post(
//               url,
//               body: 'success_url=https://checkout.stripe.dev/success&mode=payment$lineItems',
//               headers: {
//                 'Authorization': 'Bearer $secertKey',
//                 'Content-Type': 'application/x-www-form-urlencoded',
//               }
//             );

//             return json.decode(response.body)["id"];
//         }
//        Future<dynamic> stripePaymentCheckout(
//           productItems,
//           subTotal,
//           context,
//           mounted, {
//             onSucess,
//             onCancel,
//             onError,
//           }
//         ) async {
//           final String sessionId = await createCheckoutSession(
//             productItems,
//             subTotal,
//           );

//           final result = await redirectToCheckout(
//             context: context,
//             sessionId: sessionId,
//             publishableKey: publishableKey,
//           )
//         }
// }
