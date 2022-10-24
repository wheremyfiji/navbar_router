import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:navbar_router/navbar_router.dart';

class NavbarSample extends StatefulWidget {
  const NavbarSample({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<NavbarSample> createState() => _NavbarSampleState();
}

class _NavbarSampleState extends State<NavbarSample> {
  List<NavbarItem> items = [
    NavbarItem(Icons.home, Icons.home, 'Home', backgroundColor: colors[0]),
    NavbarItem(Icons.shopping_bag, Icons.shopping_bag, 'Products', backgroundColor: colors[1]),
    NavbarItem(Icons.person, Icons.person, 'Me', backgroundColor: colors[2]),
  ];
  final Map<int, Map<String, Widget>> routes = {
    0: {
      '/': const HomeFeeds(),
      FeedDetail.route: const FeedDetail(),
    },
    1: {
      '/': const ProductList(),
      ProductDetail.route: const ProductDetail(),
    },
    2: {
      '/': const UserProfile(),
      ProfileEdit.route: const ProfileEdit(),
    },
  };
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
            data: const MediaQueryData(size: Size(800.0, 600.0)),
            child: NavbarRouter(
              errorBuilder: (context) {
                return const Center(child: Text('Error 404'));
              },
              onBackButtonPressed: (isExiting) {
                return isExiting;
              },
              destinationAnimationCurve: Curves.fastOutSlowIn,
              destinationAnimationDuration: 600,
              decoration: NavbarDecoration(
                  navbarType: BottomNavigationBarType.shifting),
              destinations: [
                for (int i = 0; i < items.length; i++)
                  DestinationRouter(
                    navbarItem: items[i],
                    destinations: [
                      for (int j = 0; j < routes[i]!.keys.length; j++)
                        Destination(
                          route: routes[i]!.keys.elementAt(j),
                          widget: routes[i]!.values.elementAt(j),
                        ),
                    ],
                    initialRoute: routes[i]!.keys.first,
                  ),
              ],
            )));
  }
}
