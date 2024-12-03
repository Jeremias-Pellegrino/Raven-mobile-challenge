//
//  Storage.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 01/12/2024.
//

import Foundation

class Storage {
    
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    
    private let fileManager: FileManager
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    private func makeURL(forFileNamed fileName: String) throws -> URL? {
        guard let url = try? fileManager.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: true)
        else {
            throw Error.invalidDirectory
        }
        return url.appendingPathComponent(fileName)
    }
 
    func encodeAndSave(item: Codable, to key: String) throws {
        if let encodedData = try? JSONEncoder().encode(item) {
            do {
                try store(data: encodedData, fileNamed: key)
                debugPrint("succesfully stored \(item) for key: ", key)
            } catch {
                debugPrint(error)
                throw Error.writtingFailed
            }
        }
    }
    
    func loadAndDecode<T: Codable>(from key: String, to modelOfType: T.Type) throws -> T {
        var res: T
        guard let data = try? read(fileNamed: key) else {
            throw Error.fileNotExists
        }
        do {
            res = try JSONDecoder().decode(modelOfType, from: data)
            debugPrint("succesfully read \(res) for key: ", key)
        } catch {
            debugPrint(error)
            throw Error.writtingFailed
        }
        return res
    }
    
    func store(data: Data, fileNamed: String, overwrite: Bool = true) throws {
        guard let url = try makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        
        if !overwrite && fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }
        
        return try data.write(to: url)
    }
    
    func read(fileNamed: String) throws -> Data? {
        guard let url = try makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        
        guard !fileManager.fileExists(atPath: url.absoluteString) else {
            return nil
        }
        
        return try Data(contentsOf: url)
    }
}
