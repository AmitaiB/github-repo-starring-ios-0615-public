//
//  FISGithubAPIClient.h
//  github-repo-list
//
//  Created by Joe Burgess on 5/5/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *const GITHUB_API_URL;
@interface FISGithubAPIClient : NSObject

///---------------------
/// @name Class Methods
///---------------------

/**
 *  Does a `GET` request to the [Github repository API](https://developer.github.com/v3/repos/#list-all-public-repositories) with the `client_id` and `client_secret` parameters as well.
 *  @param completionBlock Block to be called when finished retreiving from the API. Passes an `NSArray` of `NSDictionary` objects from the API.
 */

+(void)getRepositoriesWithCompletion:(void (^)(NSArray *repoDictionaries))completionBlock;


/**
 *  Check If Starred
 *
 *  @param fullName full_name from a Github repo JSON dictionary.
 *
 *  @return Is the repo already starred? YES / NO (Github URL: $ GET /user/starred/:owner/:repo) receive either a 204 (YES) or 404 (NO)
 */
+(void)getRepoStarredStatus:(NSString *)repoFullName WithCompletion:(void (^)(BOOL))completionBlock;

+(void)starRepoWithName:(NSString*)repoFullName WithCompletion:(void (^)(BOOL))completionBlock;

+(void)unstarRepoWithName:(NSString*)repoFullName WithCompletion:(void (^)(BOOL))completionBlock;


@end
