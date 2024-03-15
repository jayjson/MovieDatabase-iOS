//
//  CastMember+Mocks.swift
//  MovieDatabase
//
//  Created by Jay Son on 2024-03-15.
//

import Foundation

extension CastMember {
    static var mock1: CastMember {
        CastMember(adult: true, gender: nil, id: 1, knownForDepartment: "", name: "Jack Black", originalName: "Actor One", popularity: 9, profilePath: "/rtCx0fiYxJVhzXXdwZE2XRTfIKE.jpg", castId: nil, character: "Friend", creditId: "1", order: 1)
    }
    static var mock2: CastMember {
       CastMember(adult: true, gender: nil, id: 1, knownForDepartment: "", name: "Actor without Photo", originalName: "Actor Two", popularity: 9, profilePath: nil, castId: nil, character: "Friend", creditId: "1", order: 1)
    }
}
