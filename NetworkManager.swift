
    
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private let token = "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"
    
    func GetRequest<T: Decodable>(urlString: String, responseModel: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let jsonDecoder: JSONDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                
                let decoded = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
