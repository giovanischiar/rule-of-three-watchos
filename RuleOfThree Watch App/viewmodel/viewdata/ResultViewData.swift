//
//  ResultViewData.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 10/11/24.
//

struct ResultViewData {
    let result: String
    private let _result: Double
    
    init(result: String, _result: Double) {
        self.result = result
        self._result = _result
    }
    
    func longerResult(decimals: Int = 2) -> String {
        return _result.toFormattedString(decimals: decimals)
    }
}
