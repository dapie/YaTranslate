//
//  String+Capitalize.swift
//  YaTranslate
//
//  Created by Denis Tkachev on 19/05/2019.
//  Copyright © 2019 Denis Tkachev. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
