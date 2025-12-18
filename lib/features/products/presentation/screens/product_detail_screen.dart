import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product_status.dart';
import 'package:sizer/sizer.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  
  @override
  void initState() {
    super.initState();
    // Refrescar al entrar para simular consistencia/inconsistencia
    Future.microtask(() => 
      ref.read(productsProvider.notifier).refreshProduct(widget.productId)
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productsProvider);
    final status = state.getStatus(widget.productId);
    final colors = Theme.of(context).colorScheme;

    // 1. Manejo estado Missing
    if (status == ProductStatus.missing) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.remove_shopping_cart, size: 64, color: Colors.orange),
              SizedBox(height: 2.h),
              const Text('El artículo no está disponible.', style: TextStyle(fontSize: 18)),
              SizedBox(height: 2.h),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      );
    }

    // 2. Manejo estado Loading
    if (state.products.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 3. Obtener Producto 
    // (Usamos orElse null o first para evitar crashes, aunque la lógica de arriba protege)
    final product = state.products.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => state.products.first,
    );
    
    return Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          // A. Imagen de Header (45% alto)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 45.h, 
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.broken_image, size: 50)),
              ),
            ),
          ),
          
          // B. Botones de Navegación (Flotantes)
          Positioned(
            top: 6.h,
            left: 5.w,
            right: 5.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleBtn(Icons.arrow_back, () => Navigator.of(context).pop()),
                _buildCircleBtn(Icons.favorite_border, () {}),
              ],
            ),
          ),

          // C. Hoja de Contenido (Sheet)
          Positioned(
            top: 40.h, // Solapa un poco la imagen
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 0),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge / Categoría
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                        color: Colors.black, // Monochrome
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.directions_boat_filled, color: Colors.white, size: 18.sp),
                          SizedBox(width: 2.w),
                          Text(
                            'Maquinaria Premium',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Título y Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, height: 1.2),
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20.sp),
                            SizedBox(width: 1.w),
                            Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
                            Text(' (120)', style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    // Ubicación
                    Row(
                      children: [
                        Icon(Icons.location_pin, size: 16.sp, color: Colors.grey[500]),
                        SizedBox(width: 1.w),
                        Text(product.location, style: TextStyle(color: Colors.grey[500], fontSize: 15.sp)),
                      ],
                    ),
                    
                    SizedBox(height: 3.h),

                    // Amenities (Chips)
                    Text('Características', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    SizedBox(height: 1.5.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFeatureChip(Icons.flash_on, 'Potencia Alta'),
                          SizedBox(width: 2.w),
                          _buildFeatureChip(Icons.verified_user, 'Garantía 1 A.'),
                          SizedBox(width: 2.w),
                          _buildFeatureChip(Icons.local_shipping, 'Envío Gratis'),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 3.h),

                    // Descripción
                    const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 1.h),
                    Text(
                      'Esta maquinaria pesada ofrece un rendimiento excepcional para proyectos de construcción de gran escala. Incluye mantenimiento al día y certificaciones internacionales requeridas para operación inmediata.',
                      style: TextStyle(color: Colors.grey[600], height: 1.2, fontSize: 15.sp),
                    ),
                    
                    // Aviso de cambio de precio (Stale)
                    if (status == ProductStatus.stale) ...[
                      SizedBox(height: 2.h),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(12)),
                        child: Row(
                           children: [
                             const Icon(Icons.warning_amber, color: Colors.amber),
                             SizedBox(width: 2.w),
                             const Expanded(child: Text('El precio ha cambiado recientemente.'))
                           ],
                        ),
                      )
                    ],

                    SizedBox(height: 15.h), // Espacio para el bottom bar
                  ],
                ),
              ),
            ),
          ),

          // D. Bottom Action Bar (Sticky)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: colors.surface,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Precio Total', style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                        Text(
                          product.formattedPrice,
                          style: TextStyle(
                            fontSize: 18.sp, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.blue[700]
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Text('Comprar Ahora', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), // Ligeramente translúcido
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
        ),
        child: Icon(icon, color: Colors.black87, size: 20),
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: Colors.grey[50], // Muy sutil
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.sp, color: Colors.blue[600]), // Icono azul
          SizedBox(width: 1.w),
          Text(
            label, 
            style: TextStyle(color: Colors.grey[800], fontSize: 13.sp, fontWeight: FontWeight.w600)
          ),
        ],
      ),
    );
  }
}