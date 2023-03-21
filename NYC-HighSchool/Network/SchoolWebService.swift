import Foundation


class SchoolWebService {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getSchools(completion: @escaping ([School]?, APIError?) -> (Void)) {
        
        // create url to fetch data from server. If the url is invalid return from here..
        guard let url = URL(string: urlString) else {
            completion(nil, APIError.invalidRequestURLString)
            return
        }

        // call the api
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, APIError.failedRequest(description: error!.localizedDescription))
                return
            }
            
            // get the result from server in required format
            let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
            let schoolResult = try? JSONDecoder().decode([School].self, from: utf8Data!)

            // if result is found call the completion on main thread
            if let schoolResult = schoolResult {
                completion(schoolResult, nil)
            }
            else {
                // api fails to give correct result so pass error message
                completion(nil, APIError.invalidResponseModel)
            }
        }.resume()
    }
    
    func getSchoolDetail(completion: @escaping ([SchoolDetail]?, APIError?) -> (Void)) {
        
        // create url to fetch data from server. If the url is invalid return from here..
        guard let url = URL(string: urlString) else {
            completion(nil, APIError.invalidRequestURLString)
            return
        }

        // call the api
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, APIError.failedRequest(description: error!.localizedDescription))
                return
            }
            
            // get the result from server in required format
            let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8)
            let schoolDetailResult = try? JSONDecoder().decode([SchoolDetail].self, from: utf8Data!)

            // if result is found call the completion on main thread
            if let schoolDetailResult = schoolDetailResult {
                completion(schoolDetailResult, nil)
            }
            else {
                // api fails to give correct result so pass error message
                completion(nil, APIError.invalidResponseModel)
            }
        }.resume()
    }
}
