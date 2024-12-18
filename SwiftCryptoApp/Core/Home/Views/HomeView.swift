//
//  HomeView.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 06/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showAddPortfolioView: Bool = false
    @State private var showSettingsView: Bool = false
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack{
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showAddPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(viewModel)
                })
            
            // Content layer
            VStack{
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }else {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
        .background(
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: { EmptyView() }
            )
        )
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
            .environmentObject(DeveloperPreview.homeVM)
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio{
                        showAddPortfolioView.toggle()
                    }else{
                        showSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List{
            ForEach(viewModel.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(viewModel.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnTitles: some View {
        HStack{
            HStack(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default){
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default){
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack(spacing: 4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default){
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2)){
                    viewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
}
