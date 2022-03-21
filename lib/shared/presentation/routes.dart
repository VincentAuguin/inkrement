import 'package:flutter/cupertino.dart';
import 'package:inkrement/counter/presentation/edit_counter_page.dart';
import 'package:inkrement/counter/presentation/new_counter_page.dart';
import 'package:inkrement/home/presentation/home_page.dart';

Map<String, WidgetBuilder> routes = {
  HomePage.route: (context) => const HomePage(),
  NewCounterPage.route: (context) => const NewCounterPage(),
  EditCounterPage.route: (context) => const EditCounterPage()
};

RouteObserver routeObserver = RouteObserver();
