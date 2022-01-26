//
//  BibleSection.m
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 19/2/14.
//
//

#import "BibleSection.h"
#import "BibleBook.h"

@interface BibleSection()

@property (nonatomic,retain,readwrite) NSString *name;
@property (nonatomic,retain,readwrite) NSArray  *books;

@end

@implementation BibleSection

- (instancetype) initWithBible:(Bible *)bible dictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        
        NSMutableArray *_books = [NSMutableArray array];
        NSArray *books = dict[@"books"];
        for (NSDictionary *dict in books) {
            BibleBook *book = [[BibleBook alloc] initWithBible:bible dictionary:dict];
            [_books addObject:book];
        }
        self.books = _books;
    }
    return self;
}

- (id) initWithName:(NSString *)name books:(NSArray *)books {
    
    self = [super init];
    if (self) {
        self.name = name;
        self.books = books;
    }
    return self;
    
}

- (void) dealloc {
    self.name = nil;
    self.books = nil;
}

- (NSString *) description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"    {\n"];
    [string appendString:@"      \"books\": [\n"];

    for (BibleBook *book in self.books) {
        [string appendFormat:@"%@, \n", book.description];
    }

    [string appendString:@"      ] \n"];
    [string appendString:@"    }"];
    return string;
}

@end
