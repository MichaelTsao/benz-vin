//
//  File.swift
//  UsedCarVIN
//
//  Created by DreamTeamAAn on 2017/2/5.
//  Copyright © 2017年 daimler. All rights reserved.
//

import Foundation


func request(method: String, url: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: @escaping (_ data: NSData?, _ response: URLResponse?, _ error: NSError?) -> Void) {
    let session = URLSession.shared
    
    var newURL = url
    if method == "GET" {
        newURL += "?" + buildParams(params)
    }
    
    let request = NSMutableURLRequest(url: NSURL(string: newURL)! as URL)
    request.httpMethod = method
    
    
    
    if method == "POST" {
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = Network().buildParams(params).data(using: String.Encoding.utf8)
    }
    
    
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        callback(data as NSData?, response , error as NSError?)
    })
    task.resume()
}

//请求体,并处理特殊字符串 !$&'()*+,;= :#[]@
private func buildParams(_ parameters: [String: Any]) -> String {
    var components: [(String, String)] = []
    
    for key in parameters.keys.sorted(by: <) {
        let value = parameters[key]!
        components += queryComponents(fromKey: key, value: value)
    }
    
    return components.map { "\($0)=\($1)" }.joined(separator: "&")
}

public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []
    
    if let dictionary = value as? [String: Any] {
        for (nestedKey, value) in dictionary {
            components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
        }
    } else if let array = value as? [Any] {
        for value in array {
            components += queryComponents(fromKey: "\(key)[]", value: value)
        }
    } else if let value = value as? NSNumber {
        if value.isBool {
            components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
    } else if let bool = value as? Bool {
        components.append((escape(key), escape((bool ? "1" : "0"))))
    } else {
        components.append((escape(key), escape("\(value)")))
    }
    
    return components
}
