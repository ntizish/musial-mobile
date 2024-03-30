//
//  PrimaryButton.swift
//  musial-mobile
//
//  Created by Danil Perednja on 30.03.2024.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        Button(action: clicked) { /// call the closure here
            Text(text).frame(maxWidth: .infinity).font(.custom("Fugue-Regular", size: 20))
        }.foregroundColor(Color.white)
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Constants.Colors.accentOrangeColor)
            .cornerRadius(30)
    }
}
