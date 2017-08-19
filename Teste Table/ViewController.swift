import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        URLUtils.requestUrl("http://jsonplaceholder.typicode.com/photos", onFinish: {
            result in
            let table = TableController(albuns: Mapper.mapJsonResponse(result))
            self.present(table, animated: true, completion: nil)
        })
    }
}

struct Album {
    public var id: Int
    public var albumId: Int
    public var title: String
    public var url: URL
    public var thumbnailUrl: URL
}

struct Mapper {
    public static func mapJsonResponse(_ data: Data) -> [Album] {

        var albuns: [Album] = []
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        for albumData in json as! [[String: Any]] {
            if let albumId = albumData["albumId"] as? Int, let id = albumData["id"] as? Int, let title = albumData["title"] as? String, let url = albumData["url"] as? String, let thumbnailUrl = albumData["thumbnailUrl"] as? String {
                albuns.append(Album(id: id, albumId: albumId, title: title, url: URL(string: url)!, thumbnailUrl: URL(string: thumbnailUrl)!))
            }
        }
        print(albuns)
        return albuns
    }
}

struct URLUtils {
    public static func requestUrl(_ url: String, onFinish: @escaping (Data) -> Void) {
        let url = URL(string: url)
    
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            onFinish(data!)
        }
        
        task.resume()
    }
}
