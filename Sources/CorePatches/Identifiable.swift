//
//  Identifiable.swift
//  CorePatches
//
//  Created by Tyler Anger on 2021-01-11.
//

import Foundation

#if !swift(>=5.1)
/// A class of types whose instances hold the value of an entity with stable
/// identity.
///
/// Use the `Identifiable` protocol to provide a stable notion of identity to a
/// class or value type. For example, you could define a `User` type with an `id`
/// property that is stable across your app and your app's database storage.
/// You could use the `id` property to identify a particular user even if other
/// data fields change, such as the user's name.
///
/// `Identifiable` leaves the duration and scope of the identity unspecified.
/// Identities could be any of the following:
///
/// - Guaranteed always unique (e.g. UUIDs).
/// - Persistently unique per environment (e.g. database record keys).
/// - Unique for the lifetime of a process (e.g. global incrementing integers).
/// - Unique for the lifetime of an object (e.g. object identifiers).
/// - Unique within the current collection (e.g. collection index).
///
/// It is up to both the conformer and the receiver of the protocol to document
/// the nature of the identity.
///
/// Conforming to the Identifiable Protocol
/// =======================================
///
/// `Identifiable` provides a default implementation for class types (using
/// `ObjectIdentifier`), which is only guaranteed to remain unique for the
/// lifetime of an object. If an object has a stronger notion of identity, it
/// may be appropriate to provide a custom implementation.
public protocol Identifiable {

    /// A type representing the stable identity of the entity associated with
    /// an instance.
    associatedtype ID : Hashable

    /// The stable identity of the entity associated with this instance.
    var id: Self.ID { get }
}

extension Identifiable where Self : AnyObject {

    /// The stable identity of the entity associated with this instance.
    public var id: ObjectIdentifier {
        return ObjectIdentifier(self)
    }
}
#endif
