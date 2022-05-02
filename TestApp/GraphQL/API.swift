// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetCharQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetChar {
      charactersByIds(ids: ["1", "50", "100", "500"]) {
        __typename
        name
        species
        gender
      }
    }
    """

  public let operationName: String = "GetChar"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("charactersByIds", arguments: ["ids": ["1", "50", "100", "500"]], type: .list(.object(CharactersById.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(charactersByIds: [CharactersById?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "charactersByIds": charactersByIds.flatMap { (value: [CharactersById?]) -> [ResultMap?] in value.map { (value: CharactersById?) -> ResultMap? in value.flatMap { (value: CharactersById) -> ResultMap in value.resultMap } } }])
    }

    /// Get a list of characters selected by ids
    public var charactersByIds: [CharactersById?]? {
      get {
        return (resultMap["charactersByIds"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [CharactersById?] in value.map { (value: ResultMap?) -> CharactersById? in value.flatMap { (value: ResultMap) -> CharactersById in CharactersById(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [CharactersById?]) -> [ResultMap?] in value.map { (value: CharactersById?) -> ResultMap? in value.flatMap { (value: CharactersById) -> ResultMap in value.resultMap } } }, forKey: "charactersByIds")
      }
    }

    public struct CharactersById: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Character"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("species", type: .scalar(String.self)),
          GraphQLField("gender", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, species: String? = nil, gender: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Character", "name": name, "species": species, "gender": gender])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The name of the character.
      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// The species of the character.
      public var species: String? {
        get {
          return resultMap["species"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "species")
        }
      }

      /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
      public var gender: String? {
        get {
          return resultMap["gender"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "gender")
        }
      }
    }
  }
}
