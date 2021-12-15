//
//  Movie.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 12/12/2021.
//

import ObjectMapper

struct MovieApiResponse: Mappable {
    
    var page: Int?
    var numberOfResults: Int?
    var numberOfPages: Int?
    var movies: [Movie] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        page <- map["page"]
        numberOfResults <- map["total_results"]
        numberOfPages <- map["total_pages"]
        movies <- map["results"]
    }
    
}

struct Movie: Mappable {
    var id: Int?
    var posterPath: String?
    var backdrop: String?
    var title: String?
    var releaseDate: String?
    var rating: Double?
    var overview: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        posterPath <- map["poster_path"]
        backdrop <- map["backdrop_path"]
        title <- map["title"]
        releaseDate <- map["release_date"]
        rating <- map["vote_average"]
        overview <- map["overview"]
    }
}

//struct MovieApiResponse: Decodable {
//    let page: Int
//    let numberOfResults: Int
//    let numberOfPages: Int
//    let movies: [Movie]
//
//    private enum MovieApiResponseCodingKeys: String, CodingKey {
//        case page
//        case numberOfResults = "total_results"
//        case numberOfPages = "total_pages"
//        case movies = "results"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
//
//        page = try container.decode(Int.self, forKey: .page)
//        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
//        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
//        movies = try container.decode([Movie].self, forKey: .movies)
//
//    }
//}
//
//struct Movie: Decodable {
//    let id: Int
//    let posterPath: String
//    let backdrop: String
//    let title: String
//    let releaseDate: String
//    let rating: Double
//    let overview: String
//
//    enum MovieCodingKeys: String, CodingKey {
//        case id
//        case posterPath = "poster_path"
//        case backdrop = "backdrop_path"
//        case title
//        case releaseDate = "release_date"
//        case rating = "vote_average"
//        case overview
//    }
//
//    init(from decoder: Decoder) throws {
//        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
//
//        id = try movieContainer.decode(Int.self, forKey: .id)
//        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
//        backdrop = try movieContainer.decode(String.self, forKey: .backdrop)
//        title = try movieContainer.decode(String.self, forKey: .title)
//        releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
//        rating = try movieContainer.decode(Double.self, forKey: .rating)
//        overview = try movieContainer.decode(String.self, forKey: .overview)
//    }
//}
