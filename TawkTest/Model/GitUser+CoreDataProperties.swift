//
//  GitUser+CoreDataProperties.swift
//  TawkTest
//
//  Created by JayR- Mac-mini on 8/30/21.
//
//

import Foundation
import CoreData


extension GitUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GitUser> {
        return NSFetchRequest<GitUser>(entityName: "GitUser")
    }

    @NSManaged public var login: String?
    @NSManaged public var id: Int16
    @NSManaged public var nodeId: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var gravatarId: String?
    @NSManaged public var url: String?
    @NSManaged public var htmlUrl: String?
    @NSManaged public var followersUrl: String?
    @NSManaged public var followingUrl: String?
    @NSManaged public var gistsUrl: String?
    @NSManaged public var starredUrl: String?
    @NSManaged public var subscriptionUrl: String?
    @NSManaged public var organizationsUrl: String?
    @NSManaged public var reposUrl: String?
    @NSManaged public var eventsUrl: String?
    @NSManaged public var receivedEventsUrl: String?
    @NSManaged public var type: String?
    @NSManaged public var siteAdmin: Bool

}

extension GitUser : Identifiable {

}
