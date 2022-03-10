struct ChargingStationData: Decodable {
    var addressInfo: AddressInfo
    
    struct AddressInfo: Decodable {
        var title: String
        var latitude: Double
        var longitude: Double
    }
}
