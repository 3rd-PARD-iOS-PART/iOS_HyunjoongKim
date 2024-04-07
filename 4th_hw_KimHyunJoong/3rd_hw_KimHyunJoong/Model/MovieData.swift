//
//  MockData.swift
//  3rd_hw_KimHyunJoong
//
//  Created by 김현중 on 4/1/24.
//
import UIKit
// MovieData 구조체 정의
struct MovieData {
    let title: String
    let posterPath: String
}

// MovieData 구조체의 확장
extension MovieData {
    // 영화 데이터를 가져오는 정적 메서드
    static func fetchMovies(completion: @escaping (Result<[MovieData], Error>) -> Void) {
        // ApiCaller의 shared 인스턴스를 사용하여 영화 데이터를 가져옴
        ApiCaller.shared.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                // 영화 데이터 가져오기 성공한 경우
                // Movie 객체를 MovieData 객체로 매핑
                let movieData = movies.map { movie in
                    MovieData(title: movie.title, posterPath: movie.posterPath ?? "")
                }
                // 완료 핸들러에 성공 결과와 함께 MovieData 배열을 전달
                completion(.success(movieData))
            case .failure(let error):
                // 영화 데이터 가져오기 실패한 경우
                // 완료 핸들러에 실패 결과와 함께 에러를 전달
                completion(.failure(error))
            }
        }
    }
}
