//
//  NetworkService.swift
//  News
//
//  Created by NIKOLAY OSIPOV on 10.06.2021.
//

import Foundation

class NetworkService {
    func getNewNews(urlstring: String, completion: @escaping (Result<News, Error>) -> Void) {

        guard let url = URL(string: urlstring) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else { return }
                do {
                    let news =  try JSONDecoder().decode(News.self, from: data)
                    completion(.success(news))
                } catch let jsonError {
                    print(jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
