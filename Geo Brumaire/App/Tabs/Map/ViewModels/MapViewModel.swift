import MapKit
import CoreLocation
import SwiftUI

class MapViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var state: LoadingState = .loading
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.848943464008116, longitude: 2.3893738254486143), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    @Published var chargingStations: [ChargingStation] = []
    
    private let locationManager = CLLocationManager()
    private var locations: [CLLocationCoordinate2D] = []
    private var shouldUpdateUserlocation = true
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        localizeMe()
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.shouldUpdateUserlocation = true
        }
    }
    
    func localizeMe() {
        guard let location = locations.last else {
            return
        }
        
        withAnimation {
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }
    
    @MainActor func getChargingStations() async {
        state = .loading
        do {
            let request = try GetChargingStationsRequest(latitude: region.center.latitude, longitude: region.center.longitude)
            let remoteChargingStations = try await request.perform()
            chargingStations = remoteChargingStations.map { ChargingStation(title: $0.addressInfo.title,
                                                                            latitude: $0.addressInfo.latitude,
                                                                            longitude: $0.addressInfo.longitude) }
            state = .success
        } catch {
            state = .failure(error)
        }
    }
    
    // MARK: - Location manager
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard shouldUpdateUserlocation, let location = locations.last else {
            return
        }
        
        self.locations.append(location.coordinate)
        
        locationManager.stopUpdatingLocation()
        shouldUpdateUserlocation = false
    }
}
