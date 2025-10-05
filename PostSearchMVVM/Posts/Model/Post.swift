//
//  Models.swift
//  Battlebucks

//  Created by Hemendra  on 01/10/25.

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
