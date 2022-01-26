//
//  BibleBook.m
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 23/1/14.
//
//

#import "BibleBook.h"
#import "Bible.h"

@interface BibleBook ()

@property (nonatomic,weak) Bible *bible;
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

- (instancetype) initWithBible:(Bible *)bible name:(NSString *)name abbreviation:(NSString *)abbreviation number:(NSInteger)number chapterCount:(NSInteger)chapterCount {
    
    self = [super init];
    if (self) {
        self.bible = bible;
        self.number = number;
        self.name = name;
        self.abbreviation = abbreviation;
        self.chapterCount = chapterCount;
    }
    return self;
    
}

- (instancetype) initWithBible:(Bible *)bible dictionary:(NSDictionary *)dict {

    self = [super init];
    if (self) {
        self.bible = bible;
        self.number = [dict[@"number"] intValue];
        self.name = dict[@"name"];
        self.abbreviation = dict[@"abbreviation"];
        self.chapterCount = [dict[@"chapterCount"] intValue];
    }
    return self;
}

- (NSInteger) numberOfVersesInChapter:(NSUInteger)chapter {
    
    return [self.bible numberOfVerseOfBook:self.number inChapter:chapter];
}

- (void) dealloc {
    self.name = nil;
    self.abbreviation = nil;
}

- (NSString *) description {
    NSMutableString *desc = [NSMutableString string];
    [desc appendString:@"        {\n"];
    [desc appendFormat:@"          \"name\":         \"%@\", \n", self.name];
    [desc appendFormat:@"          \"abbreviation\": \"%@\", \n", self.abbreviation];
    [desc appendFormat:@"          \"chapterCount\": %ld, \n", self.chapterCount];
    [desc appendFormat:@"          \"number\":       %ld, \n", self.number];
    [desc appendString:@"        }"];
    return desc;
}

@end
