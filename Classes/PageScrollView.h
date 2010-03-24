#import <UIKit/UIKit.h>

@interface PageScrollView : UIView <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
    CGRect _pageRegion, _controlRegion;
    NSMutableArray *_pages;
    id _delegate;
}

- (void)layoutViews;
- (void)notifyPageChange;

@property(nonatomic,assign,getter=getPages) NSMutableArray *pages; /* UIViewのサブクラスの格納用 */
@property(nonatomic,assign,getter=getCurrentPage) int currentPage; 
@property(nonatomic,assign,getter=getDelegate) id delegate; /* PageScrollViewDelegate */
@end

@protocol PageScrollViewDelegate <NSObject>

@optional

- (void)pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView currentPage:(int)currentPage;

@end
