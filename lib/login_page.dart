import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_app/home_page.dart';
import 'package:postgres/postgres.dart';
int? uid;
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _passwordController = TextEditingController();
    final _emailController = TextEditingController();
    bool showSpinner = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 15.0,
        title: Text("Login Page"),
        backgroundColor: Colors.black,
      ),
      // backgroundColor: Colors.blue,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        opacity: 0.4,
        //color: Colors.white,
        progressIndicator: CircularProgressIndicator(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        fillColor: Colors.yellow,
                        hintStyle: TextStyle(
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: "Enter your Username",
                        labelStyle: TextStyle(
                          color: Colors.black45,
                        )),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.yellow,
                      hintStyle: TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      labelText: "Enter your password",
                      labelStyle: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  RoundedButton(
                    colour: Colors.grey,
                    text: "Log In",
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      final email = _emailController.text.toString().trim();
                      final password =
                      _passwordController.text.toString().trim();
                      verify(email,password).then((value){
                        if(value==true){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(uid: uid)));
                        }
                      });
                      // await userLogin(email, password);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({this.colour, this.text, this.onPressed});

  final colour;
  final Function()? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Material(
          elevation: 5.0,
          color: colour,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            //hoverElevation: ,
            onPressed: onPressed,
            minWidth: 160.0,
            height: 42.0,
            child: Text(
              text!,
              style: TextStyle(
                color:Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> verify(String uname, String passwd) async {
  final connection = PostgreSQLConnection(
      'ec2-52-200-155-213.compute-1.amazonaws.com', 5432, 'dbca0g0f9vhbak',
      username: 'btkydjfodbmlon',
      password:
      '9f0e0882442218b55ad591c941c7ce472eef22addf02a30df9413864d2d318d0',
      useSSL: true);
  await connection.open();
  var a = await connection.query('select username,passwd from users');
  print(a);
  await connection.close();
  for(int i=0;i<a.length;i++){
if(a[i][0]==uname && a[i][1]==passwd){
  uid = i;
  return true;
}
  }
  return false;
}