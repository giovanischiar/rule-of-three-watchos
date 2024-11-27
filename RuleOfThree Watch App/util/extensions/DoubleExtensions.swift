//
//  DoubleExtensions.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 17/11/24.
//

import Foundation

extension Optional<Double> {
    func toFormattedString(decimals: Int = 2) -> String {
        if (self == nil) { return "?" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimals
        return formatter.string(from: self! as NSNumber) ?? "?"
    }
}

extension Double {
    func toFormattedString(decimals: Int = 2) -> String {
        return (self as Optional<Double>).toFormattedString(decimals: decimals)
    }
}
