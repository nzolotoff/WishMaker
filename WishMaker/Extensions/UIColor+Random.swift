//
//  Extensions.swift
//  HW 1 - iOS Course
//
//  Created by Nikita Zolotov on 09.10.2024.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
}
