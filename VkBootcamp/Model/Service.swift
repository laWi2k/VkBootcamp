//
//  Service.swift
//  VkBootcamp
//
//  Created by Daniel on 13.07.2022.
//

struct MainData: Codable {
    let body: Services
    let status: Int
}

struct Services: Codable {
    let services: [Service]
}

struct Service: Codable {
    let appName: String
    let appDescription: String
    let appLink: String
    let iconUrl: String
    
    enum CodingKeys: String, CodingKey {
        case appName = "name"
        case appDescription = "description"
        case appLink = "link"
        case iconUrl = "icon_url"
    }
}
