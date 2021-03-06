//
//  Localizables.swift
//  Counters
//
//  Created by Abner Abbey on 15/12/21.
//

import Foundation

struct Localizables {
    
    struct MainView {
        static let title = "APP_NAME"
        static let main_edit_button = "MAIN_EDIT_BUTTON"
    }
    
    struct MainViewActionEmpty {
        static let title = "MAIN_VIEW_DESCRIPTION_TITLE_EMPTY"
        static let description = "MAIN_VIEW_DESCRIPTION_DESC_EMPTY"
        static let buttonTitle = "MAIN_VIEW_BUTTON_TITLE_EMPTY"
    }
    
    struct MainViewActionError {
        static let title = "MAIN_VIEW_DESCRIPTION_TITLE_ERROR"
        static let description = "MAIN_VIEW_DESCRIPTION_DESC_ERROR"
        static let buttonTitle = "MAIN_VIEW_BUTTON_TITLE_ERROR"
    }
    
    struct CreateItemView {
        static let title = "CREATE_ITEM_TITLE"
        static let placeholder = "CREATE_ITEM_PLACEHOLDER"
        static let leftButton = "CREATE_ITEM_LEFTBUTTON_TITLE"
        static let rightButton = "CREATE_ITEM_RIGHTBUTTON_TITLE"
    }
    
    struct ErrorAlertView {
        static let dismiss = "ERROR_ALERT_DISMISS_BUTTON"
        static let titleCreateItem = "ERROR_ALERT_CREATEITEM_TITLE"
    }
    
}
