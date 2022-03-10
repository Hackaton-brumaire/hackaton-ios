import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        List {
            Section {
                VStack {
                    scooterImage
                    
                    // PUT /api/user/me
                    isConnectedLabel
                }
                .padding(.vertical)
            }
            
            // GET /api/user/me
            Section {
                VStack(spacing: 8) {
                    progressBar
                    
                    remainingDistanceLabel
                    
                    if viewModel.canRequestTicket {
                        requestCouponButton
                            .padding(.top)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Geo Brumaire")
    }
}

private extension HomeView {
    var scooterImage: some View {
        Image("scooter")
            .resizable()
            .scaledToFit()
    }
    
    var isConnectedLabel: some View {
        HStack {
            Circle()
                .fill(viewModel.isConnected ? Color.green : Color.red)
                .frame(width: 14, height: 14)
            
            Text(viewModel.isConnected ? "Connected" : "Not connected")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(viewModel.isConnected ? .green : .red)
        }
        .onTapGesture {
            viewModel.isConnected.toggle()
        }
    }
    
    var progressBar: some View {
        ProgressBarView(value: $viewModel.progressValue)
            .frame(height: 20)
            .padding(.horizontal)
            .shadow(color: .green.opacity(0.7), radius: 8, y: 4)
    }
    
    var remainingDistanceLabel: some View {
        VStack(spacing: 0) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("\(100 - viewModel.progressValue)")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                
                Text("KM")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color(uiColor: UIColor.secondaryLabel))
            }
            
            Text("REMAINING BEFORE NEXT COUPON")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color(uiColor: UIColor.secondaryLabel))
        }
    }
    var requestCouponButton: some View {
        Button {
            print("ok")
        } label: {
            HStack {
                Image(systemName: "ticket.fill")
                
                Text("Request my coupon")
                    .fontWeight(.bold)
            }
        }
        .buttonStyle(LargeButtonStyle(foregroundColor: .white, backgroundColor: .blue))
    }
}
