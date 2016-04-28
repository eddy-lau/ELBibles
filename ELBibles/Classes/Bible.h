//
//  BibleModel.h
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 23/1/14.
//
//

#import <Foundation/Foundation.h>
#import "BibleBook.h"
#import "BibleSection.h"

@class SQLiteDatabase;

@interface Bible : NSObject

- (Bible *) initWithName:(NSString *)name;
- (NSInteger) pageNumberOfBook:(NSInteger)book chapter:(NSUInteger)chapter;
- (NSInteger) pageNumberOfBookAbbreviation:(NSString *)abbreviation chapter:(NSUInteger)chapter;
- (NSInteger) numberOfVerseOfBook:(NSInteger)book inChapter:(NSUInteger)chapter;


@property (nonatomic,readonly) NSString        *name;
@property (nonatomic,readonly) NSArray         *allBibleBooks;
@property (nonatomic,readonly) NSInteger        pageCount;
@property (nonatomic,readonly) SQLiteDatabase  *db;
@property (nonatomic,readonly) NSArray         *sections;
@property (nonatomic,readonly) BOOL             isChinese;
@property (nonatomic,readonly) BOOL             isShangtiVersion;

@end

extern NSString *BibleModelDidLoadBooksNotification;