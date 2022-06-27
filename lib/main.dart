import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tetris/gamer/gamer.dart';
import 'package:tetris/generated/l10n.dart';
import 'package:tetris/material/audios.dart';
import 'package:tetris/panel/page_portrait.dart';

import 'gamer/keyboard.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  _disableDebugPrint();
  runApp(MyApp());
}

void _disableDebugPrint() {
  bool debug = false;
  assert(() {
    debug = true;
    return true;
  }());
  if (!debug) {
    debugPrint = (message, {wrapWidth}) {
      //disable log print when not in debug mode
    };
  }
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class GameApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tetris',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Sound(
            child: Game(
                child: KeyboardController(
                    child: _HomePage()
                )
            )
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final HomeWork',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '俄罗斯方块'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  bool isVis = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String username = "";
  String password = "";

  void loginButton(){
    print("login");

    if(username != "admin" || password != "123456"){

      setState(() {
        isVis = true;
      });
      return;
    }

    var result = Navigator.push(
      context,
      MaterialPageRoute(builder: (context){
        return GameApp();
      })
    );
    print(result);
  }

  void registerButton(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 400
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    visible: isVis,
                    child:Text("用户名或密码错误",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12
                      ),
                    ),
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      prefixIcon: Icon(Icons.person)
                  ),
                  onChanged: (v)=>{
                    username = v
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      prefixIcon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                  onChanged: (v)=>{
                    password = v
                  },
                ),
                ElevatedButton(onPressed: loginButton, child: Text("登录")),
                ElevatedButton(onPressed: registerButton, child: Text("注册"))

              ],
            ),
          )
        ),
      ),
    );
  }
}

const SCREEN_BORDER_WIDTH = 3.0;

const BACKGROUND_COLOR = const Color(0xffefcc19);

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //only Android/iOS support land mode
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;
    return land ? PageLand() : PagePortrait();
  }
}
