import Foundation

struct Mapper {
    public static func mapJsonResponse(_ data: Data) -> [Album] {
        
        var albuns: [Album] = []
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        for albumData in json as! [[String: Any]] {
            if let albumId = albumData["albumId"] as? Int, let id = albumData["id"] as? Int, let title = albumData["title"] as? String, let url = albumData["url"] as? String, let thumbnailUrl = albumData["thumbnailUrl"] as? String {
                albuns.append(Album(id: id, albumId: albumId, title: title, url: URL(string: url)!, thumbnailUrl: URL(string: thumbnailUrl)!))
            }
        }
        return albuns
    }
}
