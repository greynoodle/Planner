//
//  SymbolStyling.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import Foundation
import SwiftUI

struct SymbolStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .imageScale(.large)
            .symbolRenderingMode(.monochrome)
    }
}

extension View {
    func symbolStyling() -> some View {
        modifier(SymbolStyling())
    }
}
