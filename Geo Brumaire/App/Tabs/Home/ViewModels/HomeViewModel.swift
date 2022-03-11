import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var isConnected: Bool = false
    @Published var isCongratulationMessagePresented: Bool = false
    @Published var progressValue: Int = 80
    
    var canRequestCoupon: Bool {
        progressValue == 100
    }
    
    func incrementScore() {
        if isConnected && progressValue < 100 {
            withAnimation(.linear) {
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
