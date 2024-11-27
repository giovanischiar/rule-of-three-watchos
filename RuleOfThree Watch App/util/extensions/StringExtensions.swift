//
//  StringExtensions.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 17/11/24.
//

extension String {
    func hasDecimalSeparator() -> Bool {
        return self.range(of: "[\\.,]", options: .regularExpression) != nil
    }

    func toDoubleLocaleOrNull() -> Optional<Double> {
        var this = self
        this.replace(",", with: ".")
        return Double(this)
    }
}
