import Foundation

struct LoginRequest {
    let session = URLSession.shared
    var request: URLRequest
    
    init(username: String, password: String) throws {
        guard let url = URL(string: "https://geo-brumaire-api.herokuapp.com/api/auth/login") else {
            throw URLError(.badURL)
        }
        
        var body: [String : Any] = [:]
        body["username"] = username
        body["password"] = password
        
        let data = try JSONSerialization.data(withJSONObject: body, options: [])

        request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    func perform() async throws -> String {
        let (_, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse,
              let url = response.url,
              let headers = response.allHeaderFields as? [String : String],
              let cookie = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url).first?.value else {
            throw RequestError.decodingError
        }
        return cookie
    }
}
