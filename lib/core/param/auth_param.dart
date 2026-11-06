class SignUpParam {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpParam({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class LoginParam {
  final String email;
  final String password;

  LoginParam({required this.email, required this.password});
}
