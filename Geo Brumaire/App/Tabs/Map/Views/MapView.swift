import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    @State var userTrackingMode: MapUserTrackingMode = .follow
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, userTrackingMode: $userTrackingMode)
            
            VStack {
                HStack {
                    Spacer()
                    
                    localizeMeButton
                }
                
                Spacer()
                
                toggleTripButton
            }
            .padding()
        }
    }
}

private extension MapView {
    var localizeMeButton: some View {
        Button {
            viewModel.localizeMe()
        } label: {
            Image(systemName: "location.fill")
                .foregroundColor(Color(uiColor: UIColor.label).opacity(0.7))
                .padding()
                .background(Color(uiColor: UIColor.systemBackground).opacity(0.3))
                .background(.thinMaterial)
                .cornerRadius(12)
                .shadow(color: Color(uiColor: UIColor.label).opacity(0.2), radius: 3)
        }
    }
    
    var toggleTripButton: some View {
        Button {
            viewModel.hasJourneyStarted.toggle()
        } label: {
            Text(viewModel.hasJourneyStarted ? "End trip" : "Start trip")
                .fontWeight(.bold)
        }
        .buttonStyle(LargeButtonStyle(foregroundColor: .white, backgroundColor: viewModel.hasJourneyStarted ? .red : .blue))
    }
}
