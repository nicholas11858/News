//
//  News.swift
//  News
//
//  Created by NIKOLAY OSIPOV on 09.06.2021.
//

struct News: Decodable {
    let status: String
    let articles: [Article]
}

