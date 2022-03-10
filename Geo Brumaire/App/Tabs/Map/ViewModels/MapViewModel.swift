import MapKit
import CoreLocation
import SwiftUI

class MapViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published var hasJourneyStarted = false
    
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
    
    func startTrip() {
        
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
