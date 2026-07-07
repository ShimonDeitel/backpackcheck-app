import SwiftUI

/// teal and tangerine, playful and energetic - bespoke palette for Backpack Checklist.
enum Theme {
    static let accent = Color("AccentColor")
    static let background = Color("BackgroundColor")
    static let secondaryAccent = Color(hex: "#FF9F1C")
    static let cardBackground = Color(hex: "#0A1414").opacity(0.6)

    static func font(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }

    static let titleFont = font(28, weight: .bold)
    static let headlineFont = font(18, weight: .semibold)
    static let bodyFont = font(15, weight: .regular)
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255.0
        let g = Double((v >> 8) & 0xFF) / 255.0
        let b = Double(v & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
    }
}
