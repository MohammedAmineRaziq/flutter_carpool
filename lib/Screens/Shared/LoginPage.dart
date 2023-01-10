import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:carpool_app/models/LoginRequestModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../config.dart';
import '../../utils.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static var client = http.Client();
  bool loading = true;
  bool internetConn = false;
  String backEndErrorMessage = "";
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  TextEditingController emailController = TextEditingController();
  LoginRequestModel? loginRequestModel;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#0096FF"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height /4,
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                //topLeft: Radius.circular(100),
                //topRight: Radius.circular(150),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "welcome ",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#009DAE"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Login",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "email",
              "email",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "email is required";
                }
                return null;
              },
                  (onSavedVal) => {
                email = onSavedVal,
              },
              validationColor: Colors.red.shade700,
              initialValue: "",
              obscureText: false,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FormHelper.inputFieldWidget(
              context,
              "Password",
              "Password",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Password is required";
                }

                return null;
              },
                  (onSavedVal) => {
                password = onSavedVal,
              },
              initialValue: "",
              obscureText: hidePassword,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              validationColor: Colors.red.shade700,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),backEndErrorMessage.isNotEmpty
              ? Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(backEndErrorMessage),
            ],
          )
              : const SizedBox.shrink(),
          internetConn
              ? Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              Text("Vérifiez votre connection internet !"),
            ],
          )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Login",
                  () {
                    if(validateAndSave()){
                      LoginRequestModel loginRequestModel = LoginRequestModel(
                  email:email!,
                  password:password!,
                );
                    if (globalFormKey.currentState!.validate()) {
                      loginUser(loginRequestModel);
                    }
                    }
              },
              btnColor: Colors.white,
              borderColor: Colors.white,
              txtColor: HexColor("0096FF"),
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //forgot password
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(
                    text: "Forgot Password?",
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: Text("Forgot Password"),
                              content: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  return value!.isNotEmpty&& isValideEmail(value) ? null : "a valid email is required";
                                },
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: Text("Send"),
                                  onPressed: (){},
                                  /*onPressed: () async {
                                    await AuthService.forgotPassword(emailController.text).then((response) {
                                      if (response) {
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ResetForgottenPassword(email: emailController.text),
                                          ),
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text("An error occurred"),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      setState(() {
                                                        emailController.text = "";
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                    });
                                  },*/
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //create an account
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(
                    text: "Don't have an account? ",
                  ),
                  TextSpan(
                    text: "Create an account",
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(
                          context,
                          '/register',
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
  Future loginUser(LoginRequestModel model) async {
    setState(() {
      loading = true;
      internetConn = false;
      backEndErrorMessage = "";
    });
    var url = Uri.https(
      Config.AuthURL,
      Config.loginAPI,
    );
    try {
      const headers = {"Content-type": "application/json"};
      var json = jsonEncode(model.toJson());
      final response = await client.post(
          url,
          headers: headers,
          body: json)
          .timeout(
        const Duration(seconds: 30),
      );
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
          internetConn = false;
          backEndErrorMessage = "";
        });
        final jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
        const storage = FlutterSecureStorage();
        storage.deleteAll();
        await storage.write(
            key: "access_token", value: jsonResponse['access_token']);
        await storage.write(
            key: "refresh_token", value: jsonResponse['refresh_token']);
        await storage.write(key: "role", value: jsonResponse['role']);
        redirectUser(context);
      } else {
        setState(() {
          loading = false;
          internetConn = false;
        });
        final jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          backEndErrorMessage = jsonResponse['error'];
        });
      }
    } catch (e, s) {
      setState(() {
        internetConn = true;
        loading = false;
      });
    }
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}