class UserInfo {
  /// 用户名称
  final String nickName;

  /// 用户ID
  final String id;

  /// 性别
  final Sex sex;

  /// token
  final String token;

  UserInfo({
    required this.id,
    required this.nickName,
    required this.sex,
    required this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json["id"] ?? "",
      nickName: json["nickName"] ?? "",
      sex: Sex.fromValue(json["sex"] ?? ""),
      token: json["token"] ?? "",
    );
  }

  // 👇 必须加这个！用于保存到本地缓存
  Map<String, dynamic> toJson() {
    return {"id": id, "nickName": nickName, "sex": sex.value, "token": token};
  }
}

enum Sex {
  male('male'),
  female('female');

  final String value;
  const Sex(this.value);

  /// 从字符串解析环境，默认回退到 dev
  factory Sex.fromValue(String sex) {
    return Sex.values.firstWhere(
      (item) => item.value == sex,
      orElse: () => male,
    );
  }
}
