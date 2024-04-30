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
