//
//  Int+Extension.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation

extension Int {
    func convertDecimalNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
