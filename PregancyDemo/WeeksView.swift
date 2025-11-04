//
//  WeeksView.swift
//  PregancyDemo
//

import SwiftUI
import ReachuCore
import ReachuUI

struct WeeksView: View {
    @State private var currentWeek = 1
    @State private var showInfoBanner = true
    @State private var showGiftsBanner = true
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Navigation
                    WeekHeaderView(currentWeek: $currentWeek)
                    
                    // Top Info Cards
                    TopInfoCardsView()
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    
                    // Info Banner
                    if showInfoBanner {
                        InfoBannerView(isVisible: $showInfoBanner)
                            .padding(.horizontal, 16)
                    }
                    
                    // Main Content Cards
                    MainContentCardsView()
                        .padding(.horizontal, 16)
                    
                    // Gifts Banner
                    if showGiftsBanner {
                        GiftsBannerView(isVisible: $showGiftsBanner)
                            .padding(.horizontal, 16)
                    }
                    
                    // Reachu Product Slider
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recommended Products")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 16)
                        
                        RProductSlider(
                            title: "For Your Pregnancy",
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
                    .padding(.top, 8)
                    
                    Spacer(minLength: 100) // Space for tab bar
                }
                .padding(.top, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Week Header View

struct WeekHeaderView: View {
    @Binding var currentWeek: Int
    
    var body: some View {
        HStack {
            // Left arrow
            Button(action: { 
                if currentWeek > 1 { currentWeek -= 1 }
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(width: 44, height: 44)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer()
            
            // Week info
            VStack(spacing: 4) {
                Text("\(currentWeek) week")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Obstetric term")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Right arrow
            Button(action: { 
                if currentWeek < 42 { currentWeek += 1 }
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(width: 44, height: 44)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - Top Info Cards View

struct TopInfoCardsView: View {
    let cards = [
        InfoCard(
            title: "Your baby's growth",
            icon: "figure.child",
            color: Color.pink.opacity(0.2),
            borderColor: .orange
        ),
        InfoCard(
            title: "All about you",
            icon: "figure.walk",
            color: Color.purple.opacity(0.2),
            borderColor: .orange
        ),
        InfoCard(
            title: "Nutrition advice",
            icon: "leaf.fill",
            color: Color.yellow.opacity(0.2),
            borderColor: .orange
        ),
        InfoCard(
            title: "Tips for your term",
            icon: "heart.fill",
            color: Color.green.opacity(0.2),
            borderColor: .orange
        )
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(cards.indices, id: \.self) { index in
                    cards[index]
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

struct InfoCard: View {
    let title: String
    let icon: String
    let color: Color
    let borderColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(.primary)
                .frame(height: 60)
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 100, height: 120)
        .background(color)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Info Banner View

struct InfoBannerView: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Tap! Here's even more interesting information about your pregnancy and helpful tips. Read new stories every day!")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isVisible = false
                }
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
                    .frame(width: 24, height: 24)
                    .background(Color(.systemGray4))
                    .clipShape(Circle())
            }
        }
        .padding(16)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Main Content Cards View

struct MainContentCardsView: View {
    var body: some View {
        HStack(spacing: 12) {
            YourBabyCard()
            SizeCard()
        }
    }
}

struct YourBabyCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your baby")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Expected due date")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("11 August 2026")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            // Center illustration placeholder
            HStack {
                Spacer()
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
                    .overlay(
                        Image(systemName: "circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white.opacity(0.8))
                    )
                Spacer()
            }
            .padding(.vertical, 20)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Fetal term")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("0w 0d")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
        .padding(20)
        .frame(height: 280)
        .background(
            LinearGradient(
                colors: [
                    Color.orange.opacity(0.9),
                    Color.orange.opacity(0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct SizeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Size")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Like a ground")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
            
            // Center illustration placeholder
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white.opacity(0.6))
                }
                Spacer()
            }
            .padding(.vertical, 20)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Length")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("0cm")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .padding(20)
        .frame(height: 280)
        .background(
            LinearGradient(
                colors: [
                    Color.yellow.opacity(0.8),
                    Color.green.opacity(0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Gifts Banner View

struct GiftsBannerView: View {
    @Binding var isVisible: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Get only useful gifts")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Add everything you need to your wish list and share it with your loved ones")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.white.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Button(action: {}) {
                        Text("Create a list")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
                
                // Image placeholder
                VStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.white.opacity(0.3))
                }
                .frame(width: 80)
            }
            .padding(20)
            
            VStack {
                HStack {
                    Spacer()
                    Text("#CommissionsEarned")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.trailing, 8)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white.opacity(0.8))
                            .frame(width: 24, height: 24)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(8)
        }
        .frame(height: 160)
        .background(
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.8),
                    Color.blue.opacity(0.6)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
