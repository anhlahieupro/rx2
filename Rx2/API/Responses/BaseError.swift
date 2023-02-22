import UIKit

struct BaseError: Error {
    let code: Int
    let response: BaseResponse?
}
