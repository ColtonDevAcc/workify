import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workify/services/authServices.dart';
import 'package:workify/theme/theme.dart';
import 'package:workify/views/signUp/signUpWandNDetails.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SigUupViewState createState() => _SigUupViewState();
}

class _SigUupViewState extends State<SignUpView> {
  TextEditingController firstNameTextController = new TextEditingController();
  TextEditingController lastNameTextController = new TextEditingController();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();
  TextEditingController passwordConfirmationTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    SnackBar snackBar = SnackBar(
      content: Text('OOPS! Your password did not match'),
      backgroundColor: Colors.blue.shade900,
    );

    return Scaffold(
      backgroundColor: Apptheme.mainBackgroundColor,
      body: Scrollbar(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: SvgPicture.asset(
                            'assets/images/AppLogo/AppLogo.svg',
                            color: Apptheme.mainButonColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'LET\'S CREATE YOUR ACCOUNT',
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Apptheme.mainButonColor,
                      ),
                    ),
                    SizedBox(height: 13),
                    userDetailField(title: 'First Name'),
                    SizedBox(height: 13),
                    userDetailField(title: 'Last Name'),
                    SizedBox(height: 13),
                    userDetailField(title: 'Username'),
                    SizedBox(height: 13),
                    userDetailField(title: 'Phone Number'),
                    SizedBox(height: 13),
                    userDetailField(title: 'Email'),
                    SizedBox(height: 13),
                    userDetailField(title: 'Password'),
                    SizedBox(height: 13),
                    userDetailField(title: 'Confirm Password'),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Log in!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            //! Sign the user up with the current info and push the extra info into firestore
                            if (passwordTextController.text ==
                                passwordConfirmationTextController.text) {
                              await AuthServices(FirebaseAuth.instance).signUp(
                                email: emailTextController.text,
                                password: passwordTextController.text,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpWandNDetails(
                                    firstName: firstNameTextController.text,
                                    lastName: lastNameTextController.text,
                                    email: emailTextController.text,
                                    password: passwordConfirmationTextController.text,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Apptheme.mainButonColor,
                            ),
                            width: _screenWidth,
                            height: _screenHeight * .07,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    LineIcons.arrowRight,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: _screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: SvgPicture.asset(
                                  'assets/images/FacebookCircle.svg',
                                ),
                              ),
                              SizedBox(width: 8),
                              CircleAvatar(
                                backgroundColor: Color.fromRGBO(254, 78, 78, 1),
                                child: SvgPicture.asset(
                                  'assets/images/GoogleCircle.svg',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 13),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column userDetailField({title: String}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textScaleFactor: 1.1,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
            hintText: 'Enter $title',
          ),
          controller: firstNameTextController,
        ),
      ],
    );
  }
}
