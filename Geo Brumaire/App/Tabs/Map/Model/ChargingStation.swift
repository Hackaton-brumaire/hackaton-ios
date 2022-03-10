import CoreLocation

struct ChargingStation: Identifiable {
    var id = UUID()
    var title: String
    var latitude: Double
    var longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
