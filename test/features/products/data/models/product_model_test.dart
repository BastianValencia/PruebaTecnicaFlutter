import 'package:enm/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductModel Robustness', () {
    test('should parse valid JSON correctly', () {
      final json = {
        'id': '123',
        'name': 'Test Product',
        'price': 100.5,
        'currency': 'USD',
        'imageUrl': 'http://example.com/image.jpg',
        'location': 'New York',
      };

      final model = ProductModel.fromJson(json);

      expect(model.id, '123');
      expect(model.name, 'Test Product');
      expect(model.price, 100.5);
      expect(model.currency, 'USD');
    });

    test('should handle null values by returning defaults', () {
      final json = {
        'id': null,
        'name': null,
        'price': null,
        'currency': null,
        'imageUrl': null,
        'location': null,
      };

      final model = ProductModel.fromJson(json);

      expect(model.id, '');
      expect(model.name, '');
      expect(model.price, 0.0);
      expect(model.currency, '');
      expect(model.imageUrl, '');
      expect(model.location, '');
    });

    test('should handle type mismatches (String for number)', () {
      final json = {
        'id': 12345, // Int passed as ID
        'name': 987, // Int name
        'price': '150.75', // String price
        'currency': 1, // Int currency
        'imageUrl': true, // Bool url
        'location': 3.14, // Double location
      };

      final model = ProductModel.fromJson(json);

      expect(model.id, '12345');
      expect(model.name, '987');
      expect(model.price, 150.75); // Parsed correctly from string
      expect(model.currency, '1');
      expect(model.imageUrl, 'true');
      expect(model.location, '3.14');
    });

    test('should handle completely broken price string as 0.0', () {
      final json = {
        'id': '1',
        'name': 'P',
        'price': 'no-es-un-numero',
        'currency': 'USD',
        'imageUrl': '',
        'location': '',
      };

      final model = ProductModel.fromJson(json);

      expect(model.price, 0.0);
    });
  });
}
