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

/*
 +(void)getRepoStarredStatus:(NSString*)repoFullName WithCompletion:(void(^)(BOOL))completionBlock;
 +(void)starRepoWithName:    (NSString*)repoFullName WithCompletion:(void(^)(BOOL))completionBlock;
 +(void)unstarRepoWithName:  (NSString*)repoFullName WithCompletion:(void(^)(BOOL))completionBlock;
 
 */

+(void)getRepoStarredStatus:(NSString*)repoFullName WithCompletion:(void(^)(BOOL))completionBlock
{
    NSString *githubIsStarredQueryURL = [NSString stringWithFormat:@"%@/user/starred%@", GITHUB_API_URL, repoFullName];
    
        //Instantiate a session...
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    __block NSDictionary *queryResult = @{};
        //...and make the GET request.
    [manager GET:githubIsStarredQueryURL 
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             queryResult = responseObject;
             if ([queryResult[@"Status"] isEqualToString:@"204 No Content"]) {
                 isStarred = YES;
             } else {isStarred = NO;}
         } 
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    return isStarred;
}
 


@end
