# iOS开发 - 动画简介
---------------------
## 概述
动画是移动端开发比较重要的一部分。也许有些人因为公司业务的特点，日常工作中没什么机会涉及到动画，但是作为一个iOS开发者，掌握动画的基础知识仍然是必要的（至少能在面试中有所帮助吧😋）。
希望能在这篇文章中让大家对iOS动画有所了解，获得动画实现的一些思路，可以自己实现更加华丽的动画效果。
计划包括如下内容和一些Demo:
- [ ] CALayer
    - [ ] 常见属性
    - [ ] 绘图
- [ ] Core Animation
    - [ ] CABasicAnimation
    - [ ] CAKryFrameAnimation
    - [ ] CAAnimationGroup
    - [ ] CADisplayLink
    - [ ] 交互动画
    - [ ] CGAffineTransform和矩阵变换
- [ ] 番外篇
- [ ] Demo

## CALayer
在开始之前，推荐大家读一篇文章：[绘制像素到屏幕上](https://objccn.io/issue-3-1/)。这是一篇写原理的文章。这类文章我个人的看法是可能开始的时候你不是必须了解它，但是如果你需要进阶，了解原理是很必要的。

### CALayer和UIView的关系
每个UIView都默认包含一个layer. CALayer可以理解成一个画布，我们在UIView上看到的东西，实际都是由CALayer来呈现的。UIView是UIResponder的子类，它的职责是负责和用户交互。
CALayer和UIView的关系是这样的：

![UIView-CALayer](./res/uiview-calayer.png)

### 属性篇
这节里，我想要讨论一些CALayer里比较有意思的属性。关于*有意思*，指的是那些很容易混淆或者被忽略的属性。主要是我想不出什么词可以准确而且不啰嗦的表达我的意思。
CALayer比较常用的属性如下（有落下的请指出）：
- 位置属性
    - bounds，大小，它和`frame`的区别就是`bounds`的`origin`总是(0, 0),还有一点我不太确定，就是bounds和frame的size有没有可能不一样（UIView会有，在做旋转变换的时候），我会写个demo测试一下。
    - frame，大小+位置,和bounds的区别里少些了一条，**frame不支持隐式动画**。
    - position，中心点，相当于`UIView`的`center`
    - anchorPoint(anchorPointZ)，锚点
- 形状
    - backgroundColor，背景色
    - borderColor，边框色
    - borderWidth，边框宽度
    - shadowColor，阴影颜色
    - shadowOffset，阴影距离
    - shadowOpacity，阴影透明度
    - shadowPath，阴影形状
    - shadowRadius，阴影模糊半径
    - cornerRadius, 圆角半径
    - mask，蒙版
    - maskToBounds, 子图层是否剪切图层边界，默认为NO
    - opacity, 透明度，对应`UIView`的`alpha`
- hidden
- sublayers
- contents，显示的内容, 这个属性比较有迷惑性
- contentsRect，显示内容的位置和大小
- transform, 矩阵变换

#### bounds和frame
面试的时候通常这两个属性的区别，大家都能答出来。但是我曾经问过一个问题：它们两个的size在什么情况下不一样，很多人就会卡壳。
我写了一个demo，来观察在`CALayer`旋转的时候，`bounds`和`frame`的`size`是否也会像`UIView`的`bounds`和`frame`似的，`size`不同。
代码片段：
![bounds.vs.frame.code](./res/bounds.vs.frame.code.png)
执行结果如下：
![bounds.vs.frame.demo](./res/bounds.vs.frame.demo.png)
`bounds`和`frame`在demo中是这样的：
![bounds.frame.diagram](./res/bounds.frame.diagram.jpeg)
另外，上文提到了，frame不支持隐式动画。
CALayer中大部分属性都支持隐式动画。所以隐式动画，就是当你修改了某个属性的时候，自动会有动画效果，不需要你做什么。


#### anchorPoint

#### content

#### transform
请参考章节：CGAffineTransform和矩阵变换。希望我能够说明白，线性代数都还给老师了。

### 绘制篇

## Core Animation

### CABasicAnimation

### CAKeyFrameAnimation

### CAAnimationGroup

### CADisplayLink

### 交互动画

### CGAffineTransform和矩阵变换

### 番外篇
写这样一章，是因为有一些不确定放在哪里合适的内容。有些内容可能不太成系统，但是值得写一下。

### Demo

