//
//  DialAppConfig+CoreDataProperties.swift
//  Dial
//
//  Created by Jesse Vincent on 12/26/21.
//
//

import Foundation
import CoreData


extension DialAppConfig {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DialAppConfig> {
        return NSFetchRequest<DialAppConfig>(entityName: "DialAppConfig")
    }

    @NSManaged public var bundleId: String
    @NSManaged public var clickAction: String
    @NSManaged public var id: UUID
    @NSManaged public var localizedAppName: String
    @NSManaged public var timestamp: Date
    @NSManaged public var turnLeftAction: String
    @NSManaged public var turnRightAction: String

}

extension DialAppConfig : Identifiable {

}
