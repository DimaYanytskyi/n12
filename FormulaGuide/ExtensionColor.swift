import Foundation
import SwiftUI

extension Color {
    init(red: Double, green: Double, blue: Double, opacit: Double = 1.0) {
        self.init(
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            opacity: opacit
        )
    }
}
