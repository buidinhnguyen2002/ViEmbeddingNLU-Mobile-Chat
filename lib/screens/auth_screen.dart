import '../models/http_exception.dart';
import '../providers/auth.dart';
import '../utils/colors.dart';
import '../utils/functions.dart';
import '../utils/widgets.dart';
import '../widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { SignUp, SignIn }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.SignIn;
  final Map<String, String> _authData = {
    "username": "Nguyen",
    "password": "123456",
  };
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      if (_authMode == AuthMode.SignIn) {
        await auth.login(
          _userNameController.text,
          _passwordController.text,
        );
        // await auth.login(
        //   "20130338@st.hcmuaf.edu.vn",
        //   "Hocsinha1@",
        // );
      } else {
        final response = await auth.register(
          _userNameController.text,
          _passwordController.text,
          _fullNameController.text,
          _phoneNumberController.text,
        );
        if (response) {
          await showNotification(context, "Tạo tài khoản thành công!");
          setState(() {
            _authMode = AuthMode.SignIn;
          });
        }
      }
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (e) {
      _showErrorDialog("Error! " + e.toString());
    }
  }

  final _passwordController = TextEditingController();
  void _switchAuthMode() {
    if (_authMode == AuthMode.SignIn) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.SignIn;
      });
    }
  }

  void login(String username, String password) {}

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          child: Padding(
            padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxEmpty.sizeBox20,
                Text(
                  "${_authMode == AuthMode.SignIn ? "Login" : "Register"}",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                BoxEmpty.sizeBox20,
                Container(
                  padding: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    color: AppColors.lightGrey,
                  ),
                  // height: 45,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      hintText: 'Email', // Placeholder
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person),
                    ),
                    controller: _userNameController,
                  ),
                ),
                BoxEmpty.sizeBox20,
                Container(
                  padding: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    color: AppColors.lightGrey,
                  ),
                  // height: 45,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      hintText: 'Mật khẩu', // Placeholder
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.password),
                    ),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                ),
                BoxEmpty.sizeBox20,
                if (_authMode != AuthMode.SignIn)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          color: AppColors.lightGrey,
                        ),
                        // height: 45,
                        child: TextField(
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            hintText: 'Nhập lại mật khẩu', // Placeholder
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.password),
                          ),
                          obscureText: true,
                          controller: _repasswordController,
                        ),
                      ),
                      BoxEmpty.sizeBox20,
                    ],
                  ),
                CommonButton(
                    title:
                        '${_authMode == AuthMode.SignIn ? 'Đăng nhập' : 'Đăng ký'}',
                    onPress: () => _submit(context)),
                BoxEmpty.sizeBox15,
                Row(
                  children: [
                    TextButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                        '${_authMode == AuthMode.SignIn ? 'Tạo tài khoản' : 'Đăng nhập'}',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
