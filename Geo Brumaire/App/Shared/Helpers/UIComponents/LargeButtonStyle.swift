import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    var foregroundColor: Color
    var backgroundColor: Color
    
    @Environment(\.isEnabled) var isEnabled
    
    var background: some View {
        RoundedRectangle(cornerRadius: 12,
                         style: .continuous)
            .foregroundColor(backgroundColor)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? foregroundColor.opacity(0.7) : foregroundColor.opacity(1))
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 44, idealHeight: 44)
            .background(!isEnabled ? background.opacity(0.3) : (configuration.isPressed ? background.opacity(0.7) : background.opacity(1)))
    }
}
