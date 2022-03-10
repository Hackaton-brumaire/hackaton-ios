import Foundation

struct GetChargingStationsRequest {
    let session = URLSession.shared
    var request: URLRequest
    
    init(latitude: Double, longitude: Double) throws {
        var urlComponents = URLComponents(string: "https://api.openchargemap.io/v3/poi")
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: "123"),
            URLQueryItem(name: "camelcase", value: "true"),
            URLQueryItem(name: "compact", value: "true"),
            URLQueryItem(name: "verbose", value: "false"),
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)")
        ]
        
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }

        self.request = URLRequest(url: url)
    }
    
    func perform() async throws -> [ChargingStationData] {
        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode([ChargingStationData].self, from: data)
    }
}
