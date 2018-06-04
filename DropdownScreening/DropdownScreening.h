//
//  DropdownScreening.h
//  DadBuy
//
//  Created by 白仕云 on 2018/6/2.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import <UIKit/UIKit.h>


// #############  顶部DropdownTopViewItem #################

@interface DropdownTopViewItem : UIView
@end




// #############  顶部DropdownTopViewItem的父控件DropdownScreening #################
@interface DropdownScreening : UIView
/**
 初始化控件
 @param dropdownArray 传入的数据
 @return DropdownScreening
 */
-(instancetype)initWithFrame:(CGRect)frame DropdownArray:(NSArray *)dropdownArray;
/**
 选中的item数据
 */
@property (nonatomic ,copy)void(^DropdownDidSeletedItemBlock)(id obj);
@end





// #############  下拉控件的DropdownItemCell #################
typedef enum : NSUInteger {
    DropdownItemCellOnlyTitle,
    DropdownItemCellTitleAndSubTitle,
    DropdownItemCellImageAndTitle,
    DropdownItemCellImageAndTitleAndSubTitle,
} DropdownItemCellType;

@interface DropdownItemCell : UITableViewCell

@property (nonatomic ,strong)UILabel *ItemCellTitle;
@property (nonatomic ,strong)UIImageView *ItemCellImage;
@property (nonatomic ,strong)UILabel *ItemCellSubTitle;
/**
 重写UITableViewCell的init方法传入 DropdownItemCellType
 @param style UITableViewCell样式
 @param reuseIdentifier  cell重用Id
 @param cellType 下拉cell自定义样式
 @return DropdownItemCell
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier DropdownItemCellType:(DropdownItemCellType)cellType;
@end




// #############  下拉控件的DropdownTableView #################
@interface DropdownTableView : UITableView

@property (nonatomic ,strong)NSMutableArray *dataArray;

/**
 重写UITableView的init方法传入 DropdownItemCellType
 @param style UITableView样式
 @param cellType 下拉cell自定义样式
 @return DropdownTableView
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style  reuseIdentifier:(NSString *)reuseIdentifier DropdownItemCellType:(DropdownItemCellType)cellType;

@property (nonatomic ,copy)void(^GetCellDataWithIndexPath)(NSIndexPath *indexPath,DropdownItemCell* cell);
@property (nonatomic ,copy)void(^DidSelectItemAtIndexPath)(NSIndexPath *indexPath, DropdownItemCell* cell);
@end
