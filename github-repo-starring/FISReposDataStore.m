//
//  FISReposDataStore.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISReposDataStore.h"
#import "FISGithubAPIClient.h"
#import "FISGithubRepository.h"

@implementation FISReposDataStore
+ (instancetype)sharedDataStore {
    static FISReposDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISReposDataStore alloc] init];
    });

    return _sharedDataStore;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _repositories=[NSMutableArray new];
    }
    return self;
}
-(void)getRepositoriesWithCompletion:(void (^)(BOOL))completionBlock
{
    [FISGithubAPIClient getRepositoriesWithCompletion:^(NSArray *repoDictionaries) {
        for (NSDictionary *repoDictionary in repoDictionaries) {
            [self.repositories addObject:[FISGithubRepository repoFromDictionary:repoDictionary]];
        }
        completionBlock(YES);
    }];
}

/**
 *  This method will check to see if a repo is starred or not, and then will either star or unstar the repo.
 *  In the completionBlock, there should be a BOOL parameter called starred that is YES if the repo was just starred, and NO if it was just unstarred.
 *
 *  @param repo            <#repo description#>
 *  @param completionBlock <#completionBlock description#>
 */
+ (void)toggleStarForRepository:(FISGithubRepository *)repo WithCompletion:(void (^)(BOOL isStarred))completionBlock
{
    [FISGithubAPIClient getRepoStarredStatus:repo.fullName WithCompletion:^(BOOL isStarred) {
        if (isStarred) {
            [FISGithubAPIClient unstarRepoWithName:repo.fullName WithCompletion:^(BOOL unstarSuccess) {
                //report that we've just unstarred it.
            }];
        } else {
            [FISGithubAPIClient starRepoWithName:repo.fullName WithCompletion:^(BOOL starSuccess) {
                    //report that we've just starred it.
            }];
        }
    }];
}



@end
