//
//  BibleStore.h
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 31/1/14.
//
//

#import <Foundation/Foundation.h>

@class Bible;

@interface BibleStore : NSObject

+ (BibleStore *) sharedInstance;

- (Bible *) bibleWithName:(NSString *)name;

@end
