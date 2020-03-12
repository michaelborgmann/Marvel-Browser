//
//  StoryboardInstantiable.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiable: class {
    associatedtype MyType

    static var storyboardFileName: String { get }
    static var storyboardIdentifier: String { get }
    static func instanceFromStoryboard(_ bundle: Bundle?) -> MyType
}

extension StoryboardInstantiable where Self: UIViewController {

    public static var storyboardFileName: String {
        return storyboardIdentifier.components(separatedBy: "ViewController").first!
    }

    public static var storyboardIdentifier: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    public static func instanceFromStoryboard(_ bundle: Bundle? = nil) -> Self {
        let fileName = storyboardFileName
        let sb = UIStoryboard(name: fileName, bundle: bundle)
        return sb.instantiateViewController(withIdentifier: self.storyboardIdentifier) as! Self
    }
}
