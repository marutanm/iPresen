#import <UIKit/UIKit.h>
#import "PageScrollView.h"

@interface PageControlViewController : UIViewController <PageScrollViewDelegate> {
    NSMutableArray *pages;
    PageScrollView *scrollView;
}

- (void)pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView currentPage:(int)currentPage;


@end

