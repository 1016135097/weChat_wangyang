//
//  DS_BaseTableViewController.h
//  WeChat
//
//  Created by wangyang on 16/5/14.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_BaseViewController.h"
#import "DS_SearchBarView.h"
//@class DS_SearchBarView;

typedef void (^tableViewCellBlock)(UITableView *tableView,UITableViewCell *cell,NSIndexPath *indexPath,id model);

@interface DS_BaseTableViewController : DS_BaseViewController<UITableViewDataSource,UITableViewDelegate> {
    NSString *_searchString;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataSourceArray;
@property (nonatomic,assign)CGFloat cellHeight;

- (void)tableViewCellBlock:(tableViewCellBlock)block;
- (void)tableViewDidClickBlock:(tableViewCellBlock)block;
- (void)tableViewDidUnClickBlock:(tableViewCellBlock)block;
/**
 *   @required
 */
//overWrite tableView
- (void)registerTableViewCellClass;
- (UITableView *)allocTableView;
- (CGFloat)headerHeight;
- (CGFloat)footerHeight;
//- (void)updateViewTableViewConstraints;

//overWrite searchBar and searchDisplayController
@property (nonatomic,strong)DS_SearchBarView *seachBarView;
@property (nonatomic,strong)UISearchDisplayController *searchController;
@property (nonatomic,strong)UIView *shadeSearchBarView;
@property (nonatomic,strong)NSMutableArray *searchDataArray;

/**
 * search cell register
 */
- (void)registerSearchTableViewCellClass;

/**
 * subView add function when ScrollViewDidScroll
 */
- (void)tableViewScrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface DS_LanguageCell : UITableViewCell

@end
