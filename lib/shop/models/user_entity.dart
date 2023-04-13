/*
 * @Author: zdd
 * @Date: 2023-04-13 21:40:56
 * @LastEditors: zdd
 * @LastEditTime: 2023-04-13 22:40:42
 * @FilePath: /flutter_deer/lib/shop/models/user_entity.dart
 * @Description: 
 */
class UserEntity {
  UserEntity({
    this.avatarUrl,
    this.name,
    this.id,
    this.blog,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        avatarUrl: json['avatar_url'],
        name: json['name'],
        id: json['id'],
        blog: json['blog'],
      );

  Map<String, dynamic> toJson() => {
        'avatar_url': avatarUrl,
        'name': name,
        'id': id,
        'blog': blog,
      };

  String? avatarUrl;
  String? name;
  int? id;
  String? blog;
}
