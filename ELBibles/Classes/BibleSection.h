//
//  BibleSection.h
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 19/2/14.
//
//

#import <Foundation/Foundation.h>

@class Bible;
@interface BibleSection : NSObject

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSArray  *books;

- (instancetype) initWithBible:(Bible *)bible dictionary:(NSDictionary *)dict;

@end
