
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_demo_app/ui/helper/page_routes.dart';

import '../navigationDrawer.dart';
import 'anime_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'NavigationDrawer Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes:  {
        PageRoutes.home: (context) => HomeScreen(),
        PageRoutes.contact: (context) => AnimList(),

      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Home"),
            actions: <Widget>[Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
            onTap: ()  {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(LoggedOut());
            },
            child: Icon(
              Icons.logout,
              size: 26.0,
            )

        ),)]
        ),
        drawer: navigationDrawer(),
        body: Center(child: Text("This is home page")));
  }
}

// class HomeScreen extends StatelessWidget{
//   final appTitle = 'Home';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: appTitle,
//       home: MyHomePage(title: appTitle),
//     );
//   }
//
// }
//
// class MyHomePage extends StatelessWidget{
//   final String title;
//
//   MyHomePage({Key key, this.title}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('Home'),
//         actions: <Widget>[Padding(
//           padding: EdgeInsets.only(right: 20.0),
//         child: GestureDetector(
//           onTap: ()  {
//     BlocProvider.of<AuthenticationBloc>(context)
//         .add(LoggedOut());
//     },
//           child: Icon(
//             Icons.logout,
//             size: 26.0,
//           )
//
//         ),
//     )
//         ],
//       ),
//       body: Center(child: Text('Welcome...'),),
//       drawer: Drawer(
//         child: Column(
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('graphics/flutter-logo.png'),
//                 fit: BoxFit.fill)
//                 ),
//                 accountName: Text('Satya Magam'), accountEmail: Text('abc@xyz.com')),
//             Column(
//               children: <Widget>[
//                 ListTile(
//                   leading: Icon(Icons.calendar_today, color: Colors.blue),
//                     title: Text("Anime"),
//                     onTap:(){AnimList();},
//                 ),
//                 ListTile(
//                     leading: Icon(Icons.calendar_today, color: Colors.blue),
//                     title: Text("Filter Animes")
//                 ),
//
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }