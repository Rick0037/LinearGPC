## 机器学习控制（MLC）
1.本文主要提供了算法原理的讲解.  
2.和MLC代码设计的思想相关实现.  
3.以及一些简单示例的结果和课题结果.  

### 机器学习控制的讲解和进化算法的原理
![P} PO{IHH9QZGH(@70YM$QH](https://user-images.githubusercontent.com/86883267/128360372-5020b6ad-8d3a-47dc-a34f-c67ecc53c287.png)  
传统的反馈控制方法依靠信号反馈来控制，控制方程根据计算预先设定，但是在面对复杂系统时我们有时根本无法预测。  
这时我们可以在外部增加一个学习过程的环路，使用机器学习控制来轻松达到我们的目的--寻找最优控制。  
  
![image](https://user-images.githubusercontent.com/86883267/128361831-e879adec-62c6-43f2-8b63-eeebfb79a941.png)  
遗传算法能很好的解决寻优问题，他通过一代一代的判断与进化找到最优控制的控制方法。  
其中比较有名的是交叉、复制、变异等操作，  
交叉（Crossover）是在父代中选取两个个体进行染色体的交换，  
变异（Mutation）是父代中的染色体随机变异成其他的染色体，
复制是（Replication）附带的染色体在一定程度上直接不变进入下一代。  

主要的流程如下所示：
1.初始化种群  
2.对种群进行评价和排名  
3.在种群中采用交叉、复制、变异等操作生成下一代  
4.判断是否达到最优解或指定代数  
5.结束或进行下一代返回步骤2    


### MLC代码思想和具体实现

![8TEA835SN0Q3_3INE74UDJV](https://user-images.githubusercontent.com/86883267/128370634-17cef9f0-58bb-4d99-aa4e-87b87fa12036.png)

目录主要时分为MLC类、MLCtable类、MLCpop类、MLCind类  

从顶向下的向外展现，最外层是MLC类MLC.m包含所常用成员函数和方法  
例如直接对项目操作的方法，查看最优个体 MLC.bestindividual  
查看学习曲线MLC.converenge 查看某一代的的控制方程的分布情况MLC.CL_descriptions  
当然还有对于进化过程本身的操作go.m, evaluate_population, evolve_population等成员函数在MLC类中都是对整个项目上的操作  

MLC类在进行进化时并不能对每一代来进行操作  
每一代的操作时调用MLCpop类中的函数进行的，针对具体一代的个体进行操作都被封装在了  
MLCpop类中，比如对MLC的进化操作evolve对应在底层就会调用MLCpop类中的Crossover，Mutation，Replication  
在实际的进化过程中都是用MLCpop中的方法来针对这一带进行操作，包括根据概率筛选个体。  

由于一代会有很多的个体，针对个体individual的操作方法自然而然的封装在了MLCind类中  
MLCpop类中的Crossover，Mutation，Replication方法针对每个要进行遗传操作的个体自动调用  
MLCind类中的Crossover，Mutation，Replication方法，实现了方法重写  

MLCind类完成后返回Pop类的操作中，最后返回了MLC类（也就是用户直接操作的界面）实现了自顶向下，  
逐层应用逐层的返回。  

## 简单问题的示例

![YCPWWOKXQRPN}H6ZO6AU930](https://user-images.githubusercontent.com/86883267/128376330-bcd98b90-e634-40d9-a786-e75cd6853687.png)   
我们示例的模型是平均场模型在初始条件下我们的a1 a2 是在一个极限环之内，我们的控制目标是让J（a1^2+a2^2）值最小， 
所以我们要在a3,a4添加控制，经过MLC的学习后看见学习过程曲线如下图所示慢慢收敛，最优个体也完全的符合我们目标的预期（a1^2+a2^2==0）  
![FUCRNQJ8OL55_VEQ4GV1%Y6](https://user-images.githubusercontent.com/86883267/128377526-8ab41a37-f234-4b1a-94c8-2c7db0d2589c.png)


### 课题研究的结果

控制目标也是我们所希望达到的转速是最上面的，简略来说    
我们通过控制圆柱选择来一步步学习，可以看出在最后我们学习出的流场最总非常接近我们想要的结果！  
![JCBYHP}{9XB% 9(`RGPGV5F](https://user-images.githubusercontent.com/86883267/128374378-c6d6c7c1-b574-4012-b6c1-6a4c3f90892b.png)


