import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:provider/provider.dart';
import 'package:foodiez_frontent/providers/auth_provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FOODIEZ"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(children: <Widget>[
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
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Column(
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
                    padding: const EdgeInsets.all(10),
                    child: reusableTextField("Enter UserName",
                        Icons.person_outline, false, nameController),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: reusableTextField("Enter Password",
                        Icons.lock_outline, true, passwordController),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SignUpOrInButton(
                        context,
                        "Sign In",
                        () async {
                          var authprovider = await context.read<AuthProvider>();
                          authprovider.login(
                              username: nameController.text,
                              password: passwordController.text);
                          context.pop();
                        },
                      )),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          context.push("/signup");
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )
            ])));
  }
}
