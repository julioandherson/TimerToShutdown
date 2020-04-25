//
//  ScriptService.swift
//  TimerToShutdown
//
//  Created by Júlio Andherson de Oliveira Silva on 22/03/20.
//  Copyright © 2020 Júlio Andherson de Oliveira Silva. All rights reserved.
//
import Cocoa

public class ScriptService {
    
    public static func executeShutDownScript() {
        let source = "tell application \"System Events\"\nshut down\nend tell"
        let script = NSAppleScript(source: source)
        var errorDict: NSDictionary? = nil

        script?.executeAndReturnError(&errorDict)
        
        if errorDict != nil {
            print("NIL")
        } else {
            print("no error")
        }
    }
}
