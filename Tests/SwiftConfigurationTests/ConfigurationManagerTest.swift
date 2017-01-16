/*
 * Copyright IBM Corporation 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import XCTest
@testable import SwiftConfiguration

class ConfigurationManagerTest: XCTestCase {
    static var allTests : [(String, (ConfigurationManagerTest) -> () throws -> Void)] {
        return [
            ("testLoadDictionary", testLoadDictionary),
            ("testLoadFile", testLoadFile),
        ]
    }

    func testLoadDictionary() {
        let manager = ConfigurationManager()

        manager.loadDictionary(["Hello": "World"])
        XCTAssertEqual(manager["Hello"] as? String, "World")
    }

    func testLoadFile() {
        // JSON
        var manager = ConfigurationManager()

        do {
            try manager.loadFile("../../../TestResources/default.json", relativeFrom: #file)
            XCTAssertEqual(manager["OAuth:configuration:state"] as? Bool, true)
        }
        catch {
            XCTFail("Cannot read file")
        }

        // PLIST
        manager = ConfigurationManager()

        do {
            try manager.loadFile("../../../TestResources/default.plist", relativeFrom: #file)
            XCTAssertEqual(manager["OAuth:configuration:state"] as? Bool, true)
        }
        catch {
            XCTFail("Cannot read file")
        }
    }
}
