import 'package:fingoal_frontend/Sign/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 45, 45, 45),
        body: Center(
            child: isSmallScreen
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "FinGoal",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 55.0),
                          child: Text(
                            "Login To Your Account",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const _FormContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({super.key});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                iconColor: Colors.white,
                labelText: 'Username',
                hintText: 'Enter your Username',
                prefixIcon:
                    const Icon(Icons.email_outlined, color: Colors.white),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelStyle: GoogleFonts.poppins(color: Colors.white),
                hintStyle: GoogleFonts.poppins(color: Colors.white),
              ),
              style: GoogleFonts.poppins(color: Colors.white),
              cursorColor: Colors.white,
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon:
                    const Icon(Icons.lock_outline_rounded, color: Colors.white),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                labelStyle: GoogleFonts.poppins(color: Colors.white),
                hintStyle: GoogleFonts.poppins(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
            ),
            _gap(),
            // CheckboxListTile(
            //   checkColor: Colors.white,
            //   activeColor: Colors.white,
            //   value: _rememberMe,
            //   onChanged: (value) {
            //     if (value == null) return;
            //     setState(() {
            //       _rememberMe = value;
            //     });
            //   },
            //   title: const Text(
            //     'Remember me',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   controlAffinity: ListTileControlAffinity.leading,
            //   dense: true,
            //   contentPadding: const EdgeInsets.all(0),
            // ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: const Color.fromARGB(255, 46, 139, 87)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {}
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignupPage()),
              );
              },
              child: Text.rich(
                TextSpan(
                  text: "Dont Have An Account? ",
                  style: GoogleFonts.poppins(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "SignUp",
                      style: GoogleFonts.poppins(color: const Color.fromARGB(255, 46, 139, 87))
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
