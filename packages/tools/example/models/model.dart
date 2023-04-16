class ApiResponse {
  ApiResponse({
    this.code,
    this.type,
    this.message,
  });

  int? code;

  String? type;

  String? message;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        code: json["code"],
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "type": type,
        "message": message,
      };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int? id;

  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Pet {
  Pet({
    this.id,
    this.category,
    required this.name,
    required this.photoUrls,
    this.tags,
    this.status,
  });

  int? id;

  Category? category;

  String name;

  List<String> photoUrls;

  List<Tag>? tags;

  ///pet status in the store
  String? status;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["id"],
        category: Category.fromJson(json["category"]),
        name: json["name"],
        photoUrls: List<String>.from(json["photoUrls"].map((x) => x)),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category != null ? category!.toJson() : null,
        "name": name,
        "photoUrls": photoUrls.map((e) => e).toList(),
        "tags": tags != null ? tags!.map((e) => e.toJson()).toList() : null,
        "status": status,
      };
}

class Tag {
  Tag({
    this.id,
    this.name,
  });

  int? id;

  String? name;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Order {
  Order({
    this.id,
    this.petId,
    this.quantity,
    this.shipDate,
    this.status,
    this.complete,
  });

  int? id;

  int? petId;

  int? quantity;

  DateTime? shipDate;

  ///Order Status
  String? status;

  bool? complete;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        petId: json["petId"],
        quantity: json["quantity"],
        shipDate: json["shipDate"],
        status: json["status"],
        complete: json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "petId": petId,
        "quantity": quantity,
        "shipDate": shipDate,
        "status": status,
        "complete": complete,
      };
}

class User {
  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.userStatus,
  });

  int? id;

  String? username;

  String? firstName;

  String? lastName;

  String? email;

  String? password;

  String? phone;

  ///User Status
  int? userStatus;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        userStatus: json["userStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phone": phone,
        "userStatus": userStatus,
      };
}
