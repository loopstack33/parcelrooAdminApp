
import 'package:fancy_button_new/fancy_button_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcelroo_admin/views/login/widgets/remember_me.dart';
import 'package:provider/provider.dart';
import '../../enums/color_constants.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_widget.dart';
import 'controller/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginProvider>().loadUserEmailPassword(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: bgGradient
          ),
          child: Form(
            key: context.read<LoginProvider>().formKey,
            child: Padding(
              padding:  const EdgeInsets.only(left: 20,right: 20,top: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const Text.rich(
                        TextSpan(
                            children:[
                              TextSpan(
                                  text: "Parcel",
                                  style: TextStyle(fontFamily: "Poppins",fontSize: 40,color:lightBlue,fontWeight: FontWeight.w600)
                              ),
                              TextSpan(
                                  text: "roo",
                                  style: TextStyle(fontFamily: "Poppins",fontSize: 40,color:lightPurple,fontWeight: FontWeight.w600)
                              )
                            ])),
                    const Text.rich(TextSpan(children:[
                      TextSpan(
                          text: "Super",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 20,color:whiteColor,fontWeight: FontWeight.w500)
                      ),
                      TextSpan(
                          text: " Admin",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 20,color:whiteColor,fontWeight: FontWeight.w500)
                      )
                    ])),
                    const SizedBox(height: 40),
                    myText(text: "Login", fontFamily: "Poppins", size: 28, color: whiteColor,fontWeight: FontWeight.w700,),
                    const SizedBox(height: 20),
                    CustomTextField(controller: context.read<LoginProvider>().emailController, hint: "Enter Email",suffixIcon: const Icon(Icons.email,color: greyDark,size: 25),
                      validator: (value) {
                        if(value ==null || value.isEmpty){
                        return "Please Enter Your Email";

                        }
                        else if((RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value) ==
                            false) ){
                          return "Please Enter Valid Email";
                        }

                        return null;
                      }),
                    const SizedBox(height: 20),
                    CustomTextField(
                        validator: (value) {

                          if(value ==null || value.isEmpty){
                            return "Please Enter Your Password";
                          }

                          return null;
                        },
                        controller: context.read<LoginProvider>().passController,
                        hint: "Enter Password",
                        obscure:  context.watch<LoginProvider>().passwordVisible,
                        suffixIcon: InkWell(
                            onTap: () {
                              context
                                  .read<LoginProvider>()
                                  .togglePassword();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                context.watch<LoginProvider>().passwordVisible
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_rounded,
                                size: 25,
                              ),
                            )),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ]),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        rememberMeCheckbox(context.read<LoginProvider>().rememberMe,
                            context.read<LoginProvider>().handleRememberMe, context),
                      ],
                    ),
                    const SizedBox(height: 40),
                    context.watch<LoginProvider>().isLoading? const Center(
                      child: CircularProgressIndicator(color: darkPurple),
                    ): MyFancyButton(
                        width: MediaQuery.of(context).size.width*0.5,
                        borderRadius:40,
                        isIconButton: false,
                        isGradient: true,
                        fontColor: whiteColor,
                        gradient: const LinearGradient(
                          colors: [
                            darkPurple,
                            Color(0xFF6610F2),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        fontSize: 22,
                        family: "Poppins",
                        text: "Login", tap: (){
                      if (context.read<LoginProvider>().formKey.currentState!.validate()) {

                        context.read<LoginProvider>().signIn(context, context.read<LoginProvider>().emailController.text,
                            context.read<LoginProvider>().passController.text);
                      }
                    },
                        buttonColor: darkPurple,
                        hasShadow: true),

                  ],
                ),
              ),
            )
          )
      ),
    );
  }

}
