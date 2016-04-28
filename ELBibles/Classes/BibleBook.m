//
//  BibleBook.m
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 23/1/14.
//
//

#import "BibleBook.h"

@interface BibleBook ()

@property (nonatomic,copy,readwrite) NSString   *name;
@property (nonatomic,copy,readwrite) NSString   *abbreviation;
@property (nonatomic,readwrite)      NSInteger   chapterCount;
@property (nonatomic,readwrite)      NSInteger   number;

@end

@implementation BibleBook

@synthesize name = _name;
@synthesize abbreviation = _abbreviation;
@synthesize chapterCount = _chapterCount;

- (id) initWithName:(NSString *)name abbreviation:(NSString *)abbreviation number:(NSInteger)number chapterCount:(NSInteger)chapterCount {
    
    self = [super init];
    if (self) {
        self.number = number;
        self.name = name;
        self.abbreviation = abbreviation;
        self.chapterCount = chapterCount;
    }
    return self;
    
}

- (void) dealloc {
    self.name = nil;
    self.abbreviation = nil;
}

@end
