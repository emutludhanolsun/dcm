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
          title: Text(
            'Profil Oluştur',
          ),
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

  // this allows us to access the TextField text
  final _formKey = GlobalKey<FormState>();

  // bool _validAge = false;
  // bool _validIsWorking = false;

  TextEditingController ageFieldController = TextEditingController();
  TextEditingController workStatusFieldController = TextEditingController();

  final workingStatusList = {
    '0': 'Çalışıyorum',
    '1': 'Çalışmıyorum',
  };

  String workStatus = "Çalışıyorum";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

          // TextFormField(
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       return "Lütfen isminizi giriniz.";
          //     }
          //     return null;
          //   },
          //   decoration: new InputDecoration(
          //     labelText: "İsim",
          //     fillColor: Colors.white,
          //     border: new OutlineInputBorder(
          //       borderRadius: new BorderRadius.circular(25),
          //       // borderSide: new BorderSide(),
          //     ),
          //   ),
          // ),

          TextFormField(
            controller: ageFieldController,
            keyboardType: TextInputType.number,
            validator: (value) {
              // print(value);
              if (value.isEmpty) {
                return "Lütfen yaşınızı giriniz.";
                // } else {
                //   _validAge = true;
                //   print("x");
              }
              return null;
            },
            decoration: new InputDecoration(
              labelText: "Yaş",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25),
                borderSide: new BorderSide(),
              ),
            ),
          ),

          DropdownButtonFormField(
            // items: workingStatusList,
            items: workingStatusList.entries
                .map<DropdownMenuItem<String>>(
                    (MapEntry<String, String> e) => DropdownMenuItem<String>(
                          value: e.key,
                          child: Text(e.value),
                        ))
                .toList(),
            onChanged: (value) {
              setState(() {
                workStatus = value;
              });
            },
            decoration: new InputDecoration(
              labelText: "Çalışma Durumu",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25),
                // borderSide: new BorderSide(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      // ignore: deprecated_member_use
                      .showSnackBar(SnackBar(
                          content: Text('Sokağa çıkma durumunuz inceleniyor')));

                  // Navigator.pushNamed(context, "/info");
                  _sendDataToSecondScreen(context, workStatus);
                }
              },
              child: Text("Oluştur"),
            ),
          ),
        ],
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context, String workStatus) {
    String ageToSend = ageFieldController.text;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoScreen(
            age: int.parse(ageToSend),
            workingStatus: workStatus,
          ),
        ));

    print("age: " + ageToSend);
    print("workStatus: " + workStatus);
    User user = new User(int.parse(ageToSend), workStatus);
    print("dışarı çıkmasına izin var mı? " + user.isAllowed.toString());
    // print("mesaj: " + user.message);
  }
}

//TODO: SONUÇ GÖSTERİLECEK
class InfoScreen extends StatelessWidget {
  final int age;
  final String workingStatus;

  InfoScreen({Key key, @required this.age, this.workingStatus})
      : super(key: key);
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

// TODO: Constructor fonksiyonu tamamlancak YA DA Class ı sil direkt fonksiyon yaz.
class User {
  // String name;
  int age;
  int isWorking;

  bool isAllowed;
  String message;
  List<String> messageList = ["otur", "çıkabilirsin"];

  User(/*String name,*/ int age, /*isWorking*/ String workingStatus) {
    // this.name = name;
    this.age = age;
    // this.isWorking = isWorking;
    if (workingStatus == "Çalışıyorum") {
      this.isAllowed = true;
    } else {
      isAllowed = false;
    }

    int gun = DateTime.now().weekday;
    int saat = DateTime.now().hour;

    if (isWorking == 0) {
      this.isAllowed = true;
    } else {
      if ((10 <= saat) && (saat <= 20)) {}
    }

    if (this.isAllowed == true) {
      this.message = messageList[1];
    }

    print(this.isAllowed.toString());
  }
}
