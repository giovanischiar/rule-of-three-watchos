//
//  Input.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

import Foundation

struct Input: CustomStringConvertible, Hashable {
    let value: String

    init(value: String = "") {
        self.value = value
    }

    init(value: NSNumber?) {
        self.value = value?.stringValue ?? ""
    }

    func characterPushed(_ character: String) -> Input {
        var valueBuilder = value
        let newNumber = value + character

        guard newNumber != "." &&
              newNumber != "," &&
              newNumber.toDoubleLocaleOrNull() != nil else {
            return self
        }

        if !valueBuilder.isEmpty &&
            value != "." &&
            value != "," &&
            value.toDoubleLocaleOrNull() == 0.0 &&
            !newNumber.hasDecimalSeparator() {
            valueBuilder = ""
        }

        valueBuilder.append(character)
        return Input(value: valueBuilder)
    }

    func characterPopped() -> Input {
        guard !value.isEmpty else { return self }
        var valueBuilder = value
        valueBuilder.removeLast()
        return Input(value: valueBuilder)
    }

    func cleared() -> Input {
        return Input(value: "")
    }

    var description: String {
        return value
    }

    static func * (lhs: Input, rhs: Input) -> Input {
        guard let lhsValue = lhs.value.toDoubleLocaleOrNull(),
              let rhsValue = rhs.value.toDoubleLocaleOrNull() else {
            return lhs
        }
        return Input(value: String(lhsValue * rhsValue))
    }

    static func / (lhs: Input, rhs: Input) -> Input {
        guard let lhsValue = lhs.value.toDoubleLocaleOrNull(),
              let rhsValue = rhs.value.toDoubleLocaleOrNull(),
              rhsValue != 0.0 else {
            return lhs
        }
        return Input(value: String(lhsValue / rhsValue))
    }

    func toNumberOrNull() -> NSNumber? {
        if value.hasDecimalSeparator() {
            return value.toDoubleLocaleOrNull() as NSNumber?
        } else {
            return Int(value) as NSNumber?
        }
    }
}
