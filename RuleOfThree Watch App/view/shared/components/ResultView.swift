//
//  ResultView.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 17/11/24.
//

import SwiftUI

struct ResultView: View {
    let displayValue: ResultViewData
    
    var body: some View {
        Text(displayValue.result)
            .frame(width: 60, height: 60)
            .foregroundColor(Color.init(hex: "#FF3CC7"))
    }
}
