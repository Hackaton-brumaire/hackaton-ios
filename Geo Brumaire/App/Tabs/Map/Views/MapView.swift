import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                userTrackingMode: $viewModel.userTrackingMode,
                annotationItems: viewModel.chargingStations) { chargingStation in
                MapMarker(coordinate: chargingStation.coordinates)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    localizeMeButton
                }
                
                Spacer()
            }
            .padding()
        }
        .task {
            await viewModel.getChargingStations()
        }
        .overlay {
            if case .loading = viewModel.state {
                loadingView
            }
        }
    }
}

private extension MapView {
    var loadingView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white.opacity(0.1))
            
            ProgressView()
                .padding(20)
                .background(Color(uiColor: UIColor.systemBackground).opacity(0.3))
                .background(.thinMaterial)
                .cornerRadius(12)
                .shadow(color: Color(uiColor: UIColor.label).opacity(0.2), radius: 3)
        }
    }
    
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
}
