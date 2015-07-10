//
//  FISGithubAPIClient.m
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISGithubAPIClient.h"
#import "FISConstants.h"
#import "FISReposDataStore.h"
//#import "FISGithubRepository.h"
#import <AFNetworking.h>

@implementation FISGithubAPIClient
NSString *const GITHUB_API_URL=@"https://api.github.com";

+(void)getRepositoriesWithCompletion:(void (^)(NSArray *))completionBlock
{
    NSString *githubURL = [NSString stringWithFormat:@"%@/repositories?client_id=%@&client_secret=%@",GITHUB_API_URL,GITHUB_CLIENT_ID,GITHUB_CLIENT_SECRET];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:githubURL 
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject)   {completionBlock(responseObject);}
         failure:^(NSURLSessionDataTask *task, NSError *error)      {NSLog(@"Fail: %@",error.localizedDescription);}
     ];
}


-(BOOL)checkIfStarred:(NSString *)fullName {
        //This returns repos because of the URL hard-coded into githubURL (above) "/repositories?..."
    FISReposDataStore *reposDataStore = [FISReposDataStore sharedDataStore];
    
    [FISGithubAPIClient getRepositoriesWithCompletion:^(NSArray *repoDictionaries) {
        reposDataStore.repositories = [repoDictionaries mutableCopy];
    }];
    
    
    
    
//    FISGithubRepository *namedRepo = [[FISGithubRepository alloc] init];
    __block BOOL isStarred;
    [reposDataStore.repositories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *fullNameFromURL = obj.fullName;
        if ([fullName isEqualToString: fullNameFromURL]) {
            
        }
    }];
    
}



@end
