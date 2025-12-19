import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../domain/entities/product.dart';

class ProductListCard extends StatelessWidget {
  final Product product;

  const ProductListCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(0.05),
               blurRadius: 4,
               offset: const Offset(0, 2),
             )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Image Area
             Expanded(
               child: Stack(
                 children: [
                   Container(
                     width: double.infinity,
                     decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover, 
                        )
                     ),
                   ),
                    // Optional: "Oferta" or Status badge if needed
                 ],
               ),
             ),
             
             // Info Area
             Padding(
               padding: EdgeInsets.all(3.w),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     product.name, 
                     maxLines: 2, 
                     overflow: TextOverflow.ellipsis, 
                     style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp, height: 1, color: Colors.black)
                   ),
                   // Rating
                   SizedBox(height: 1.h),
                   Row(
                     children: [
                       Icon(Icons.star, size: 15.sp, color: Colors.yellow.shade600),
                       Icon(Icons.star, size: 15.sp, color: Colors.yellow.shade600),
                       Icon(Icons.star, size: 15.sp, color: Colors.yellow.shade600),
                       Icon(Icons.star, size: 15.sp, color: Colors.yellow.shade600),
                       Icon(Icons.star_half, size: 15.sp, color: Colors.yellow.shade600),
                       SizedBox(width: 1.w),
                       Text('120', style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
                     ],
                   ),
                   // Price
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline: TextBaseline.alphabetic,
                     children: [
                        Text(
                          product.formattedPrice, 
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                     ],
                   ),
                   Text('Llega mañana', style: TextStyle(fontSize: 13.sp, color: Colors.black54)),
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }
}
