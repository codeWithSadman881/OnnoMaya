class AuthService {
  // বর্তমান লগইন করা ইউজারের রোল ('donor', 'volunteer', 'admin', অথবা null)
  static String? currentRole;
  static String currentUserName = "Guest User";

  static void login(String role, String name) {
    currentRole = role;
    currentUserName = name;
  }

  static void logout() {
    currentRole = null;
    currentUserName = "Guest User";
  }
}