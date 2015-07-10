//
//  FISReposDataStore.h
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISGithubRepository.h"

@interface FISReposDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *repositories;

+ (instancetype)sharedDataStore;

- (void)getRepositoriesWithCompletion:(void (^)(BOOL success))completionBlock;
+ (void)toggleStarForRepository:(FISGithubRepository*)repo WithCompletion:(void (^)(BOOL isStarred))completionBlock;
@end
