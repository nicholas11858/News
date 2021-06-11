//
//  Articles.swift
//  News
//
//  Created by NIKOLAY OSIPOV on 09.06.2021.
//

struct Article: Decodable {
    let title: String
    let description: String
    let urlToImage: String
    let content: String
}
