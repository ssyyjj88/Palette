//
//  ViewController.m
//  Palette
//
//  Created by 孙玉娟 on 16/7/11.
//  Copyright © 2016年 孙玉娟. All rights reserved.
//

#import "ViewController.h"
#import "InfColorPickerController.h"

@interface ViewController () <InfColorPickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self changeBackgroundColor];
}

- (IBAction) changeBackgroundColor
{
    InfColorPickerController* picker = [[ InfColorPickerController alloc ]init];
    
    //picker.sourceColor = self.view.backgroundColor;
    picker.delegate = self;
    
   // [ picker presentModallyOverViewController: self ];
    [self.navigationController pushViewController:picker animated:YES];
}

//------------------------------------------------------------------------------

- (void) colorPickerControllerDidFinish: (InfColorPickerController*) picker
{
    self.view.backgroundColor = picker.resultColor;
    
    [ self.navigationController popViewControllerAnimated:YES ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
