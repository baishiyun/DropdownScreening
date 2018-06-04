//
//  DropdownScreening.m
//  DadBuy
//
//  Created by 白仕云 on 2018/6/2.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "DropdownScreening.h"
#define TopViewTag  2000000
#define RightLineTag  1000000


// #############  顶部DropdownTopViewItem #################

@interface DropdownTopViewItem()
@property (nonatomic ,strong) UIView *rightLine;
@property (nonatomic ,strong) UIView *bottomLine;

@end


@implementation DropdownTopViewItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.rightLine];
        [self addSubview:self.bottomLine];
        self.rightLine.tag = RightLineTag;

    }
    return self;
}
-(UIView *)rightLine
{
    if (!_rightLine) {
        _rightLine = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-5, 10, 1, self.frame.size.height-20)];
        _rightLine.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.5];
    }
    return _rightLine;
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        _bottomLine.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.3];
    }
    return _bottomLine;
}
@end


// #############  顶部DropdownTopViewItem的父控件DropdownScreening #################
@interface DropdownScreening ()
@property (nonatomic ,strong)NSMutableArray *bsyChildArray;
@end

@implementation DropdownScreening

/**
 初始化控件
 @param dropdownArray 传入的数据
 @return DropdownScreening
 */
-(instancetype)initWithFrame:(CGRect)frame DropdownArray:(NSArray *)dropdownArray
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.bsyChildArray removeAllObjects];
        [self.bsyChildArray addObjectsFromArray:dropdownArray];
        [self creatUIForTitleBtnScreeningWithArray:dropdownArray];
    }
    return self;
}

/**
 创建顶部TitleView
 @param array 根据数组组数来创建需要的View
 */
- (void)creatUIForTitleBtnScreeningWithArray:(NSArray *)array
{
    for (DropdownTopViewItem *itemView in self.subviews) {
        if (itemView.tag>=TopViewTag) {
            [itemView removeFromSuperview];
        }
    }
    CGFloat  With= [UIScreen mainScreen].bounds.size.width/(array.count>0?array.count:1);
    for (int index=0; index<array.count; index++) {

        DropdownTopViewItem *Item = [[DropdownTopViewItem alloc]initWithFrame:CGRectMake(With*index, 0, With, self.frame.size.height)];
        Item.tag =TopViewTag+index;
        [self addSubview:Item];
        if (array.count-1==index) {
            UIView *rightLine = [Item viewWithTag:RightLineTag];
            [rightLine removeFromSuperview];
        }

        UIButton *ItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ItemBtn.frame = CGRectMake(0, 0, With-5, Item.frame.size.height);
        [ItemBtn setTitle:array[index] forState:UIControlStateNormal];
        [ItemBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [ItemBtn setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
        [ItemBtn setImageEdgeInsets:UIEdgeInsetsMake(5, With-20, 0, -10)];
        [ItemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Item addSubview:ItemBtn];
        [ItemBtn addTarget:self action:@selector(ItemBtnActionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
/**
 点击点击顶部的按钮
 @param itemBtn 点击顶部的按钮
 */
-(void)ItemBtnActionClick:(UIButton *)itemBtn
{
    [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(5, itemBtn.frame.size.width-20, 0, -10)];
    [UIView animateWithDuration:0.5 animations:^{
        itemBtn.imageView.transform = CGAffineTransformRotate(itemBtn.imageView.transform, M_PI);
    }];

    if (self.DropdownDidSeletedItemBlock) {
        self.DropdownDidSeletedItemBlock([self.bsyChildArray objectAtIndex:itemBtn.tag]);
    }
}
-(NSMutableArray *)bsyChildArray
{
    if (!_bsyChildArray) {
        _bsyChildArray = [NSMutableArray array];
    }
    return _bsyChildArray;
}
@end





// #############  下拉控件的DropdownItemCell #################
@interface DropdownItemCell()

@end

@implementation DropdownItemCell
/**
 重写UITableViewCell的init方法传入 DropdownItemCellType
 @param style UITableViewCell样式
 @param reuseIdentifier  cell重用Id
 @param cellType 下拉cell自定义样式
 @return DropdownItemCell
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier DropdownItemCellType:(DropdownItemCellType)cellType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self creatUIForDropdownItemCellType:cellType];
    }
    return self;
}

-(void)creatUIForDropdownItemCellType:(DropdownItemCellType)cellType
{

    if (cellType==DropdownItemCellOnlyTitle) {
        self.ItemCellTitle.frame = CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height);
        [self addSubview:self.ItemCellTitle];
    }else if (cellType==DropdownItemCellImageAndTitle){
        self.ItemCellImage.frame = CGRectMake(10, 0, self.frame.size.height, self.frame.size.height);
        [self addSubview:self.ItemCellTitle];
        self.ItemCellTitle.frame = CGRectMake(self.frame.size.height+20, 0, self.frame.size.width-self.frame.size.height-30, self.frame.size.height);
        [self addSubview:self.ItemCellTitle];
    }else if (cellType==DropdownItemCellTitleAndSubTitle){
        self.ItemCellTitle.frame = CGRectMake(10, 0, self.frame.size.width-150, self.frame.size.height);
        self.ItemCellSubTitle.frame = CGRectMake(self.frame.size.width-150, 0, 130, self.frame.size.height);
    }else if (cellType==DropdownItemCellImageAndTitleAndSubTitle){
        self.ItemCellImage.frame = CGRectMake(10, 0, self.frame.size.height, self.frame.size.height);
        [self addSubview:self.ItemCellTitle];
        self.ItemCellTitle.frame = CGRectMake(self.frame.size.height+20, 0, ((self.frame.size.width-self.frame.size.height-30)/3.0)*2, self.frame.size.height);
        self.ItemCellSubTitle.frame = CGRectMake(((self.frame.size.width-self.frame.size.height-30)/3.0)*2+10, 0, ((self.frame.size.width-self.frame.size.height-30)/3.0)-10, self.frame.size.height);
    }
}

-(UILabel *)ItemCellTitle
{
    if (!_ItemCellTitle) {
        _ItemCellTitle  =[[UILabel alloc]init];
        _ItemCellTitle.font=[UIFont systemFontOfSize:14];
        _ItemCellTitle.textColor = [UIColor blackColor];
    }
    return _ItemCellTitle;
}

-(UIImageView *)ItemCellImage
{
    if (!_ItemCellImage) {
        _ItemCellImage  =[[UIImageView alloc]init];
    }
    return _ItemCellImage;
}

-(UILabel *)ItemCellSubTitle
{
    if (!_ItemCellSubTitle) {
        _ItemCellSubTitle  =[[UILabel alloc]init];
        _ItemCellSubTitle.font=[UIFont systemFontOfSize:14];
        _ItemCellSubTitle.textColor = [UIColor lightGrayColor];
    }
    return _ItemCellSubTitle;
}
@end


// #############  下拉DropdownTableView #################
@interface DropdownTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,assign) DropdownItemCellType cellType;
@property (nonatomic ,copy)NSString *cellReuseIdentifier;
@end

@implementation DropdownTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style reuseIdentifier:(NSString *)reuseIdentifier DropdownItemCellType:(DropdownItemCellType)cellType
{
    self.cellType = cellType;
    self.cellReuseIdentifier = reuseIdentifier;
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropdownItemCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier];
    if (!cell) {
        cell = [[DropdownItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellReuseIdentifier DropdownItemCellType:self.cellType];
    }
    [self reloadDataWithIndexPath:indexPath cell:cell];
    return cell;
}
-(void)reloadDataWithIndexPath:(NSIndexPath *)indexPath cell:(DropdownItemCell *)cell
{
    if (self.GetCellDataWithIndexPath) {
        self.GetCellDataWithIndexPath(indexPath,cell);
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DropdownItemCell *cell = (DropdownItemCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (self.DidSelectItemAtIndexPath) {
        self.DidSelectItemAtIndexPath(indexPath, cell);
    }
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}
@end

