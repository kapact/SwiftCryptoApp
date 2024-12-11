//
//  SettingsView.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 11/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let defaultUrl = URL(string: "https://www.google.com")!
    let githubUrl = URL(string: "https://github.com/kapact/SwiftCryptoApp")!
    let swiftfullUrl = URL(string: "https://www.youtube.com/@SwiftfulThinking/featured")!
    let coinGekkoUrl = URL(string: "https://www.coingecko.com")!
    
    var body: some View {
        NavigationView {
            List {
                profileSection
                coinGekkoSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(onClick: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView {
    
    private var profileSection: some View {
        Section(header: Text("Application"), content: {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app is made to learn swiftUI and architectural patterns of IOS development (Special thanks to @SwiftfulThinking)")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Check out code on github 🔥", destination: githubUrl)
            Link("Swiftfull Thinking 🤙", destination: swiftfullUrl)
        })
    }
    
    private var coinGekkoSection: some View {
        Section(header: Text("Coin Gecko"), content: {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurreny data that is used in this app comes from a free API from CoinGecko! ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit coin gecko 🦎", destination: coinGekkoUrl)
        })
    }
    
}
