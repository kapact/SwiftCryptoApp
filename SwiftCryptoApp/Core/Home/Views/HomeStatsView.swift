//
//  HomeStatsView.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 08/12/24.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var viewmodel: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(viewmodel.stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
