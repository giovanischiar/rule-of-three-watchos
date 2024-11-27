//
//  ArrayExtensions.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 17/11/24.
//

extension Array where Element == Array<Input> {
    func isValid(unknownPosition: (Int, Int)) -> Bool {
        let (i, j) = unknownPosition
        guard let denominator = self[!i][!j].toNumberOrNull() else { return false }
        if (self[i][!j].toNumberOrNull() == nil) { return false }
        if (self[!i][j].toNumberOrNull() == nil) { return false }
        return denominator != 0.0 && denominator != 0
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
