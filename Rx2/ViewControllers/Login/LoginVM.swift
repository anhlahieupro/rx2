import UIKit
import RxSwift
import RxCocoa

final class LoginVM: ViewModel {
    struct Input {
        let email: Observable<String>
        let password: Observable<String>
        let login: Observable<Void>
    }
    
    struct Output {
        let isLoading: Driver<Bool>
        let message: Driver<String>
        let enableLogin: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let emailAndPassword = Observable.combineLatest(input.email, input.password) { email, password in
            return (email, password)
        }
        
        let enableLogin = emailAndPassword.map({ !$0.isEmpty && !$1.isEmpty })
        
        let activityIndicator = ActivityIndicator()
        
        let message = input.login
            .withLatestFrom(emailAndPassword)
            .flatMap { email, password in
                
                return Api.request(url: ApiPath.login,
                                   method: .post,
                                   parameters: ["email": email, "password": password],
                                   ResponseType: LoginResponse.self)
                .trackActivity(activityIndicator)
                .map { response in
                    return response.token ?? response.error ?? "response"
                }
                .catch { error in
                    if let error = error as? BaseError {
                        return .just(error.response?.error ?? "base error")
                    }
                    
                    return .just(error.localizedDescription)
                }
            }
        
        return Output(isLoading: activityIndicator.asDriver(onErrorJustReturn: false),
                      message: message.asDriver(onErrorJustReturn: ""),
                      enableLogin: enableLogin.asDriver(onErrorJustReturn: false))
    }
}
