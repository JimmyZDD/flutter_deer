import 'package:get/get.dart';
import 'models.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = 'https://api.github.com';
  }

  /// Find pet by ID
  /// Returns a single pet
  /// Operation ID: getPetById
  Future<Pet> getPetById(int petId) async {
    final res = await get('/pet/$petId');
    return Pet.fromJson(res.body['data']);
  }

  /// Updates a pet in the store with form data
  ///
  /// Operation ID: updatePetWithForm
  /// body type:       String name,      String status,}
  Future updatePetWithForm(int petId,
      {required Map<String, dynamic> body}) async {
    await post('/pet/$petId', body);
  }

  /// Deletes a pet
  ///
  /// Operation ID: deletePet
  Future deletePet(int petId) async {
    await delete('/pet/$petId');
  }

  /// uploads an image
  ///
  /// Operation ID: uploadFile
  /// body type:       String additionalMetadata,      File file,}
  Future<ApiResponse> uploadFile(int petId,
      {required Map<String, dynamic> body}) async {
    final res = await post('/pet/$petId/uploadImage', body);
    return ApiResponse.fromJson(res.body['data']);
  }

  /// Add a new pet to the store
  ///
  /// Operation ID: addPet
  Future addPet({
    required Pet body,
  }) async {
    await post('/pet', body);
  }

  /// Update an existing pet
  ///
  /// Operation ID: updatePet
  Future updatePet({
    required Pet body,
  }) async {
    await put('/pet', body);
  }

  /// Finds Pets by status
  /// Multiple status values can be provided with comma separated strings
  /// Operation ID: findPetsByStatus
  Future<List<Pet>> findPetsByStatus({
    required List<String> status,
  }) async {
    final res = await get('/pet/findByStatus', query: {
      'status': status,
    });
    return res.body['data'].map((e) => Pet.fromJson(e)).toList() as List<Pet>;
  }

  /// Finds Pets by tags
  /// Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.
  /// Operation ID: findPetsByTags
  Future<List<Pet>> findPetsByTags({
    required List<String> tags,
  }) async {
    final res = await get('/pet/findByTags', query: {
      'tags': tags,
    });
    return res.body['data'].map((e) => Pet.fromJson(e)).toList() as List<Pet>;
  }

  /// Returns pet inventories by status
  /// Returns a map of status codes to quantities
  /// Operation ID: getInventory
  Future<int> getInventory() async {
    final res = await get('/store/inventory');
    return res.body['data'];
  }

  /// Find purchase order by ID
  /// For valid response try integer IDs with value >= 1 and <= 10. Other values will generated exceptions
  /// Operation ID: getOrderById
  Future<Order> getOrderById(int orderId) async {
    final res = await get('/store/order/$orderId');
    return Order.fromJson(res.body['data']);
  }

  /// Delete purchase order by ID
  /// For valid response try integer IDs with positive integer value. Negative or non-integer values will generate API errors
  /// Operation ID: deleteOrder
  Future deleteOrder(int orderId) async {
    await delete('/store/order/$orderId');
  }

  /// Place an order for a pet
  ///
  /// Operation ID: placeOrder
  Future<Order> placeOrder({
    required Order body,
  }) async {
    final res = await post('/store/order', body);
    return Order.fromJson(res.body['data']);
  }

  /// Get user by user name
  ///
  /// Operation ID: getUserByName
  Future<User> getUserByName(String username) async {
    final res = await get('/user/$username');
    return User.fromJson(res.body['data']);
  }

  /// Updated user
  /// This can only be done by the logged in user.
  /// Operation ID: updateUser
  Future updateUser(
    String username, {
    required User body,
  }) async {
    await put('/user/$username', body);
  }

  /// Delete user
  /// This can only be done by the logged in user.
  /// Operation ID: deleteUser
  Future deleteUser(String username) async {
    await delete('/user/$username');
  }

  /// Create user
  /// This can only be done by the logged in user.
  /// Operation ID: createUser
  Future createUser({
    required User body,
  }) async {
    await post('/user', body);
  }

  /// Creates list of users with given input array
  ///
  /// Operation ID: createUsersWithListInput
  Future createUsersWithListInput({
    required List<User> body,
  }) async {
    await post('/user/createWithList', body);
  }

  /// Logs user into the system
  ///
  /// Operation ID: loginUser
  Future<String> loginUser({
    required String username,
    required String password,
  }) async {
    final res = await get('/user/login', query: {
      'username': username,
      'password': password,
    });
    return res.body['data'];
  }

  /// Logs out current logged in user session
  ///
  /// Operation ID: logoutUser
  Future logoutUser() async {
    await get('/user/logout');
  }

  /// Creates list of users with given input array
  ///
  /// Operation ID: createUsersWithArrayInput
  Future createUsersWithArrayInput({
    required List<User> body,
  }) async {
    await post('/user/createWithArray', body);
  }
}
