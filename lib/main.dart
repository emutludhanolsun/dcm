import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Napam App",
    darkTheme: ThemeData.dark(),
    // If local user exists
    // initialRoute: /info
    initialRoute: "/createUser",
    routes: {
      "/createUser": (context) => CreateUserScreen(),
      "/info": (context) => InfoScreen(),
    },
  ));
}

class CreateUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Center(
              child: new Text("Profil Oluştur", textAlign: TextAlign.center)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: MyCustomForm(),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,          ?????????????????????????????
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String _ratingController;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(
                135, 0, 300, 15), // TODO: orientation according to screenSize
            child: new Icon(
              Icons.account_circle_rounded,
              size: 75,
              color: Colors.blueGrey,
            ),
          ),
          //TextFormField(
          //decoration: new InputDecoration(
          //labelText: "İsim",
          //fillColor: Colors.white,
          //border: new OutlineInputBorder(
          //borderRadius: new BorderRadius.circular(25),
          // borderSide: new BorderSide(),
          //),
          //),
          //validator: (value) {
          //if (value.isEmpty) {
          //return 'Please enter some text';
          //}
          //return null;
          //},
          //),
          TextFormField(
            decoration: new InputDecoration(
              labelText: "Yaş",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25),
                // borderSide: new BorderSide(),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          DropdownButtonFormField(
            value: _ratingController,
            decoration: new InputDecoration(
              labelText: "Çalışma Durumu",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25),
                // borderSide: new BorderSide(),
              ),
            ),
            items: ["Çalışıyorum", "Çalışmıyorum"]
                .map((label) => DropdownMenuItem(
                      child: Text(label.toString()),
                      value: label,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _ratingController = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      // ignore: deprecated_member_use
                      .showSnackBar(SnackBar(
                          content: Text('Sokağa çıkma durumunuz inceleniyor')));
                }
                Navigator.pushNamed(context, "/info");
                // Navigator.push(context, route)
              },
              child: Text("Oluştur"), //TODO: fieldlar boşsa buton basmasın
            ),
          ),
        ],
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  // final String text;
  // InfoScreen({Key key, @required this.text}) : super(key: key);  //TODO: fieldlar için keyler eklencek
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class User {
  //String name;
  int age;
  bool isWorking;
  bool isAllowed;
  String message;
  List<String> messageList = ["otur", "çıkabilirsin"];

  User(String name, age, isWorking) {
    //this.name = name;
    this.age = int.parse(age);
    if (isWorking == "Çalışıyorum") {
      this.isWorking = true;
    }
    int gun = DateTime.now().day;
    int saat = DateTime.now().hour;
    print(gun.toString());

    // TODO: get date and time info from telephone AND add other calculations

    if (this.isWorking == true) {
      this.isAllowed = true;
      this.message = messageList[1];
    }
  }
}
