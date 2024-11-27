//
//  CrossMuliplierLayout.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 17/11/24.
//

import SwiftUI

struct CrossMultiplierLayout: View {
    let values: [[AnyView]]
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                values[0][0]
                values[0][1]
            }
            
            Image(systemName: "xmark")
                .foregroundStyle(Color.init(hex: "#A8A387"))
                .padding(0)
            
            HStack(spacing: 15) {
                values[1][0]
                values[1][1]
            }
        }
    }
}
