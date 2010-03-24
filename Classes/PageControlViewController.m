#import "PageControlViewController.h"

@implementation PageControlViewController

- (void)loadView {
    [super loadView];
    
    /* ページ表示のデモ用画像のロードする */
    pages = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++) {
        NSLog(@"デモ用画像のダウンロード中 %d\n", i);
        UIImage *background = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.zdziarski.com/demo/black.png"]]];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.zdziarski.com/demo/%d.png", i+1]]]];
        UIImageView *page = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        page.image = background;
        UIImageView *subview = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        subview.image = image;
        subview.bounds = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
        [page addSubview:subview];
        [pages addObject:page];    
    }
    
    scrollView = [[PageScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pages = pages;
    scrollView.delegate = self;
    self.view = scrollView;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
    [scrollView release];
    [super dealloc];
}

-(void) pageScrollViewDidChangeCurrentPage:(PageScrollView *)pageScrollView currentPage:(int)currentPage {
    NSLog(@"現在表示中のページ %d\n", currentPage);
}

@end
