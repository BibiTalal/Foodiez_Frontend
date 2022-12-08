import 'package:flutter/material.dart';
import 'package:foodiez_frontent/providers/auth_provider.dart';
import 'package:foodiez_frontent/screens/home.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("FOODIEZ"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Foodiez',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Expanded(
                child: Column(
                  children: [
                    Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextButton(
                          child: Text("Home"),
                          onPressed: () {
                            context.push("/");
                          },
                        ),
                      )
                    ]),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: reusableTextField("Enter UserName",
                          Icons.person_outline, false, nameController),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: reusableTextField("Enter Password",
                          Icons.lock_outlined, true, passwordController),
                    ),
                    Container(
                        key: formKey,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SignUpOrInButton(
                          context,
                          "Sign Up",
                          () async {
                            var authprovider = context.read<AuthProvider>();
                            var success = await authprovider.register(
                                username: nameController.text,
                                password: passwordController.text);
                            if (success == true) {
                              context.pop();
                            } else {
                              print("error");
                            }
                          },
                        )),
                    Row(
                      children: <Widget>[
                        const Text('Have an account?'),
                        TextButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            context.go("/signin",
                                extra: passwordController.text);
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              )
            ])));
  }
}
