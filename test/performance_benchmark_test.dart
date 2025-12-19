import 'package:enm/features/products/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Cantidad de items para simular "gran volumen"
  const int itemCount = 50000; 

  group('Performance Benchmark', () {
    
    // Generar datasets
    final List<Map<String, dynamic>> cleanData = List.generate(itemCount, (index) => {
      'id': '$index',
      'name': 'Product $index',
      'price': 100.0 + index, // Double puro (Fast path)
      'currency': 'USD',
      'imageUrl': 'http://img.com/$index.jpg',
      'location': 'Store $index',
    });

    final List<Map<String, dynamic>> dirtyData = List.generate(itemCount, (index) => {
      'id': index, // Int -> String conversion
      'name': 'Product $index',
      'price': '${100.0 + index}', // String -> Double conversion (Slow path)
      'currency': 'USD',
      'imageUrl': null, // Null handling
      'location': 'Store $index',
    });

    test('Benchmark: Parsing $itemCount items with CLEAN data (Fast Path)', () {
      final stopwatch = Stopwatch()..start();
      
      final models = cleanData.map((json) => ProductModel.fromJson(json)).toList();
      
      stopwatch.stop();
      print('\n⚡️ [Clean Data] Parsed $itemCount items in ${stopwatch.elapsedMilliseconds}ms');
      print('   Average per item: ${(stopwatch.elapsedMicroseconds / itemCount).toStringAsFixed(2)} µs');
      
      expect(models.length, itemCount);
    });

    test('Benchmark: Parsing $itemCount items with DIRTY data (Slow Path)', () {
      final stopwatch = Stopwatch()..start();
      
      final models = dirtyData.map((json) => ProductModel.fromJson(json)).toList();
      
      stopwatch.stop();
      print('\n🛡️ [Dirty Data] Parsed $itemCount items in ${stopwatch.elapsedMilliseconds}ms');
      print('   Average per item: ${(stopwatch.elapsedMicroseconds / itemCount).toStringAsFixed(2)} µs');
      
      expect(models.length, itemCount);
    });
  });
}
