评分模型_推断
====

#根据业务需求，本项目采用通用数据挖掘流程CRISP-DM，步骤分为：<br>
1.业务理解 <br>
2.数据理解 <br>
3.数据准备 <br>
4.模型搭建 <br>
5.模型评估 <br>
6.模型发布

----------

1.业务理解：<br>
    本项目是一个关于亚马逊review的评分问题，亚马逊的每一个在售的产品，都会有买家进行评论（review）及评分，商品的总评分，原来是用算数平均的方法计算的，非常容易理解。但是后来亚马逊对于评分引入了机器学习的算法，就变的复杂了起来。

    亚马逊的原文描述是：Amazon calculates a product’s star ratings using a machine learned model instead of a raw data average. The machine learned model takes into account factors including: the age of a review, helpfulness votes by customers and whether the reviews are from verified purchases.

    翻译一下就是：亚马逊使用机器学习模型来计算产品的星级，而不是原始数据平均值。机器学习模型需要考虑的因素包括：一个评价的时效、认为评论有效的投票数、以及是否是VP（购买后的评价，因为亚马逊也可以允许非购买人员留评）。

1.1 需求：<br>
    搞清楚亚马逊对于“评价时长”“有效数”“VP”的各自权重(包括正负相关性)，以便我们在进行增加review（其实就是电商通常会采取的刷单、刷评论）时，能够在增加一定的review数量后，得到我们想要的总分数。

 1.2 解决方案：<br>
    通过对“评价时长”、“有效数”、“VP”三个字段的联系建立线性回归模型。
 第一阶段采用最小二乘回归探索模型的有效性等指标，符合条件后，结束流程，不符合进入第二阶段算法探索；


2.数据理解：<br>
2.1 数据只表示采集当天的状态，因此数据的可用性有非常大的局限。

*亚马逊商品评论数据
数据包括：reviews-20170810 ；reviews-20170822 
          分别表示20170810、20170822亚马逊商品评论数据列表

 数据量：大概100万个商品，以及每个商品的每一条review数据，同时为了观察时效的影响，10天后又对相同的100w商品的review又爬了一次。

2.2 字段说明：
rowid               （有些表没有该列，无效列）
Asia                商品编号
StarSum	            总分数
ReviewSum	        总评论数（部分计算有错误，删除，可通过条数计算）
Star	            每个评论的分数
Author	            每个评论的作者
ReviewDate	        每个评论的时间
AgeReview	        评论距当前时间
HelpfulVote	        每个评论的支持投票数
VerifiedPurchase	每个评论是否为已购买者验证
CommentNum          每个评论对应的回复评价数


3.数据准备：
什么时候改变的评分规则？
改变规则后 之前的评分是如何处理的？
将十天后的数据用做测试集（还有没有别的用法？）
评分多久刷新一次？

评价时效：评论距当前的时间
认为评论有效的投票数：每个评论的支持投票数
是否是VP：

作者（Author)与项目目标无关：去除


****
具体步骤见 dataexplore.r
          dataanalysis.r
*****           

4.模型搭建：
