//
//  Result.swift
//  Adapted from http://alisoftware.github.io/swift/async/error/2016/02/06/async-errors/
//
//  Created by Sam Oakley on 28/11/2016.
//  Copyright © 2016 3Squared. All rights reserved.
//
import Foundation


/// An enum that contains a result. The result can be of type T, or it may be an error.
///
/// - success: If the result is successful, will contain a non-optional value of type T
/// - failure: If the result is a failure, will contain an Error
public enum Result<T> {
    case success(T)
    case failure(Error)
    
    
    /// Call to convert the enum into either the value T or rethrow the error.
    /// Use if you want to deal with the result using the do-catch pattern.
    ///
    /// - throws: The error that caused the failure
    ///
    /// - returns: The successful result of type T
    public func resolve() throws -> T {
        switch self {
        case .success(let value): return value
        case .failure(let error): throw error
        }
    }
    
    
    /// Construct a Result using a block that can either return T or throw.
    /// .Success if the expression returns a value or a .Failure if it throws
    ///
    /// - parameter throwingExpr: A closure that returns a value of type T or throws
    ///
    /// - returns: A Result
    public init( _ throwingExpr: () throws -> T) {
        do {
            let value = try throwingExpr()
            self = .success(value)
        } catch {
            self = .failure(error)
        }
    }
    
    
    /// Allows you to handle both success and failure of a result and return a value of the same type in either case.
    ///
    /// - Parameters:
    ///   - success: A closure called with the value when the result is .success, returning an appropriate value or Void.
    ///   - failure: A closure called with the error when the result is .failure, returning an appropriate value or Void.
    @discardableResult
    public func fold<U>(_ success: @escaping (T) -> U, _ failure: @escaping (Error) -> U) -> U {
        switch self {
        case .success(let value):
            return success(value)
        case .failure(let error):
            return failure(error)
        }
    }
    
    
    /// Returns a result containing the value of mapping the given closure
    /// over the result's success value.
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts the
    ///   success value of the result as its parameter and returns or throws
    ///   a transformed value of the same or of a different type.
    /// - Returns: A result containing the transformed element.
    @discardableResult
    public func map<U>(_ transform: @escaping (T) -> U) -> Result<U> {
        switch self {
        case .success(let value):
            return Result<U> { return transform(value) }
        case .failure(let error):
            return Result<U> { throw error }
        }
    }

    /// Returns a result containing the value of mapping the given closure
    /// over the result's failure error.
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts the
    ///   failure error of the result as its parameter and returns
    ///   a transformed value of the same type or throws.
    /// - Returns: A result containing the transformed element.
    @discardableResult
    public func mapError(_ transform: @escaping (Error) -> T) -> Result<T> {
        switch self {
        case .success(let value):
            return Result { return value }
        case .failure(let error):
            return Result { return transform(error) }
        }
    }
    
    /// Returns a result containing the value of mapping the given closure
    /// over the result.
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts the
    ///   the result as its parameter and returns or throws
    ///   a transformed result of the same or of a different type.
    /// - Returns: A transformed result.
    @discardableResult
    public func flatMap<U>(_ transform: @escaping (T) -> Result<U>) -> Result<U> {
        return Result.flatten(result: map(transform))
    }
    
    /// Returns a result containing the value of mapping the given closure
    /// over the result, only if the result contains an error.
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts the
    ///   the result as its parameter and returns or throws
    ///   a transformed result of the same or of a different type.
    /// - Returns: A transformed result.
    @discardableResult
    public func flatMapError(_ transform: @escaping (Error) -> Result<T>) -> Result<T> {
        switch self {
        case .success(let value):
            return Result { return value }
        case .failure(let error):
            return Result.flatten(result: Result<Result<T>> {
                return transform(error)
            })
        }
    }

    private static func flatten<T>(result: Result<Result<T>>) -> Result<T> {
        switch result {
        case .success(let innerResult):
            return innerResult
        case .failure(let error):
            return Result<T> { throw error }
        }
    }
}
