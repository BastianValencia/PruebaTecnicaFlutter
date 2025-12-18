import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../providers/products_provider.dart';
import 'package:enm/features/profile/presentation/providers/profile_provider.dart';
import '../widgets/hero_product_card.dart';
import '../widgets/product_list_card.dart';
import '../widgets/category_chip.dart';

class ProductsListScreen extends ConsumerWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => notifier.loadProducts(),
          color: Colors.black,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 6.w,
                                backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=juan'), // Placeholder
                              ),
                              SizedBox(width: 3.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      final profileState = ref.watch(profileProvider);
                                      final name = profileState.maybeWhen(
                                        data: (state) => state.originalUser.name,
                                        orElse: () => 'Usuario',
                                      );
                                      return Text('Hola, $name', style: TextStyle(color: Colors.grey, fontSize: 16.sp));
                                    }
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 15.sp, color: Colors.grey),
                                      SizedBox(width: 1.w),
                                      Text('Santiago, CL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                                      Icon(Icons.keyboard_arrow_down, size: 16.sp, color: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          FloatingActionButton(
                            shape: const CircleBorder(),
                            onPressed:  (){}, 
                            child: const Icon(Icons.notifications_none)
                          )
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 6.h,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.search, color: Colors.grey, size: 18.sp),
                                  SizedBox(width: 2.w),
                                  const Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Buscar maquinaria...',
                                        hintStyle: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Container(
                            height: 6.h,
                            width: 6.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]
                            ),
                            child: Icon(Icons.tune, color: Colors.grey.shade700,),
                          )
                        ],
                      ),

                      SizedBox(height: 3.h),

                      // Categories Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const CategoryChip('Todos', isSelected: true),
                            const CategoryChip('Excavadoras'),
                            const CategoryChip('Grúas'),
                            const CategoryChip('Camiones'),
                            const CategoryChip('Generadores'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (state.isRefreshing && state.products.isEmpty)
                const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
              else if (state.error != null && state.products.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(state.error!),
                        TextButton(onPressed: () => notifier.loadProducts(), child: const Text("Reintentar")),
                      ],
                    ),
                  ),
                )
              else if (state.products.isNotEmpty) ...[
                // Hero Section (Primer producto destacado)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.h),
                        HeroProductCard(product: state.products.first),
                        SizedBox(height: 4.h),
                        // Section Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Recomendados 🔥', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                            Text('Ver Todo', style: TextStyle(fontSize: 15.sp, color: colors.onSurface, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 2.h,
                      crossAxisSpacing: 4.w,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                         // Saltamos el primero que ya mostramos en Hero
                         if (index >= state.products.length - 1) return null;
                         final product = state.products[index + 1];
                         return ProductListCard(product: product);
                      },
                      childCount: state.products.length - 1,
                    ),
                  ),
                ),
                
                 SliverToBoxAdapter(child: SizedBox(height: 10.h)), // Bottom padding
              ] else 
                 const SliverFillRemaining(child: Center(child: Text("No hay productos disponibles"))),
            ],
          ),
        ),
      ),
    );
  }
}