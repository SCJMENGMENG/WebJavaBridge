//
//  Header.h
//  WebJavaBridge
//
//  Created by scj on 2019/12/30.
//  Copyright © 2019 scj. All rights reserved.
//

#ifndef Header_h
#define Header_h

static inline BOOL isIPhoneX() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}


#endif /* Header_h */
