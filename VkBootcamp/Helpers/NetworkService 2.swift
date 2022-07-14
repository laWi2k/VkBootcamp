//
//  Network Service.swift
//  VkBootcamp
//
//  Created by Daniel on 13.07.2022.
//
import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    enum NetworkError: String, Error {
        case invalidURL = "Некорректный URL"
        case invalidData = "Некорректные данные"
        case failedFetching = "Ошибка загрузки данных"
        case failedDecoding = "Невозможно преобразование в тип"
    }
    
    private init() {}
    
    func fetchAppsData(_ urlString: String, completion: @escaping (Result<MainData, NetworkError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(NetworkError.failedFetching))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let apps = try JSONDecoder().decode(MainData.self, from: data)
                completion(.success(apps))
            } catch {
                completion(.failure(NetworkError.failedDecoding))
            }
        }.resume()
    }
}
