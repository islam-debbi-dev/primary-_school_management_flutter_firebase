class UserData {
  final String email;
  // Add other user properties as needed

  UserData({
    required this.email,
    // Add other constructor parameters as needed
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      email: map['email'],
      // Initialize other properties from map
    );
  }
}

// Inside _chatpageState class

UserData? signedinuser; // Change the type to UserData or make it nullable
