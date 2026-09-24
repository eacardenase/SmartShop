//
//  Errors.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/17/26.
//

import Foundation

enum ProductsError: Error {
    case message(String?)
}

enum ProductSaveError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
}
