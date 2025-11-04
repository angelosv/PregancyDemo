//
//  MainTabView.swift
//  PregancyDemo
//

import SwiftUI
import ReachuUI
import ReachuCore

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
    @StateObject private var campaignManager = CampaignManager.shared
    @State private var isSDKEnabled = ReachuConfiguration.shared.shouldUseSDK
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Reachu SDK Status")) {
                    HStack {
                        Text("SDK Enabled")
                        Spacer()
                        Image(systemName: isSDKEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(isSDKEnabled ? .green : .red)
                    }
                    
                    HStack {
                        Text("Campaign Active")
                        Spacer()
                        Image(systemName: campaignManager.isCampaignActive ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(campaignManager.isCampaignActive ? .green : .red)
                    }
                    
                    HStack {
                        Text("Campaign State")
                        Spacer()
                        Text(campaignStateText)
                            .foregroundColor(campaignStateColor)
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Configured Campaign ID")
                        Spacer()
                        Text("\(ReachuConfiguration.shared.liveShowConfiguration.campaignId)")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    
                    if let campaign = campaignManager.currentCampaign {
                        HStack {
                            Text("Active Campaign ID")
                            Spacer()
                            Text("\(campaign.id)")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    HStack {
                        Text("WebSocket Connected")
                        Spacer()
                        Image(systemName: campaignManager.isConnected ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(campaignManager.isConnected ? .green : .gray)
                    }
                }
                
                Section(header: Text("Components Status")) {
                    HStack {
                        Text("Cart Indicator")
                        Spacer()
                        Image(systemName: shouldShowComponents ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(shouldShowComponents ? .green : .gray)
                    }
                    
                    HStack {
                        Text("Product Slider")
                        Spacer()
                        Image(systemName: shouldShowComponents ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(shouldShowComponents ? .green : .gray)
                    }
                    
                    HStack {
                        Text("Checkout")
                        Spacer()
                        Image(systemName: shouldShowComponents ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(shouldShowComponents ? .green : .gray)
                    }
                }
                
                Section(header: Text("Active Components")) {
                    if campaignManager.activeComponents.isEmpty {
                        Text("No active components")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    } else {
                        ForEach(campaignManager.activeComponents, id: \.id) { component in
                            HStack {
                                Text(component.type.capitalized)
                                Spacer()
                                Text("ID: \(component.id)")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                isSDKEnabled = ReachuConfiguration.shared.shouldUseSDK
            }
        }
    }
    
    private var shouldShowComponents: Bool {
        ReachuConfiguration.shared.shouldUseSDK && campaignManager.isCampaignActive
    }
    
    private var campaignStateText: String {
        switch campaignManager.campaignState {
        case .upcoming: return "Upcoming"
        case .active: return "Active"
        case .ended: return "Ended"
        }
    }
    
    private var campaignStateColor: Color {
        switch campaignManager.campaignState {
        case .upcoming: return .orange
        case .active: return .green
        case .ended: return .red
        }
    }
}

