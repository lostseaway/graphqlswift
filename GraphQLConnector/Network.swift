
import Foundation
import RxSwift

struct Client {
    static let base = "http://graphql-swapi.parseapp.com"
}

enum Method: String {
    
    case GET
    case POST
    
}

protocol Request {
    
    var baseURL: URL { get }
    var method: Method { get }
    var path: String { get }
    var header: [String: AnyObject]? { get }
    var queryParam: [String: AnyObject]? { get }
    
}

extension Request {
    
    var method: Method { return .GET }
    var path: String { return "" }
    var header: [String: AnyObject]? { return [:] }
    var queryParam: [String: AnyObject]? { return [:] }
    
}

protocol RequestConstructable : Request {
    
    func createRequest() -> NSURLRequest?
    
}

extension RequestConstructable {
    
    func createRequest() -> NSURLRequest? {
        guard let components = NSURLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { return nil }
        
        components.path = (components.path ?? "") + path
        
        let query = queryParam?.reduce([URLQueryItem]()) { acc , dict in
            var _acc = acc
            _acc?.append(URLQueryItem(name: dict.0, value: dict.1 as? String))
            return _acc
        }
        
        components.queryItems = query
        
        guard let constructedURL = components.url else { return nil }
        
        let request = NSMutableURLRequest(url: constructedURL)
        request.httpMethod = method.rawValue
        
        header?.forEach { key, value in
            request.addValue(String(describing: value), forHTTPHeaderField: key)
        }
        
        return request
    }
    
}
