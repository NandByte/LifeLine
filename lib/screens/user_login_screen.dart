import 'package:flutter/material.dart';
import 'package:lifeline/components/custom_text_field.dart';
import 'package:lifeline/components/rounded_button.dart';
import 'package:lifeline/constants.dart';
import 'package:lifeline/screens/user_dashboard_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:lifeline/services/authenticate.dart';
import 'package:toast/toast.dart';

class UserLoginScreen extends StatefulWidget {
  static String id = 'user_login';

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool loadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: 0.9,
        progressIndicator: kWaveLoadingIndicator,
        inAsyncCall: loadingIndicator,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                        'assets/images/lifeline_logo.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  CustomTextField(
                    label: 'E-mail',
                    hint: 'johndoe@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    controller: this.email,
                  ),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Type your password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: this.password,
                  ),
                  RoundedButton(
                    text: 'Log In',
                    color: Colors.green[900],
                    onPressed: () async {
                      setState(() {
                        loadingIndicator = true;
                      });
                      try {
                        final user = await Auth()
                            .signIn(this.email.text, this.password.text);
                        print(this.email.text);
                        print(this.password.text);
                        if (user != null)
                          Navigator.pushNamed(context, UserDashboardScreen.id);
                        setState(() {
                          loadingIndicator = false;
                        });
                      } catch (e) {
                        print(e);
                        setState(() {
                          Toast.show(
                            e.message,
                            context,
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.TOP,
                          );
                        });
                      }
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
