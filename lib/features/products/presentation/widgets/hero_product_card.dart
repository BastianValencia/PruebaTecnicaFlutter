import 'package:enm/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';


class HeroProductCard extends StatelessWidget {
  final Product product;

  const HeroProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: SizedBox(
        height: 30.h,
        width: double.infinity,
        child: Stack(
          children: [
            // Background Image with Hero
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))
                  ]
                ),
              ),
            ),
            
            // Content
            Positioned(
              top: 2.h,
              left: 4.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(Icons.star, size: 15.sp, color: Colors.yellow.shade500),
                    SizedBox(width: 1.w),
                    Text('4.5', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ),
            ),
             Positioned(
              bottom: 3.h,
              left: 5.w,
              right: 5.w,
              child: ClipRRect( // Efecto Glassmorphism simple
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  color: Colors.white.withOpacity(0.9), // Casi opaco para legibilidad
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name, 
                              maxLines: 2, 
                              style: TextStyle(
                                fontSize: 15.sp, 
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ), 
                              overflow: TextOverflow.ellipsis
                            ),
                            Text(
                              product.formattedPrice, 
                              style: TextStyle(
                                fontSize: 15.sp, 
                                color: Colors.grey[800]
                              )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: Colors.black, 
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(
                          'Ver Detalles', 
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 13.sp, 
                            fontWeight: FontWeight.bold)
                          ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
