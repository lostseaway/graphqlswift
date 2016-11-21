
import Alamofire
import RxSwift
import Gloss

struct Client {
    static let base = "http://graphql-swapi.parseapp.com"
    var connector: BaseRESTConnector
    
    init() {
        connector = Connector(base: Client.base)
    }
}

protocol BaseRESTConnector {
    func request(_ baseURL: String, path: String, method: Alamofire.HTTPMethod ,parameters: [String:Any]?, headers: [String:String]?) -> Observable<JSON>
}

extension BaseRESTConnector {
    func request(_ baseURL: String, path: String, method: Alamofire.HTTPMethod ,parameters: [String:Any]? = nil, headers: [String:String]? = nil) -> Observable<JSON> {
        return Observable.create { observer in
            Alamofire.request("\(baseURL)\(path)", method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler: {
                response in
                
                if response.result.isFailure {
                    observer.onError(response.result.error!)
                }
                
                observer.onNext(response.result.value as! JSON)
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}

struct Connector: BaseRESTConnector {
    let base: String
    func request(path: String, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?) -> Observable<JSON> {
        return request(self.base, path: path, method: method, parameters: parameters, headers: headers)
    }
}

protocol BaseRequest {
    associatedtype T
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var body: [String: AnyObject]? { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var connector: BaseRESTConnector { get }
    
    func call() -> Observable<T>
}

extension BaseRequest {
    
    var method: HTTPMethod { return .get }
    var path: String { return "" }
    var body: [String: AnyObject]? { return nil }
    var header: [String: String]? { return nil }
    var parameters: [String: AnyObject]? { return nil }
    
    func call() -> Observable<JSON> {
        return connector.request(baseURL, path: path, method: method, parameters: parameters, headers: header)
    }
}
