//
//  FirebaseConfBGColor.swift
//  TestTask
//
//  Created by Ashish Yadav on 10/09/23.
//

import Foundation
import Firebase

class FirebaseConfigBGColor {
    static let sharedInstance = FirebaseConfigBGColor()
    
    private init() {
        loadDefaultValues()
      }
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
          "appPrimaryColor": "#FBB03B"
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
      }
    func activateDebugMode() {
      let settings = RemoteConfigSettings()
      settings.minimumFetchInterval = 0
      RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues(_ color: @escaping((String) -> ())) {
      activateDebugMode()
      RemoteConfig.remoteConfig().fetch { [weak self] _, error in
        if let error = error {
          print("Uh-oh. Got an error fetching remote values \(error)")
          return
        }
        RemoteConfig.remoteConfig().activate { _, _ in
            let appPrimaryColorString = RemoteConfig.remoteConfig()
              .configValue(forKey: "appPrimaryColor")
              .stringValue ?? "undefined"
            color(appPrimaryColorString)
        }
      }
    }
}
