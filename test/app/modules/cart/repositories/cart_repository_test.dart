import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:siclos/app/modules/cart/repositories/interfaces/cart_repository_interface.dart';

class MockClient extends Mock implements Dio {}

void main() {
  ICartRepository repository;
  // MockClient client;

  setUp(() {
    // client = MockClient();
    // repository = CartRepository(client);
  });

  group('CartRepository Test', () {
    //  test("First Test", () {
    //    expect(repository, isInstanceOf<CartRepository>());
    //  });

    test('returns a Post if the http call completes successfully', () async {
      //    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
      //        .thenAnswer((_) async =>
      //            Response(data: {'title': 'Test'}, statusCode: 200));
      //    Map<String, dynamic> data = await repository.fetchPost(client);
      //    expect(data['title'], 'Test');
    });
  });
}