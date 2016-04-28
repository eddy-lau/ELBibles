//
//  BibleStore.m
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 31/1/14.
//
//

#import "BibleStore.h"
#import "Bible.h"

@interface BibleStore ()

@property (nonatomic,retain) NSMutableDictionary *bibles;

@end

@implementation BibleStore

+ (BibleStore *) sharedInstance {
    
    static BibleStore *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
    
}

- (id) init {
    
    self = [super init];
    if (self) {
        self.bibles = [NSMutableDictionary dictionary];
    }
    return self;
    
    
}

- (void) dealloc {
    self.bibles = nil;
}

- (Bible *) bibleWithName:(NSString *)name {
    
    Bible *bible = self.bibles[name];
    if (bible == nil) {
        bible = [[Bible alloc] initWithName:name];
        if (bible != nil) {
            self.bibles[name] = bible;
        }
    }
    return bible;
    
}

@end
