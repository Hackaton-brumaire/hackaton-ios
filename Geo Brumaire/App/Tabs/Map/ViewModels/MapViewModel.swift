import MapKit
import CoreLocation
import SwiftUI

class MapViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published var userTrackingMode: MapUserTrackingMode = .follow
    @Published var chargingStations: [ChargingStation] = [
        ChargingStation(title: "Nation 1", latitude: 48.849904, longitude: 2.387477),
        ChargingStation(title: "Nation 2", latitude: 48.847641, longitude: 2.393211)
    ]
    
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
