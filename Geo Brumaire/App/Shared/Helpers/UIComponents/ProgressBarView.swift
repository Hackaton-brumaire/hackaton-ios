import SwiftUI

struct ProgressBarView: View {
    @Binding var value: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle()
                    .frame(width: min(CGFloat(self.value) * geometry.size.width / 100, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.green)
//                    .animation(.linear)
            }
            .cornerRadius(45.0)
        }
    }
}
