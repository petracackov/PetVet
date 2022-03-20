//
//  User.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation
import Parse

class User: ParseObject, ObservableObject {

    private static var currentLoadedUser: User? {
        didSet {
            if currentLoadedUser == nil && oldValue != nil {
                LoginManager.shared.isLoggedIn = false
            }
        }
    }

    static var current: User? {
        guard let currentUser = PFUser.current() else {
            currentLoadedUser = nil
            return nil
        }

        if let currentLoadedUser = currentLoadedUser, currentLoadedUser.userId == currentUser.objectId {
            return currentLoadedUser
        } else {
            let user = User(user: currentUser)
            currentLoadedUser = user
            return user
        }
    }

    var username: String?
    var userId: String?
    var dateCreated: Date?
    var email: String?

    // The _ in User is an exception for creating PFObject with just an object id. For some reason it does not work without _ .
    override class var entityName: String { return "_User" }
    

    override init() {
        super.init()
    }

    convenience init(user: PFUser) {
        self.init()
        updateUser(user: user)
    }

    override func updateWithPFObject(_ object: PFObject) throws {
        try super.updateWithPFObject(object)
        guard let username = object[Object.username.rawValue] as? String, let userId = object.objectId, let dateCreated = object.createdAt else {
            throw NSError(domain: "ParseObject", code: 400, userInfo: ["dev_message": "Could not parse User data from PFObject"])
        }
        self.username = username
        self.userId = userId
        self.dateCreated = dateCreated
        //NOTE: Can't guard email since the return value is nil if the user fetching that user is not the same or admin.
        self.email = object[Object.email.rawValue] as? String
    }

    private func updateUser(user: PFUser) {
        try? self.updateWithPFObject(user)
    }

}

// MARK: - Static Helpers

extension User {

    static private func generateQueryWithUsername(_ username: String ) -> PFQuery<PFObject>? {
        let query = PFUser.query()
        query?.whereKey(Object.username.rawValue, equalTo: username)
        return query
    }

    static private func generateQueryWithEmail(_ email: String ) -> PFQuery<PFObject>? {
        let query = PFUser.query()
        query?.whereKey(Object.email.rawValue, equalTo: email)
        return query
    }

    static func usernameIsAlreadyTaken(username: String?, completion: @escaping ((_ state: Bool?, _ error: Error? ) -> Void)) {
        guard let username = username, let query = generateQueryWithUsername(username) else {
            completion(nil, NSError())
            return }
        query.findObjectsInBackground {(objects: [PFObject]?, error: Error?) in
            guard let objects = objects else { completion(false, nil); return }
            completion(!objects.isEmpty, nil)
        }
    }

    static func emailIsAlreadyTaken(email: String?, completion: @escaping ((_ state: Bool?, _ error: Error? ) -> Void)) {
        guard let email = email, let query = generateQueryWithEmail(email) else {
            completion(nil, NSError())
            return
        }
        query.findObjectsInBackground {(objects: [PFObject]?, error: Error?) in
            guard let objects = objects else { completion(false,  nil); return }
            completion(!objects.isEmpty, nil)
        }
    }

    static func logOut(_ completion: ((_ error: Error?) -> Void)? = nil) {
        PFUser.logOutInBackground { error in
            currentLoadedUser = nil
            completion?(error)
        }
    }
}

// MARK: - Object

private extension User {
    enum Object: String {
        case username = "username"
        case email = "email"
        case userId = "userId"
        case pets = "pets"
    }
}
