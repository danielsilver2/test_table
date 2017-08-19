import Foundation

struct URLUtils {
    public static func requestUrl(_ url: String, onFinish: @escaping (Data) -> Void) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            onFinish(data!)
        }
        
        task.resume()
    }
    
    public static func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}
