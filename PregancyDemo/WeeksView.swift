//
//  WeeksView.swift
//  PregancyDemo
//

import SwiftUI
import ReachuCore
import ReachuUI
import ReachuDesignSystem

struct WeeksView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showProductStore = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Campaign Components - Solo componentes de Reachu
                    // Los componentes manejan su propio padding horizontal
                    
                    // Offer Banner Dynamic (loads from backend)
                    VStack(alignment: .leading, spacing: ReachuSpacing.sm) {
                        Text("ROfferBannerDynamic (Backend)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        Text("Automatically loads from backend via ComponentManager")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        ROfferBannerDynamic(
                            onNavigateToStore: {
                                // Navigate to store view
                                showProductStore = true
                            }
                        )
                            .padding(.horizontal, ReachuSpacing.md)
                    }
                    
                    // Product Banner (auto-configured)
                    VStack(alignment: .leading, spacing: ReachuSpacing.sm) {
                        Text("RProductBanner")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        Text("Auto-configured from backend campaign")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        RProductBanner()
                    }
                    
                    // Product Carousel Comparison - Full vs Compact vs Horizontal Layouts
                    VStack(alignment: .leading, spacing: ReachuSpacing.md) {
                        Text("RProductCarousel - Comparison Layouts")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        Text("Manual override for testing different layouts")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        VStack(alignment: .leading, spacing: ReachuSpacing.md) {
                            Text("• Full Layout")
                                .font(.headline)
                                .padding(.horizontal, ReachuSpacing.md)
                            
                            RProductCarousel(layout: "full")
                            
                            Text("• Compact Layout")
                                .font(.headline)
                                .padding(.horizontal, ReachuSpacing.md)
                            
                            RProductCarousel(layout: "compact")
                            
                            Text("• Horizontal Layout")
                                .font(.headline)
                                .padding(.horizontal, ReachuSpacing.md)
                            
                            RProductCarousel(layout: "horizontal")
                        }
                    }
                    
                    // Product Carousel (auto-configured - uses layout from backend)
                    VStack(alignment: .leading, spacing: ReachuSpacing.sm) {
                        Text("RProductCarousel")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        Text("Auto-configured from backend | Uses layout from campaign config")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        RProductCarousel()
                    }
                    
                    // Product Carousel with specific component ID
                    VStack(alignment: .leading, spacing: ReachuSpacing.sm) {
                        Text("RProductCarousel (ID: 1081aa1e)")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        Text("Using specific component ID: 1081aa1e-e9b6-4855-8ed9-70e4f630610d")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        RProductCarousel(componentId: "1081aa1e-e9b6-4855-8ed9-70e4f630610d")
                    }
                    
                    // Product Slider (legacy)
                    VStack(alignment: .leading, spacing: ReachuSpacing.sm) {
                        Text("RProductSlider")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        Text("Legacy component | Manual config: layout=.cards")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        RProductSlider(
                            title: "Recommended Products",
                            layout: .cards,
                            showSeeAll: false,
                            onProductTap: { product in
                                print("Tapped product: \(product.title)")
                            },
                            onAddToCart: { product in
                                Task {
                                    await cartManager.addProduct(product)
                                }
                            },
                            currency: cartManager.currency,
                            country: cartManager.country
                        )
                        .environmentObject(cartManager)
                    }
                    
                    // Product Store (auto-configured)
                    VStack(alignment: .leading, spacing: ReachuSpacing.sm) {
                        Text("RProductStore")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        Text("Auto-configured from backend campaign")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, ReachuSpacing.md)
                        
                        RProductStore()
                    }
                    
                    Spacer(minLength: 100) // Space for tab bar
                }
                .padding(.top, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .sheet(isPresented: $showProductStore) {
                NavigationView {
                    ProductStoreView()
                        .environmentObject(cartManager)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Close") {
                                    showProductStore = false
                                }
                            }
                        }
                }
            }
        }
    }
}

// MARK: - Product Store View
struct ProductStoreView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ReachuSpacing.md) {
                Text("Shop")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.horizontal, ReachuSpacing.md)
                    .padding(.top, ReachuSpacing.md)
                
                RProductStore()
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

