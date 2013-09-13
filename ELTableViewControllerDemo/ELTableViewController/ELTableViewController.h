//
//  ELTableViewController.h
//
//  Created by yanghua_kobe on 12/1/12.
//  Copyright (c) 2012 yanghua_kobe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "LoadMoreTableFooterView.h"
#import "IconDownloader.h"

//blocks for UITableView delegate
typedef UITableViewCell* (^cellForRowAtIndexPathDelegate) (UITableView *,NSIndexPath *);
typedef CGFloat (^heightForRowAtIndexPathDelegate) (UITableView *,NSIndexPath *);
typedef void (^didSelectRowAtIndexPathDelegate) (UITableView *,NSIndexPath *);

//blocks for refresh and load more
typedef void (^refreshDataSourceFunc) (void);
typedef void (^loadMoreDataSourceFunc) (void);

typedef void (^refreshDataSourceCompleted) (void);
typedef void (^loadMoreDataSourceCompleted) (void);
//use to load image (async)
typedef void (^loadImagesForVisiableRowsFunc) (void);
typedef void (^appImageDownloadCompleted) (NSIndexPath *);

@interface ELTableViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource,
EGORefreshTableHeaderDelegate,
LoadMoreTableFooterDelegate,
IconDownloaderDelegate
>

@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) NSMutableDictionary *imageDownloadsInProgress;

/**
 *if you havn't special Object for stone downloaded image instance, use it!
 *added by:yanghua
 *date: 2013-3-27
 */
@property (nonatomic,retain) NSMutableDictionary *imageDownloadedInstances;

@property (nonatomic,retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic,retain) LoadMoreTableFooterView *loadMoreFooterView;

//readonly properties
@property (nonatomic,assign,readonly) BOOL refreshHeaderViewEnabled;
@property (nonatomic,assign,readonly) BOOL loadMoreFooterViewEnabled;

@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isLoadingMore;

//use to judge refresh or loadmore
@property (nonatomic,assign) CGPoint currentOffsetPoint;

//property for blocks
@property (nonatomic,copy) cellForRowAtIndexPathDelegate cellForRowAtIndexPathDelegate;
@property (nonatomic,copy) heightForRowAtIndexPathDelegate heightForRowAtIndexPathDelegate;
@property (nonatomic,copy) didSelectRowAtIndexPathDelegate didSelectRowAtIndexPathDelegate;

@property (nonatomic,copy) loadMoreDataSourceFunc loadMoreDataSourceFunc;
@property (nonatomic,copy) refreshDataSourceFunc refreshDataSourceFunc;
@property (nonatomic,copy) refreshDataSourceCompleted refreshDataSourceCompleted;
@property (nonatomic,copy) loadMoreDataSourceCompleted loadMoreDataSourceCompleted;

@property (nonatomic,copy) loadImagesForVisiableRowsFunc loadImagesForVisiableRowsFunc;
@property (nonatomic,copy) appImageDownloadCompleted appImageDownloadCompleted;


- (id)initWithRefreshHeaderViewEnabled:(BOOL)enableRefreshHeaderView 
andLoadMoreFooterViewEnabled:(BOOL)enableLoadMoreFooterView;

- (id)initWithRefreshHeaderViewEnabled:(BOOL)enableRefreshHeaderView 
          andLoadMoreFooterViewEnabled:(BOOL)enableLoadMoreFooterView 
                     andTableViewFrame:(CGRect)frame;

- (void)initBlocks;

/**
 *	@brief	delete extra cell line when data can not fill a screen
 *          called by yourself business code after calling method:
 *          [self.tableView reloadData];
 *
 */
- (void)removeExtraCellLine;

@end



@interface ELTableViewController (Extension)

- (CGRect)ScreenBounds;
- (CGRect)NavigationFrame;

@end

@implementation ELTableViewController (Extension)

- (CGRect)ScreenBounds{
    CGRect bounds = [UIScreen mainScreen].bounds;
    return bounds;
}

- (CGRect)NavigationFrame {
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    return CGRectMake(0, 0, frame.size.width, frame.size.height - 44.0f);
}


@end
