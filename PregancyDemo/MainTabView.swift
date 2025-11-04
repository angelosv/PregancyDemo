//
//  MainTabView.swift
//  PregancyDemo
//

import SwiftUI
import ReachuUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @StateObject private var cartManager = CartManager()
    @StateObject private var checkoutDraft = CheckoutDraft()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            WeeksView()
                .tabItem {
                    Label("Weeks", systemImage: selectedTab == 0 ? "face.smiling.fill" : "face.smiling")
                }
                .tag(0)
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(1)
            
            ToolsView()
                .tabItem {
                    Label("Tools", systemImage: "wrench")
                }
                .tag(2)
            
            ChecklistsView()
                .tabItem {
                    Label("Checklists", systemImage: "checklist")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(4)
        }
        .onAppear {
            // Customize tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            
            // Selected tab color (orange)
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemOrange
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.systemOrange
            ]
            
            // Unselected tab color
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.secondaryLabel
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.secondaryLabel
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .environmentObject(cartManager)
        .environmentObject(checkoutDraft)
        .sheet(isPresented: $cartManager.isCheckoutPresented) {
            RCheckoutOverlay()
                .environmentObject(cartManager)
                .environmentObject(checkoutDraft)
        }
        .overlay {
            // Global floating cart indicator
            RFloatingCartIndicator(
                customPadding: EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 100,
                    trailing: 16
                )
            )
            .environmentObject(cartManager)
        }
    }
}

// MARK: - Placeholder Views

struct CalendarView: View {
    var body: some View {
        NavigationView {
            Text("Calendar")
                .navigationTitle("Calendar")
        }
    }
}

struct ToolsView: View {
    var body: some View {
        NavigationView {
            Text("Tools")
                .navigationTitle("Tools")
        }
    }
}

struct ChecklistsView: View {
    var body: some View {
        NavigationView {
            Text("Checklists")
                .navigationTitle("Checklists")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Text("Settings")
                .navigationTitle("Settings")
        }
    }
}

