//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype I
    associatedtype O
    func map(_ input: I) -> O
}

protocol ListMapperProtocol {
    associatedtype I
    associatedtype O
    func map(_ input: [I]) -> [O]
}

struct ListMapper<M: Mapper>: ListMapperProtocol {
    typealias I = M.I
    typealias O = M.O

    private let mapper: M

    init(_ mapper: M) {
        self.mapper = mapper
    }

    func map(_ input: [M.I]) -> [M.O] {
        input.map { mapper.map($0) }
    }
}


protocol NullableInputListMapperProtocol {
    associatedtype I
    associatedtype O
    func map(_ input: [I]?) -> [O]
}

struct NullableInputListMapper<M: Mapper>: NullableInputListMapperProtocol {
    typealias I = M.I
    typealias O = M.O

    private let mapper: M

    init(_ mapper: M) {
        self.mapper = mapper
    }

    func map(_ input: [M.I]?) -> [M.O] {
        input?.map { mapper.map($0) } ?? []
    }
}

protocol NullableOutputListMapperProtocol {
    associatedtype I
    associatedtype O
    func map(_ input: [I]) -> [O]?
}

struct NullableOutputListMapper<M: Mapper>: NullableOutputListMapperProtocol {
    typealias I = M.I
    typealias O = M.O

    private let mapper: M

    init(_ mapper: M) {
        self.mapper = mapper
    }

    func map(_ input: [M.I]) -> [M.O]? {
        input.isEmpty ? nil : input.map { mapper.map($0) }
    }
}