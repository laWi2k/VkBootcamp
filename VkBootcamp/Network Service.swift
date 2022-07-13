//
//  Network Service.swift
//  VkBootcamp
//
//  Created by Daniel on 13.07.2022.
//
import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func parseJson(_ urlString: String, completion: @escaping (Result<MainData, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {return}
            do {
                let apps = try JSONDecoder().decode(MainData.self, from: data)
                completion(.success(apps))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
