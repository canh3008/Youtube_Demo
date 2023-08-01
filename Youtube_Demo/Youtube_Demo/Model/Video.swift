//
//  Video.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation

struct Video: Codable {
    var title: String?
    var thumbnailImageName: String?
    var numberOfViews: Int?
    var channel: Channel?
    var duration: Int?

    enum CodingKeys: String, CodingKey {
        case thumbnailImageName = "thumbnail_image_name"
        case numberOfViews = "number_of_views"
        case title
        case channel
        case duration
    }
}

struct Channel: Codable {
    var name: String?
    var profileImageName: String?


    enum CodingKeys: String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
}
