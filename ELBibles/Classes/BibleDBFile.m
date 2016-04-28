//
//  BibleDBFile.m
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 19/4/2016.
//
//

#import "BibleDBFile.h"

@implementation BibleDBFile

+ (NSString *) dbFileOfBibleNamed:(NSString *)bibleName {
    
    if (bibleName == nil || [bibleName length]==0)
        return nil;
    
    if ([bibleName compare:@"呂振中譯本（繁體）"] == NSOrderedSame ||
        [bibleName compare:@"吕振中译本（简体）"] == NSOrderedSame) {
        
        static BOOL alerted = NO;
        
        if (!alerted) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry",@"")
                                                                 message:NSLocalizedString(@"We are currently in the process of licensing 呂振中譯本, it will be temporary unavailable.",@"")
                                                                delegate:nil
                                                       cancelButtonTitle:NSLocalizedString(@"Dismiss","")
                                                       otherButtonTitles:nil];
            [alertView show];
            alerted = YES;
        }
        
        return @"新標點和合本（繁體）.sql";
    }
    
    NSMutableString *dbFileName = [[NSMutableString alloc] initWithString:bibleName];
    [dbFileName appendString:@".sql"];
    return dbFileName;
    
}

@end
