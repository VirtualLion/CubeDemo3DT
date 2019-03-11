//
//  ViewController.m
//  cubeDemo
//
//  Created by cksj on 16/4/19.
//  Copyright © 2016年 YZ. All rights reserved.
//

#import "ViewController.h"

//设置手动转动的速率
#define MMM M_PI/180*2

@interface ViewController ()

@end

@implementation ViewController{
    //矩形四面
    UIImageView * _view1;
    UIImageView * _view3;
    UIImageView * _view2;
    UIImageView * _view4;
    
    UIImageView * _view5;
    UIImageView * _view6;
    
    //父视图，用来承载转动图，没有也一样，只是方便控制转动视图的位置和大小
    UIView * _mainView;
    
    //记录触摸点，判断滑动方向
    CGPoint _point;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView {
    _view1 = [UIImageView new];
    _view3 = [UIImageView new];
    _view2 = [UIImageView new];
    _view4 = [UIImageView new];
    
    
    _mainView = [UIView new];
    
    _mainView.frame = CGRectMake(50, 100, self.view.bounds.size.width-100, self.view.bounds.size.width-100);
    
    [self.view addSubview:_mainView];
    

    _view1.frame = _mainView.bounds;
    _view3.frame = _mainView.bounds;
    _view2.frame = _mainView.bounds;
    _view4.frame = _mainView.bounds;
    
    _view1.backgroundColor = [UIColor redColor];
    _view3.backgroundColor = [UIColor greenColor];
    _view2.backgroundColor = [UIColor yellowColor];
    _view4.backgroundColor = [UIColor purpleColor];
    
    
    [_mainView addSubview:_view1];
    [_mainView addSubview:_view3];
    [_mainView addSubview:_view2];
    [_mainView addSubview:_view4];
    
    _view1.image = [UIImage imageNamed:@"1.jpg"];
    _view3.image = [UIImage imageNamed:@"3.jpg"];
    _view2.image = [UIImage imageNamed:@"2.jpg"];
    _view4.image = [UIImage imageNamed:@"4.jpg"];
    
    _view5 = [UIImageView new];
    _view5.frame = CGRectMake(0, 0, _mainView.bounds.size.width, _mainView.bounds.size.width);
    _view5.center = CGPointMake(_mainView.bounds.size.width/2, _mainView.bounds.size.height/2);
    _view5.backgroundColor = [UIColor redColor];
    [_mainView addSubview:_view5];
    _view5.image = [UIImage imageNamed:@"5.jpg"];
    
    _view6 = [UIImageView new];
    _view6.frame = CGRectMake(0, 0, _mainView.bounds.size.width, _mainView.bounds.size.width);
    _view6.center = CGPointMake(_mainView.bounds.size.width/2, _mainView.bounds.size.height/2);
    _view6.backgroundColor = [UIColor blackColor];
    [_mainView addSubview:_view6];
    
    //3D翻转设定
    [self createViewTransform3D];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:pan];
}

- (void)createViewTransform3D {
    
    //设定锚点在长方体中心
    _view1.layer.anchorPointZ = -_mainView.bounds.size.width/2;
    _view2.layer.anchorPointZ = -_mainView.bounds.size.width/2;
    _view3.layer.anchorPointZ = _mainView.bounds.size.width/2;
    _view4.layer.anchorPointZ = _mainView.bounds.size.width/2;
    
    
    _view1.layer.transform = CATransform3DRotate(_view1.layer.transform, M_PI/2, 0, 0, 0);
    _view2.layer.transform = CATransform3DRotate(_view2.layer.transform, M_PI/2, 0, 1, 0);
    _view3.layer.transform = CATransform3DRotate(_view3.layer.transform, M_PI, 0, 0, 0);
    _view4.layer.transform = CATransform3DRotate(_view4.layer.transform, M_PI/2, 0, 1, 0);
    
    
    
    
    _view5.layer.anchorPointZ = -_mainView.bounds.size.width/2;
    _view6.layer.anchorPointZ = _mainView.bounds.size.width/2;
    
//    _view5.layer.transform = CATransform3DMakeRotation(MMM*20, -1, 0, 0);
    _view5.layer.transform = CATransform3DRotate(_view5.layer.transform, M_PI/2, 1, 0, 0);
    _view6.layer.transform = CATransform3DRotate(_view6.layer.transform, M_PI/2, 1, 0, 0);

    

}



- (void)handlePan:(UIPanGestureRecognizer *)recognizer  {

//    NSLog(@"%.2f,%.2f,%.2f,%.2f",_view1.layer.transform.m11,_view1.layer.transform.m12,_view1.layer.transform.m13,_view1.layer.transform.m14);
//    NSLog(@"%.2f,%.2f,%.2f,%.2f",_view1.layer.transform.m21,_view1.layer.transform.m22,_view1.layer.transform.m23,_view1.layer.transform.m24);
//    NSLog(@"%.2f,%.2f,%.2f,%.2f",_view1.layer.transform.m31,_view1.layer.transform.m32,_view1.layer.transform.m33,_view1.layer.transform.m34);
//    NSLog(@"%.2f,%.2f,%.2f,%.2f",_view1.layer.transform.m41,_view1.layer.transform.m42,_view1.layer.transform.m43,_view1.layer.transform.m44);
//    NSLog(@"************************");
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //记录初始点
        _point = [recognizer translationInView:self.view];
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {
        //结束滑动，可以动画将转动视图 转到相应的位置
    }else {
        //判断滑动方向
        CGPoint velocity = [recognizer translationInView:self.view];
        if (velocity.x-_point.x>0) {
            _view1.layer.transform = CATransform3DRotate (_view1.layer.transform, MMM, 0, 1, 0);
            _view2.layer.transform = CATransform3DRotate (_view2.layer.transform, MMM, 0, 1, 0);
            _view3.layer.transform = CATransform3DRotate (_view3.layer.transform, MMM, 0, 1, 0);
            _view4.layer.transform = CATransform3DRotate (_view4.layer.transform, MMM, 0, 1, 0);
            _view5.layer.transform = CATransform3DRotate (_view5.layer.transform, MMM, 0, 0, -1);
            _view6.layer.transform = CATransform3DRotate (_view6.layer.transform, MMM, 0, 0, -1);
        }else{
            _view1.layer.transform = CATransform3DRotate (_view1.layer.transform, MMM, 0, -1, 0);
            _view2.layer.transform = CATransform3DRotate (_view2.layer.transform, MMM, 0, -1, 0);
            _view3.layer.transform = CATransform3DRotate (_view3.layer.transform, MMM, 0, -1, 0);
            _view4.layer.transform = CATransform3DRotate (_view4.layer.transform, MMM, 0, -1, 0);
            _view5.layer.transform = CATransform3DRotate (_view5.layer.transform, MMM, 0, 0, 1);
            _view6.layer.transform = CATransform3DRotate (_view6.layer.transform, MMM, 0, 0, 1);
        }
        if (velocity.y-_point.y>0) {
            _view1.layer.transform = CATransform3DRotate (_view1.layer.transform, MMM, -1, 0, 0);
            _view2.layer.transform = CATransform3DRotate (_view2.layer.transform, MMM, 0, 0, -1);
            _view3.layer.transform = CATransform3DRotate (_view3.layer.transform, MMM, -1, 0, 0);
            _view4.layer.transform = CATransform3DRotate (_view4.layer.transform, MMM, 0, 0, -1);
            _view5.layer.transform = CATransform3DRotate (_view5.layer.transform, MMM, -1, 0, 0);
            _view6.layer.transform = CATransform3DRotate (_view6.layer.transform, MMM, -1, 0, 0);
        }else{
            _view1.layer.transform = CATransform3DRotate (_view1.layer.transform, MMM, 1, 0, 0);
            _view2.layer.transform = CATransform3DRotate (_view2.layer.transform, MMM, 0, 0, 1);
            _view3.layer.transform = CATransform3DRotate (_view3.layer.transform, MMM, 1, 0, 0);
            _view4.layer.transform = CATransform3DRotate (_view4.layer.transform, MMM, 0, 0, 1);
            _view5.layer.transform = CATransform3DRotate (_view5.layer.transform, MMM, 1, 0, 0);
            _view6.layer.transform = CATransform3DRotate (_view6.layer.transform, MMM, 1, 0, 0);
        }
        
        
        _point = velocity;
    }
}

//- (void)runWithView:(UIView *)view fx:(CGFloat)x fy:(CGFloat)y{
//    
//    int a = 0;
//    CATransform3D tf = view.layer.transform;
//    if ((tf.m11>=0.7||tf.m11<=-0.7)&&(tf.m22>=0.7||tf.m22<=-0.7)) {
//        a = 13;
//    }else if ((tf.m11>=-0.7||tf.m11<=0.7)&&(tf.m22>=0.7||tf.m22<=-0.7)){
//        a = 24;
//    }else {
//        a = 56;
//    }
//    
//    switch (a) {
//        case 13:
//        {
//            if (x>0) {
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, 1, 0);
//            }else{
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, -1, 0);
//            }
//            if (y<0) {
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 1, 0, 0);
//            }else{
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, -1, 0, 0);
//            }
//            
//        }
//            break;
//        case 24:
//        {
//            if (x<0) {
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, 1, 0);
//            }else{
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, -1, 0);
//            }
//            if (y<0) {
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, 0, -1);
//            }else{
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, 0, 1);
//            }
//        }
//            break;
//        case 56:
//        {
//            if (x<0) {
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, 0, -1);
//            }else{
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 0, 0, 1);
//            }
//            if (y<0) {
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, 1, 0, 0);
//            }else{
//                view.layer.transform = CATransform3DRotate (view.layer.transform, MMM, -1, 0, 0);
//            }
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//}

@end
