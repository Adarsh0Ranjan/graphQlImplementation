//
//  Network.swift
//  GraphQlImplementation
//
//  Created by Adarsh Ranjan on 11/06/24.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private init() {}

    
    private(set) lazy var apollo: ApolloClient = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let networkTransport = RequestChainNetworkTransport(
            interceptorProvider: NetworkInterceptorProvider(store: store),
            endpointURL: URL(string: "https://graphql.canopyapi.co/")!
        )
        return ApolloClient(networkTransport: networkTransport, store: store)
    }()
}

import Foundation
import Apollo
import GetDescriptionAPi


class StationListViewModel: ObservableObject {
    @Published var stationList: [SearchExampleQuery.Data.AmazonProductSearchResults.ProductResults.Result?] = []
    init() {
        self.loadDescriptions(completion: {
            for station in self.stationList {
                    if let title = station?.title {
                        print(title)
                    }
                }
        })
    }
    func loadDescriptions(completion: @escaping () -> Void) {
        Network.shared.apollo.fetch(query: SearchExampleQuery(searchTerm: "iphone")) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let graphQLResult):
                // check the `data` property
                if let stationConnection = graphQLResult.data?.amazonProductSearchResults?.productResults?.results {
                    self.stationList.append(contentsOf: stationConnection)
                }
                
                if let errors = graphQLResult.errors {
                    print(errors)
                }
                
                // Call completion handler when the operation is completed
                completion()
                
            case .failure(let error):
                print(error)
                // Call completion handler even if there's a failure, if necessary
                completion()
            }
            
        }
    }

}
import Foundation

struct AuthorizationKeys {
   
    let apiKey: String
    init(apiKey: String){
        self.apiKey = apiKey
    }
    
}

import Foundation
import Apollo

class AuthorizationInterceptor: ApolloInterceptor {
    // Any custom interceptors you use are required to be able to identify themselves through an id property.
    public var id: String = UUID().uuidString

    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        let keys = AuthorizationKeys(
            apiKey: "65ae00ed-d902-429b-98fc-05f84606db75"
        )

        request.addHeader(name:  "API-KEY", value: keys.apiKey)
       

        chain.proceedAsync(request: request,
                           response: response,
                           interceptor: self,
                           completion: completion)
    }
}

import Foundation
import Apollo

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorizationInterceptor(), at: 0)
        return interceptors
    }
}
