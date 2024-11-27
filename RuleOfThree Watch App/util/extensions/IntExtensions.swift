//
//  IntExtensions.swift
//  RuleOfThree
//
//  Created by Giovani Schiar on 17/11/24.
//

infix operator !

extension Int {
    static prefix func !(value: Int) -> Int {
        return (value != 0) ? 0 : 1
    }
}

