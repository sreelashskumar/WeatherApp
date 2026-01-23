//
//  HTTPError.swift
//  Utilities
//
//  Created by Sreelash Sasikumar on 22/01/26.
//
 
import Foundation

enum HttpError: Error {
    case invalidURL
    case networkError(_ underlyingError: Error)
    case serverError(_ statusCode: Int)
    case decodeError(_ underlyingError: Error)
    case unknownError
}

extension HttpError: LocalizedError {
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError(let err):
            return "Network error: \(err.localizedDescription)"
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .decodeError(let error):
            return "Decode error: \(error.localizedDescription)"
        case .unknownError:
            return "Unknown error"
        }
    }
}
