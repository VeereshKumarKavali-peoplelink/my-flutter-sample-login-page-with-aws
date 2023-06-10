import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:my_flutter_sample_login_page_with_aws/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: const Text("Hii, You are in Home Page now"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "Hii iam text from home screen");
                },
                child: const Text("Login Page")),
            ElevatedButton(onPressed: (){fetchData();}, child: const Text("Fetch Data"))
          ],
        ),
      ),
    );
  }



  void fetchData() async {
    try {
       // Make a GET request to the specified URL
      final restOperation = Amplify.API.get(apiName: "invcUserGateway",  '/listuser');    //https://fakestoreapi.com/products
      final response = await restOperation.response;
       print('GET call succeeded: ${response.decodeBody()}');
      //return response.body;
    }on ApiException catch (e) {
      print('GET call failed: ${e.message}');
      //return e;
    }
  }


}
