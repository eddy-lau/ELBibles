//
//  BibleSection.m
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 19/2/14.
//
//

#import "BibleSection.h"

@interface BibleSection()

@property (nonatomic,retain,readwrite) NSString *name;
@property (nonatomic,retain,readwrite) NSArray  *books;

@end

@implementation BibleSection

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

@end
