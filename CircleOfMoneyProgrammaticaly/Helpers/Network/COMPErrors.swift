//
//  COMPErrors.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 4.03.21.
//

enum COMPNetworkError {
    case incorrectUrl
    case networkError(error: Error)
    case serverError(statusCode: Int)
    case parsingError(error: Error)
    case unknown
}
