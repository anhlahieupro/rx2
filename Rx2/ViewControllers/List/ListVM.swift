import UIKit
import RxSwift
import RxCocoa

class ListVM: ViewModel {
    struct Input {
        let getList: Observable<Void>
    }
    
    struct Output {
        let response: Observable<UsersResponse?>
    }
    
    func transform(_ input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        
        let response: Observable<UsersResponse?> = input.getList.flatMap { _ in
            
            return Api.request(url: ApiPath.users, ResponseType: UsersResponse.self)
                .trackActivity(activityIndicator)
                .map { usersResponse in
                    return usersResponse
                }
                .catch { error in
                    if let error = error as? BaseError {
                        print(error.response?.error ?? "base error")
                    }
                    
                    print(error.localizedDescription)
                    
                    return .just(nil)
                }
        }
        
        return Output(response: response)
    }
}
