//
//  TestViewController.m
//  FastEasyBlog
//
//  Created by yanghua_kobe on 12/1/12.
//  Copyright (c) 2012 yanghua_kobe. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

- (void)loadDataSource;

- (void)initBlocks;

@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initBlocks];
    [self loadDataSource];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - private methods -
- (void)loadDataSource{
    self.dataSource=[NSMutableArray array];
    [self.dataSource addObject:@"dataSource_1"];
    [self.dataSource addObject:@"dataSource_2"];
    [self.dataSource addObject:@"dataSource_3"];
    [self.dataSource addObject:@"dataSource_4"];
    [self.dataSource addObject:@"dataSource_5"];
    [self.dataSource addObject:@"dataSource_6"];
    [self.dataSource addObject:@"dataSource_7"];
    [self.dataSource addObject:@"dataSource_8"];
    [self.dataSource addObject:@"dataSource_9"];
    [self.dataSource addObject:@"dataSource_10"];
}

- (void)initBlocks{
    __block TestViewController *blockedSelf=self;
    
    //load more
    self.loadMoreDataSourceFunc=^{
        [blockedSelf.dataSource addObject:@"loadMoreDataSourceBlock_1"];
        [blockedSelf.dataSource addObject:@"loadMoreDataSourceBlock_2"];
        [blockedSelf.dataSource addObject:@"loadMoreDataSourceBlock_3"];
        [blockedSelf.dataSource addObject:@"loadMoreDataSourceBlock_4"];
        [blockedSelf.dataSource addObject:@"loadMoreDataSourceBlock_5"];
        
        blockedSelf.isLoadingMore=YES;
        [self.tableView reloadData];
        
        NSLog(@"loadMoreDataSourceBlock was invoked");
    };
    
    //load more completed
    self.loadMoreDataSourceCompleted=^{
        blockedSelf.isLoadingMore=NO;
        [blockedSelf.loadMoreFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self.tableView];
        
        NSLog(@"after loadMore completed");
    };
    
    //refresh
    self.refreshDataSourceFunc=^{
        blockedSelf.dataSource=[NSMutableArray array];
        [blockedSelf.dataSource addObject:@"refreshDataSourceBlock_1"];
        [blockedSelf.dataSource addObject:@"refreshDataSourceBlock_2"];
        [blockedSelf.dataSource addObject:@"refreshDataSourceBlock_3"];
        [blockedSelf.dataSource addObject:@"refreshDataSourceBlock_4"];
        [blockedSelf.dataSource addObject:@"refreshDataSourceBlock_5"];
        
        blockedSelf.isRefreshing=YES;
        [self.tableView reloadData];
        
        NSLog(@"refreshDataSourceBlock was invoked");
    };
    
    //refresh completed
    self.refreshDataSourceCompleted=^{
        blockedSelf.isRefreshing=NO;
        [blockedSelf.loadMoreFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self.tableView];
        
        NSLog(@"after refresh completed");
    };
    
    self.cellForRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        static NSString *cellIdentifier=@"cellIdentifier";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
        }
        
        cell.textLabel.text=[blockedSelf.dataSource objectAtIndex:indexPath.row];
        
        NSLog(@"block:cellForRowAtIndexPathBlock has been invoked.");
        
        return cell;
    };
    
    self.heightForRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        NSLog(@"block:heightForRowAtIndexPathBlock has been invoked.");
        return 60.0f;
    };
    
    self.didSelectRowAtIndexPathDelegate=^(UITableView *tableView, NSIndexPath *indexPath){
        NSLog(@"block:didSelectRowAtIndexPathDelegate has been invoked.");
    };
    
}

@end
