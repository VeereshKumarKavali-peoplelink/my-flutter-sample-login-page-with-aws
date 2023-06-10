import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:my_flutter_sample_login_page_with_aws/amplifyconfiguration.dart';
import 'package:my_flutter_sample_login_page_with_aws/app_routes.dart';
import 'package:my_flutter_sample_login_page_with_aws/home_page.dart';
import 'package:my_flutter_sample_login_page_with_aws/login_page.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Future<void> configureAmplify() async {
//   AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
//   await Amplify.addPlugins([authPlugin]);
//   await Amplify.configure(amplifyconfig);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();
  runApp(const MyApp());
}




Future<void> configureAmplify() async{
  try{
    final auth = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([auth, api]);
    await Amplify.configure(amplifyconfig);
    safePrint('Successfully configured');
  } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          AppRoute.homePage: (context)=> const HomePage(),

        },
        home: const LoginPage());
        
  }
}
