//
//  Images.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 02/12/2024.
//

import SwiftUI

@Observable
class ImagesStore {
    private var storage = Storage()
    private let key = "Images"
    public private(set) var images: [Int: Data] = [:]
    
    init() {
        guard let images = try? storage.loadAndDecode(from: key, to: [Int: Data].self) else { return }
        self.images = images
    }

    func contains(_ id: Int) -> Bool {
        return images[id] != nil
    }
    
    func get (_ id: Int) -> Data? {
        images[id]
    }
    
    func add(_ id: Int, _ data: Data) {
        images[id] = data
    }

    func remove(_ id: Int) {
        images.removeValue(forKey: id)
    }
    
    deinit {
        save()
    }

    func save() {
       try? storage.encodeAndSave(item: images, to: key)
    }
}
