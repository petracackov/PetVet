//
//  ParseObject.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation
import Parse

class ParseObject {

    // EntityName needs to be overridden
    class var entityName: String { return "" }
    var entityName: String { return type(of: self).entityName }

    var pfObject: PFObject?

    init() {}
    
    init?(pfObject: PFObject?) {
        guard let pfObject = pfObject else { return nil }
        do {
            try updateWithPFObject(pfObject)
        } catch {
            if let message = (error as NSError).userInfo["dev_message"] as? String {
                print(message)
            } else {
                print("Unknown error occurd while parsing PFObject")
            }
            return nil
        }
    }

    func generetePFObject() -> PFObject? {
        let object = pfObject ?? PFObject(className: entityName)
        return object
    }

    func updateWithPFObject(_ object: PFObject) throws {
        pfObject = object
    }

    static func generatePFQuery() -> PFQuery<PFObject> {
        return PFQuery(className: entityName)
    }

    static func withId(_ objectId: String?) -> PFObject? {
        guard let objectId = objectId else { return nil }
        return PFObject(withoutDataWithClassName: entityName, objectId: objectId)
    }

    func save(completion: ((_ success: Bool, _ error: Error?) -> Void)?) {
        guard let object = generetePFObject() else {
            completion?(false, NSError())
            return
        }
        object.saveInBackground { (success: Bool, error: Error?) in
            completion?(success, error)
        }
    }

    func delete(completion: ((_ success: Bool, _ error: Error?) -> Void)?) {
        guard let object = generetePFObject() else {
            completion?(false, NSError())
            return
        }
        object.deleteInBackground { (success, error) in
            completion?(success, error)
        }
    }
}

extension ParseObject {

    func save(completion: ((_ success: Bool, _ error: Error?) -> Void)?) async throws -> Bool {
        return try await withUnsafeThrowingContinuation { continuation in
            self.save { success, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: success)
                }
            }
        }
    }
    func delete(completion: ((_ success: Bool, _ error: Error?) -> Void)?) async throws -> Bool {
        return try await withUnsafeThrowingContinuation { continuation in
            self.delete { success, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: success)
                }
            }
        }
    }
}

extension ParseObject {

    static func findObjects<ItemType>(query: PFQuery<ItemType>) async throws -> [ItemType] {
        return try await withUnsafeThrowingContinuation { continuation in
            query.findObjectsInBackground { items, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let items = items {
                    continuation.resume(returning: items)
                } else {
                    continuation.resume(throwing: NSError()) // TODO: generic error
                }
            }
        }
    }

}
