
import Alamofire
import RxSwift
import Gloss

struct Client {
    static let base = "http://graphql-swapi.parseapp.com"
}

extension Client {
    static func requestObserve(query:String)->Observable<JSON> {
        return Observable.create { observer -> Disposable in
            Alamofire.request("\(base)", parameters: ["query":query], encoding: URLEncoding.default).responseJSON(completionHandler: { response in
                if response.result.isFailure {
                    observer.onError(response.result.error!)
                }
                
                observer.onNext(response.result.value as! JSON)
                observer.onCompleted()
            })
            return NopDisposable.instance
            
        }
    }
}
