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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['expires'] = expires;
    data['id'] = id;
    return data;
  }
}
