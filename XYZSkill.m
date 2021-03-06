//
//  XYZSkill.m
//  aLifeWorthLivingWithDBT
//
//  Created by Rachel Shin on 12/5/13.
//  Copyright (c) 2013 Rachel Shin. All rights reserved.
//

#import "XYZSkill.h"


@implementation XYZSkill

- (id) initWithKey:(NSString *) key {
    
    // pulled from https://developer.apple.com/library/mac/documentation/cocoa/conceptual/PropertyLists/QuickStartPlist/QuickStartPlist.html
    self = [super init];
    if (self) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"SkillProperties.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"SkillProperties" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *tempDict = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                             errorDescription:&errorDesc];
        if (!tempDict) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        // create array of dictionaries from key
        NSArray *dictArray = [[NSArray alloc] init];
        dictArray = [tempDict objectForKey:key];
        
        // create array of skill titles from key
        self.moduleSkillsArray = [[NSMutableArray alloc]init];
        
        // copy dictionary from plist for each skill
        NSDictionary *skillDict = [[NSDictionary alloc]init];
        NSString *tempString = [[NSString alloc]init];
        
        for (int i = 0; i < [dictArray count]; i++) {
            // find one skill dictionary in the key's array
            skillDict = [dictArray objectAtIndex:i];
            
            // find title of skill
            tempString = [skillDict objectForKey:@"Title"];
        
            // put title into XYZSkill's moduleSkillArray
            [self.moduleSkillsArray addObject:tempString];
        }
    }
    return self;
}

@end
