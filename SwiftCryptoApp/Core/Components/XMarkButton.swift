//
//  XMarkButton.swift
//  SwiftCryptoApp
//
//  Created by Akshay kumar shaw on 09/12/24.
//

import SwiftUI

struct XMarkButton: View {
    
    var onClick: () -> Void
    
    var body: some View {
        Button(action: {
                onClick()
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }
        )
    }
}

#Preview {
    XMarkButton{}
}
