//
//  BibleBook.h
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 23/1/14.
//
//

#import <Foundation/Foundation.h>

@class Bible;
@interface BibleBook : NSObject

@property (nonatomic,readonly) NSInteger   number;
@property (nonatomic,readonly) NSString   *name;
@property (nonatomic,readonly) NSString   *abbreviation;
@property (nonatomic,readonly) NSInteger   chapterCount;


- (instancetype) initWithBible:(Bible *)bible name:(NSString *)name abbreviation:(NSString *)abbreviation number:(NSInteger)number chapterCount:(NSInteger)chapterCount;
- (NSInteger) numberOfVersesInChapter:(NSUInteger)chapter;

// Deprecated
- (id) initWithName:(NSString *)name abbreviation:(NSString *)abbreviation number:(NSInteger)number chapterCount:(NSInteger)chapterCount __deprecated;

@end
