//
//  BibleModel.m
//  TouchBibles
//
//  Created by Eddie Hiu-Fung Lau on 23/1/14.
//
//

#import "Bible.h"
#import "SQLiteDatabase.h"
#import "BibleDBFile.h"

NSString *BibleModelDidLoadBooksNotification = @"BibleModelDidLoadBooksNotification";

@interface BibleSection (private)

- (id) initWithName:(NSString *)name books:(NSArray *)books;

@end

@interface Bible ()
{
    NSMutableArray *_bibleBooks;
    NSMutableArray *_sections;
}

@property (nonatomic,readwrite)           NSInteger pageCount;
@property (nonatomic,retain,readwrite)    SQLiteDatabase *db;
@property (nonatomic,retain,readwrite)    NSString *name;

@end

@implementation Bible

- (id) initWithName:(NSString *)name {
    
    self = [super init];
    if (self) {
        
        NSString *dbFileName = [BibleDBFile dbFileOfBibleNamed:name];
        if (dbFileName != nil) {
            
            NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
            
            self.db = [[SQLiteDatabase alloc] initWithPath:path];
            if (![self.db open]) {
                
                NSLog (@"Cannot open database: %@", path);
                self.db = nil;
                
            } else {
                
                self.pageCount   = [[self.db evalSQL:@"select count(number) from pages;"] integerValue];
                
            }
            
            self.name = name;
            
        } else {
            
            self = nil;
        }
        
    }
    return self;
}

- (void) dealloc {
    
    self.name = nil;
    [self.db close];
    self.db = nil;
    
}


#pragma mark private methods

- (void) load {
    
    NSString *sql = [NSString stringWithFormat:@"select name,chaptercount,abbrev,books.number from books,chapters where books.number = chapters.book"];
    [self.db queuedQuerySQL:sql target:self selector:@selector(didLoadBooks:) userInfo:nil];
}

- (NSArray *) allBibleBooks {
    
    if (_bibleBooks == nil) {
        [self load];
    }
    return _bibleBooks;
    
}

- (NSArray *) sections {
    
    if (_sections == nil) {
        [self load];        
    }
    return _sections;
    
}

- (void) didLoadBooks:(NSDictionary *)info {

    if (_bibleBooks == nil) {
        _bibleBooks = [[NSMutableArray alloc] init];
    } else {
        [_bibleBooks removeAllObjects];
    }
    
    if (_sections == nil) {
        _sections = [[NSMutableArray alloc] init];
    } else {
        [_sections removeAllObjects];
    }
    
    NSArray *result = info[@"queryResult"];

    NSMutableArray *currentSection = nil;
    for (NSDictionary *row in result) {
        
        
        NSString *name = [row valueForKey:@"name"];
        NSString *abbreviation = [row valueForKey:@"abbrev"];
        NSInteger chapterCount = [[row valueForKey:@"chaptercount"] integerValue];
        NSInteger number = [[row valueForKey:@"number"] integerValue];
        
        BibleBook *book = [[BibleBook alloc] initWithBible:self name:name abbreviation:abbreviation number:number chapterCount:chapterCount];
        [_bibleBooks addObject:book];
        
        if ([name isEqualToString:@"創世記"]) {
            
            currentSection = [NSMutableArray array];
            if ([self.name isEqualToString:@"口語訳聖書"]) {
                BibleSection *section = [[BibleSection alloc] initWithName:@"旧約" books:currentSection];
                [_sections addObject:section];
                
            } else {
                BibleSection *section = [[BibleSection alloc] initWithName:@"舊約" books:currentSection];
                [_sections addObject:section];
            }
            
        } else if ([name isEqualToString:@"创世记"]) {
            currentSection = [NSMutableArray array];
            BibleSection *section = [[BibleSection alloc] initWithName:@"旧约" books:currentSection];
            [_sections addObject:section];
        } else if ([name isEqualToString:@"Genesis"]) {
            currentSection = [NSMutableArray array];
            BibleSection *section = [[BibleSection alloc] initWithName:@"Old Testament" books:currentSection];
            [_sections addObject:section];
        } else if ([name isEqualToString:@"馬太福音"] || [name isEqualToString:@"マタイによる福音書"]) {
            currentSection = [NSMutableArray array];
            BibleSection *section = [[BibleSection alloc] initWithName:@"新約" books:currentSection];
            [_sections addObject:section];
        } else if ([name isEqualToString:@"马太福音"]) {
            currentSection = [NSMutableArray array];
            BibleSection *section = [[BibleSection alloc] initWithName:@"新约" books:currentSection];
            [_sections addObject:section];
        } else if ([name isEqualToString:@"Matthew"]) {
            currentSection = [NSMutableArray array];
            BibleSection *section = [[BibleSection alloc] initWithName:@"New Testament" books:currentSection];
            [_sections addObject:section];
        }
        
        [currentSection addObject:book];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BibleModelDidLoadBooksNotification object:self];
}

#pragma mark public methods

- (NSInteger) pageNumberOfBook:(NSInteger)book chapter:(NSUInteger)chapter {
    
    NSString *sql = [NSString stringWithFormat:@"select number from pages where book=%ld and chapter = %lu;", (long)book, (unsigned long)chapter];
    return [[self.db evalSQL:sql] integerValue];
    
}

- (NSInteger) pageNumberOfBookAbbreviation:(NSString *)abbreviation chapter:(NSUInteger)chapter {
    
    NSString *sql = [NSString stringWithFormat:@"select pages.number from pages,books where chapter = %lu and books.number = pages.book and books.abbrev = '%@'; ",
                     (unsigned long)chapter, abbreviation];
    return [[self.db evalSQL:sql] integerValue];
    
}

- (NSInteger) numberOfVerseOfBook:(NSInteger)book inChapter:(NSUInteger)chapter {
    
    NSString *sql = [NSString stringWithFormat:@"select count(verse) from bible where book = %ld and chapter = %lu;", (long)book, (unsigned long)chapter];
    return [[self.db evalSQL:sql] integerValue];
    
}


- (BOOL) isChinese {
    return [self.name isEqualToString:@"和合本修訂版（繁體）"] ||
    [self.name isEqualToString:@"和合本修订版（简体）"] ||
    [self.name isEqualToString:@"現代中文譯本（繁體）"] ||
    [self.name isEqualToString:@"新標點和合本（繁體）"] ||
    [self.name isEqualToString:@"新标点和合本（简体）"] ||
    [self.name isEqualToString:@"和合本（繁體）"] ||
    [self.name isEqualToString:@"和合本（简体）"] ||
    [self.name isEqualToString:@"呂振中譯本（繁體）"] ||
    [self.name isEqualToString:@"吕振中译本（简体）"] ||
    [self.name isEqualToString:@"口語訳聖書"];
}

- (BOOL) isShangtiVersion {
    
    return [self.name isEqualToString:@"和合本修訂版（繁體）"] ||
    [self.name isEqualToString:@"和合本修订版（简体）"] ||
    [self.name isEqualToString:@"現代中文譯本（繁體）"] ||
    [self.name isEqualToString:@"新標點和合本（繁體）"] ||
    [self.name isEqualToString:@"新标点和合本（简体）"];
}

@end
