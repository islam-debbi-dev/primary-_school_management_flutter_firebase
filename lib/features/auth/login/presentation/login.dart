import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:for_chat/core/helper/extention.dart';
import 'package:lottie/lottie.dart'; // Import the lottie package
import '../../../../widgets/removespeace.dart';
import '/core/router/constants_route.dart';

class LoginPage extends StatefulWidget {
  static const String screenroute = 'LoginPage';

  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _loggedInUserName = '';
  String _loggedInemailUserName = '';
  bool _isLoading = false; // New variable to track loading state
  bool _loginSuccess = false; // New variable to track login success
  bool _buttonClicked = false;

  void _login() async {
    setState(() {
      _buttonClicked = true;
      _isLoading = true; // Start loading
    });
    String firstName = _firstNameController.text.trim();
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter your User.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = false; // Stop loading
                  _loginSuccess = false;
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    if (firstName.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter your Password.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = false;
                  _loginSuccess = false;
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    // Query Firestore to check credentials
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('firstname', isEqualTo: firstName)
        .where('email', isEqualTo: email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      String role = querySnapshot.docs.first.get('role');
      _redirectToPage(role, firstName, email);
      setState(() {
        _loggedInUserName =
            firstName; // Assuming first name is used to display user's name
        _loggedInemailUserName = email;
        _loginSuccess = true; // Set login success to true
        _emailController.clear();
        _firstNameController.clear();
        _isLoading = false; // Stop loading
      });
    } else {
      // Query Firestore to check if the username exists
      QuerySnapshot<Map<String, dynamic>> usernameQuerySnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .where('email', isEqualTo: email)
              .get();
      if (usernameQuerySnapshot.docs.isNotEmpty) {
        // Show error message for incorrect password
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Incorrect password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoading = false;
                    _loginSuccess = false;
                  });
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        // Show error message for invalid credentials (both username and password)
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Invalid credentials. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoading = false; // Stop loading
                  });
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    if (_buttonClicked) {
      setState(() {
        // Update the UI to display warning icons when the button is clicked
        _buttonClicked = true;
      });
    }
  }

  void _redirectToPage(String role, String firstName, String email) {
    switch (role) {
      case 'Student':
        context.pushNamed(homeStudentRoute, arguments: {
          'firstName': firstName,
          'email': email,
        });
        break;
      case 'Teacher':
        context.pushNamed(homeTeacherRoute, arguments: {
          'firstName': firstName,
          'email': email,
        });
        break;
      case 'admin':
        context.pushNamed(homeAdminRoute, arguments: {
          'firstName': firstName,
          'email': email,
        });
        break;
      default:
        // Handle unexpected role
        break;
    }
  }

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _selectedRecipientController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 70, right: 30),
          child: Text(
            'Welcome to your school',
            style: TextStyle(
                color: Color(0xFF8576FF),
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    child:
                        LottieBuilder.asset("assets/lottie/Animation1.json")),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: _emailController,
                                      onChanged: (_) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'User',
                                        alignLabelWithHint: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                        suffixIcon: _buttonClicked &&
                                                !_isLoading &&
                                                !_loginSuccess &&
                                                _emailController.text
                                                    .trim()
                                                    .isEmpty
                                            ? const Icon(Icons.warning,
                                                color: Colors.red)
                                            : null, // Show warning icon when button is clicked, not loading, login failed, and first name is empty
                                      ),
                                      inputFormatters: [
                                        NoTrailingSpaceFormatter()
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: TextField(
                                        controller: _firstNameController,
                                        onChanged: (_) {
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          alignLabelWithHint: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16.0),
                                          suffixIcon: _buttonClicked &&
                                                  !_isLoading &&
                                                  !_loginSuccess &&
                                                  _firstNameController.text
                                                      .trim()
                                                      .isEmpty
                                              ? const Icon(Icons.warning,
                                                  color: Colors.red)
                                              : null, // Show warning icon when button is clicked, not loading, login failed, and password is empty
                                        ),
                                        obscureText: true,
                                        inputFormatters: [
                                          NoTrailingSpaceFormatter()
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 30),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  const Color(0xFF8576FF)),
                                          foregroundColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.white),
                                          shadowColor:
                                              WidgetStateProperty.all<Color>(
                                                  Colors.grey),
                                          elevation:
                                              WidgetStateProperty.all<double>(
                                                  5),
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          padding: WidgetStateProperty.all<
                                              EdgeInsetsGeometry>(
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                          ),
                                          overlayColor: WidgetStateProperty
                                              .resolveWith<Color?>(
                                            (Set<WidgetState> states) {
                                              if (states.contains(
                                                  WidgetState.pressed)) {
                                                return const Color(0xFF33BBC5);
                                              }
                                              return null; // Use the default value.
                                            },
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          _login();
                                        },
                                        child: const Text(
                                          'Log in',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ),
                                    if (_isLoading) // Show spinner only when loading
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    const SizedBox(height: 300),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF8576FF)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shadowColor: WidgetStateProperty.all<Color>(Colors.grey),
                      elevation: WidgetStateProperty.all<double>(5),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return const Color(0xFF33BBC5);
                          }
                          return null; // Use the default value.
                        },
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: [
                              const Text(
                                'Login request',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF614BC3),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: IconButton(
                                  icon: const Icon(Icons.cancel_outlined),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _selectedRecipientController.clear();
                                    _messageController.clear();
                                  },
                                ),
                              ),
                            ],
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10.0),
                                TextField(
                                  controller: _selectedRecipientController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email or Phone',
                                  ),
                                  maxLines: null,
                                ),
                                TextField(
                                  controller: _messageController,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter student information',
                                    labelStyle: TextStyle(
                                      fontSize:
                                          14.0, // Adjust the label text size here
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize:
                                        18.0, // Adjust the text input size here
                                  ),
                                  maxLines: null,
                                ),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      String messageText =
                                          _messageController.text.trim();
                                      String email =
                                          _selectedRecipientController.text
                                              .trim();
                                      if (messageText.isNotEmpty) {
                                        Navigator.of(context).pop();
                                        // Send message to recipient
                                        FirebaseFirestore.instance
                                            .collection('Loginrequest')
                                            .add({
                                          'send': email,
                                          'recipient': 'admin',
                                          'message': messageText,
                                          'timestamp': Timestamp.now(),
                                        });

                                        // Clear input fields
                                        _messageController.clear();
                                        _selectedRecipientController.clear();
                                      } else {
                                        // Show error message if recipient or message is empty
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Color(0xFF33BBC5),
                                            content: Text(
                                              'Recipient and message cannot be empty',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Send Message'),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xFF8576FF)),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      shadowColor: WidgetStateProperty.all<Color>(Colors.grey),
                      elevation: WidgetStateProperty.all<double>(5),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.pressed)) {
                            return const Color(0xFF33BBC5);
                          }
                          return null; // Use the default value.
                        },
                      ),
                    ),
                    child: const Text(
                      'Login request',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
