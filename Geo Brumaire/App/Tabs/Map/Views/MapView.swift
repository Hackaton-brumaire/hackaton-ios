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
}
