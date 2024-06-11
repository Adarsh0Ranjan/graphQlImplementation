// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SearchExampleQuery: GraphQLQuery {
  public static let operationName: String = "SearchExample"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query SearchExample($searchTerm: String!) { amazonProductSearchResults(input: { searchTerm: $searchTerm }) { __typename productResults { __typename results { __typename asin title } } } }"#
    ))

  public var searchTerm: String

  public init(searchTerm: String) {
    self.searchTerm = searchTerm
  }

  public var __variables: Variables? { ["searchTerm": searchTerm] }

  public struct Data: GetDescriptionAPi.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { GetDescriptionAPi.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("amazonProductSearchResults", AmazonProductSearchResults?.self, arguments: ["input": ["searchTerm": .variable("searchTerm")]]),
    ] }

    /// Query for Amazon product search results
    public var amazonProductSearchResults: AmazonProductSearchResults? { __data["amazonProductSearchResults"] }

    /// AmazonProductSearchResults
    ///
    /// Parent Type: `AmazonProductSearchResults`
    public struct AmazonProductSearchResults: GetDescriptionAPi.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { GetDescriptionAPi.Objects.AmazonProductSearchResults }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("productResults", ProductResults?.self),
      ] }

      /// Product results shown on the search results page.
      ///
      /// If `input` is not provided, will default to first page with default sort.
      public var productResults: ProductResults? { __data["productResults"] }

      /// AmazonProductSearchResults.ProductResults
      ///
      /// Parent Type: `AmazonProductResultsPage`
      public struct ProductResults: GetDescriptionAPi.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { GetDescriptionAPi.Objects.AmazonProductResultsPage }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("results", [Result?]?.self),
        ] }

        /// A list of AmazonProducts from the current page
        public var results: [Result?]? { __data["results"] }

        /// AmazonProductSearchResults.ProductResults.Result
        ///
        /// Parent Type: `AmazonProduct`
        public struct Result: GetDescriptionAPi.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { GetDescriptionAPi.Objects.AmazonProduct }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("asin", String?.self),
            .field("title", String.self),
          ] }

          /// The ASIN of the parent product on Amazon, if available
          public var asin: String? { __data["asin"] }
          /// The title of the product as displayed on Amazon
          public var title: String { __data["title"] }
        }
      }
    }
  }
}
