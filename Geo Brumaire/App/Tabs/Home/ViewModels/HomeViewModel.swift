import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var isConnected: Bool = false
    @Published var isCongratulationMessagePresented: Bool = false
    @Published var progressValue: Int = 20
    
    var canRequestCoupon: Bool {
        progressValue == 100
    }
    
    func incrementScore() {
        withAnimation(.linear) {
            if progressValue < 100 {
                progressValue += 5
            }
        }
    }
    
    func requestCoupon() {
        withAnimation(.linear) {
            progressValue = 0
        }
        
        isCongratulationMessagePresented = true
    }
}
