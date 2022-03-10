import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var isConnected: Bool = false
    @Published var canRequestTicket: Bool = true
    @Published var progressValue: Int = 20
}
