//
//  NSNumberExtensions.swift
//  RuleOfThree Watch App
//
//  Created by Giovani Schiar on 17/11/24.
//

import Foundation

extension Optional<NSNumber> {
    func stringify() -> String {
        return  self != nil ? "" : self?.stringValue ?? ""
    }
}
