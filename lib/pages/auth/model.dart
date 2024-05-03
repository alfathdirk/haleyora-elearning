class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final int expires;
  final String id;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expires,
    required this.id,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expires: json['expires'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['expires'] = this.expires;
    data['id'] = this.id;
    return data;
  }
}

class UserData {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String?
      password; // Note: Storing passwords in plaintext is insecure, this is just for demonstration
  final String? location;
  final String? title;
  final String? description;
  final List<String>? tags;
  final String? avatar;
  final String? language;
  final String? tfaSecret;
  final String? status;
  final String? role;
  final DateTime? lastAccess;
  final String? lastPage;
  final String? provider;
  final String? externalIdentifier;
  final String? authData;
  final bool? emailNotifications;
  final dynamic? appearance;
  final dynamic? themeDark;
  final dynamic? themeLight;
  final dynamic? themeLightOverrides;
  final dynamic? themeDarkOverrides;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.location,
    this.title,
    this.description,
    this.tags,
    this.avatar,
    this.language,
    this.tfaSecret,
    this.status,
    this.role,
    this.lastAccess,
    this.lastPage,
    this.provider,
    this.externalIdentifier,
    this.authData,
    this.emailNotifications,
    this.appearance,
    this.themeDark,
    this.themeLight,
    this.themeLightOverrides,
    this.themeDarkOverrides,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      location: json['location'],
      title: json['title'],
      description: json['description'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      avatar: json['avatar'],
      language: json['language'],
      tfaSecret: json['tfa_secret'],
      status: json['status'],
      role: json['role'],
      lastAccess: json['last_access'] != null
          ? DateTime.parse(json['last_access'])
          : null,
      lastPage: json['last_page'],
      provider: json['provider'],
      externalIdentifier: json['external_identifier'],
      authData: json['auth_data'],
      emailNotifications: json['email_notifications'],
      appearance: json['appearance'],
      themeDark: json['theme_dark'],
      themeLight: json['theme_light'],
      themeLightOverrides: json['theme_light_overrides'],
      themeDarkOverrides: json['theme_dark_overrides'],
    );
  }
}
