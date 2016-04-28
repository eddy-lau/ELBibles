//
//  BibleBook.h
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 23/1/14.
//
//

#import <Foundation/Foundation.h>

@interface BibleBook : NSObject

@property (nonatomic,readonly) NSInteger   number;
@property (nonatomic,readonly) NSString   *name;
@property (nonatomic,readonly) NSString   *abbreviation;
@property (nonatomic,readonly) NSInteger   chapterCount;

- (id) initWithName:(NSString *)name abbreviation:(NSString *)abbreviation number:(NSInteger)number chapterCount:(NSInteger)chapterCount;

@end
