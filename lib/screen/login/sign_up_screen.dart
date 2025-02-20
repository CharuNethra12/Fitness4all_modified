import 'package:fitness4all/common/color_extensions.dart';
import 'package:fitness4all/common_widgets/round_button.dart';
import 'package:fitness4all/screen/login/mobile_number_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              "assets/img/app_logo.jpg",
              width: context.width * 0.7,
            ),
            const SizedBox(
              height: 100,
            ),
            RoundButton(
                title: "Mobile Number",
                type: RoundButtonType.line,
                isPadding: false,
                image: "assets/img/phone.png",
                fontWeight: FontWeight.normal,
                onPressed: () {
                  context.push(const MobileNumberScreen());
                }),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 36,
                      decoration: BoxDecoration(
                          color: const Color(0xff3A91F7),
                          borderRadius: BorderRadius.circular(18)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/img/fb_logo.png",
                            width: 12,
                            height: 12,
                          ),
                          const Expanded(
                            child: Text(
                              "Facebook",
                              textAlign: TextAlign.center,
                              style:
                              TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 36,
                      decoration: BoxDecoration(
                          color: TColor.txtBG,
                          border: Border.all(color: TColor.board, width: 1),
                          borderRadius: BorderRadius.circular(18)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/img/google_logo.png",
                            width: 12,
                            height: 12,
                          ),
                          Expanded(
                            child: Text(
                              "Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: TColor.primaryText, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}