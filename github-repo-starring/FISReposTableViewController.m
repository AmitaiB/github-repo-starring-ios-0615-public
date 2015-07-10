//
//  FISReposTableViewController.m
//  
//
//  Created by Joe Burgess on 5/5/14.
//
//

/**
 *  The FISViewController is meant to display the repos in the dataStore that were fetched by the APIClient
 *
 *  @param strong    <#strong description#>
 *  @param nonatomic <#nonatomic description#>
 *
 *  @return <#return value description#>
 */

#import "FISReposTableViewController.h"
#import "FISReposDataStore.h"
#import "FISGithubRepository.h"

@interface FISReposTableViewController ()
@property (strong, nonatomic) FISReposDataStore *dataStore;
@end

@implementation FISReposTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.accessibilityLabel=@"Repo Table View";
    self.tableView.accessibilityIdentifier=@"Repo Table View";

    self.tableView.accessibilityIdentifier = @"Repo Table View";
    self.tableView.accessibilityLabel=@"Repo Table View";
    self.dataStore                         = [FISReposDataStore sharedDataStore];
    [self.dataStore getRepositoriesWithCompletion:^(BOOL success) {
        
            //Thank you NSHipster, @nshipster.com/nsoperation
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataStore.repositories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];

    FISGithubRepository *selectedRepo = self.dataStore.repositories[indexPath.row];
    cell.textLabel.text = selectedRepo.fullName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSString *message = @"";
    
        //toggles star/unstar, then reports what it did in the block.
    [FISReposDataStore toggleStarForRepository:self.dataStore.repositories[indexPath.row]
                                WithCompletion:^(BOOL isStarred) {
                                    message = [NSString stringWithFormat:@"You just %@starred this repo!", (isStarred)? @"un" : @""];
                                }
     ];
   
    UIAlertController *alertController = 
        [UIAlertController alertControllerWithTitle:@"Report: Star Toggle"
                                            message:message
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertController 
                       animated:YES
                     completion:nil];
}

@end
