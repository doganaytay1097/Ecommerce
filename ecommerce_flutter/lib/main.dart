import 'package:ecommerce_flutter/constans/theme_data.dart';
import 'package:ecommerce_flutter/providers/cart_provider.dart';
import 'package:ecommerce_flutter/providers/product_provider.dart';
import 'package:ecommerce_flutter/providers/theme_provider.dart';
import 'package:ecommerce_flutter/providers/user_provider.dart';
import 'package:ecommerce_flutter/providers/viewed_recently_providers.dart';
import 'package:ecommerce_flutter/providers/wishlist_provider.dart';
import 'package:ecommerce_flutter/root_screen.dart';
import 'package:ecommerce_flutter/screens/auth/forgot_password.dart';
import 'package:ecommerce_flutter/screens/auth/login.dart';
import 'package:ecommerce_flutter/screens/auth/register.dart';
import 'package:ecommerce_flutter/screens/home_screen.dart';
import 'package:ecommerce_flutter/screens/init_screen/viewed_recently.dart';
import 'package:ecommerce_flutter/screens/init_screen/wishlist.dart';
import 'package:ecommerce_flutter/screens/search_screen.dart';
import 'package:ecommerce_flutter/widgets/order/order_screen.dart';
import 'package:ecommerce_flutter/widgets/products/product_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(
            options: const FirebaseOptions(
              apiKey: 'AIzaSyB8u42Y3NvUcQfKPdu6Ic_HmNGNibHTduA',
              appId: '1:693686315099:android:59fbd134217f485f2df77e',
              messagingSenderId: '693686315099',
              projectId: 'ecommerce-app-d429d',
              storageBucket: 'ecommerce-app-d429d.appspot.com',
        )),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ));
          } else if (snapshot.hasError) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: SelectableText(snapshot.error.toString()),
                  ),
                ));
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProdProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'E-commerce App ',
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),

                home: const LoginScreen(),
                //    home:const RootScreen(),
                routes: {
                  ProductDetailScreen.routName: (context) =>
                      const ProductDetailScreen(),
                  RootScreen.routName: (context) => const RootScreen(),
                  WishlistScreen.routName: (context) => const WishlistScreen(),
                  ViewedRecentlyScreen.routName: (context) =>
                      const ViewedRecentlyScreen(),
                  RegisterScreen.routName: (context) => const RegisterScreen(),
                  OrderScreen.routName: (context) => const OrderScreen(),
                  ForgotPassword.routName: (context) => const ForgotPassword(),
                  SearchScreen.routName: (context) => const SearchScreen(),
                  LoginScreen.routName: (context) => const LoginScreen(),
                },
              );
            }),
          );
        });
  }
}
