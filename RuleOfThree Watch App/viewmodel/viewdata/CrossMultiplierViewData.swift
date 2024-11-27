//
//  CrossMultiplierViewData.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

struct CrossMultiplierViewData {
    var valueAt00: String = ""
    var valueAt01: String = ""
    var valueAt10: String = ""
    var valueAt11: String = ""
    var unknownPosition: (Int, Int) = (1, 1)

    var values: [[String]] {
        get {
            return [[valueAt00, valueAt01], [valueAt10, valueAt11]]
        }
    }

    var result: ResultViewData {
        let (i, j) = unknownPosition
        var result = Double(values[i][j]).toFormattedString()
        if (values[i][j].isEmpty) {
            result = "?"
        }
        
        return ResultViewData(
            result: result,
            _result: Double(values[i][j]) ?? 0.0
        )
    }

    func isNotEmpty() -> Bool {
        let (i, j) = unknownPosition
        return !values[!i][j].isEmpty ||
               !values[i][!j].isEmpty ||
               !values[!i][!j].isEmpty
    }
}

