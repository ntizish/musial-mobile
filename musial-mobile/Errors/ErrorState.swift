//
//  ErrorState.swift
//  musial-mobile
//
//  Created by Danil Perednja on 28.03.2024.
//

import Foundation

enum ErrorState
{
    case Error(message: String)
    case Success(message: String)
    case None // no error state
}

