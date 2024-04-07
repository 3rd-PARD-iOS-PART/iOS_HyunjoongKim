//
//  ApiCaller.swift
//  3rd_hw_KimHyunJoong
//
//  Created by 김현중 on 4/7/24.
//
import Foundation

// ApiCaller 구조체 정의
struct ApiCaller {
    
    static let shared = ApiCaller()
    // 초기화 메서드를 private으로 선언하여 외부에서 인스턴스 생성 방지
    private init() {}
    
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "c513f9a2b6558dd972d74e4cbafe8e56"
    
    // 개봉 예정 영화 데이터를 가져오는 메서드
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let endpoint = "\(baseURL)/discover/movie?api_key=\(apiKey)&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // URL 세션을 사용하여 데이터 요청
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 데이터가 없는 경우 완료 핸들러에 실패 결과 전달
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            // JSON 디코더를 사용하여 데이터 디코딩
            do {
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        // 데이터 요청 시작
        task.resume()
    }
}

// 영화 응답 데이터를 나타내는 구조체
struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// 영화 데이터를 나타내는 구조체
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
}
