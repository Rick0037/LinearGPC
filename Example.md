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
1.初始化种群  
2.对种群进行评价和排名  
3.在种群中采用交叉、复制、变异等操作生成下一代  
4.判断是否达到最优解或指定代数  
5.结束或进行下一代返回步骤2    


### MLC代码思想和具体实现

![image](https://user-images.githubusercontent.com/86883267/128364108-f0e88dd9-e3db-471f-83d8-13404dcc6b6f.png)



```
Initialization;
```

这样就加载好了一个*mlc*项目的运行环境，
本项目中包含了一个平均场问题的示例文件（GMFM），
读者可以针对不同的问题创建自己的项目环境，并用以下语句实现加载。

```
mlc=MLC('GMFM');
```

运行*go.m* 文件来实现优化过程，单单只运行一次是能进行一代的优化。
如果运行前是还并没有生成个体种群，会随机初始化第一代种群，
之后的每一代通过评价表现进行交叉、复制、变异的操作，进化生成新的下一代的种群个体，
直到完成指定代数的进化收敛为止。

```
mlc.go;
```

如果一次性进化多代可以使用以下的命令。

```
mlc.go(10); %一次性进化10代
```

## 进化结果及分析

如果想查看最佳个体的表现可以使用：

```
mlc.best_individual;
```

如果是要查看整个进化过程的学习曲线可以使用: 

```
mlc.convergence;
```


如果想保存图片的话可以直接使用如下命令结果将会被保存在save_runs/NameOfMyRun/Figures/路径中 :
```
mlc.print('NameOfMyFigure');
mlc.print('NameOfMyFigure',1); % 对已经存在图片重新保存
```
### 简单参数的更改

```
mlc.parameters.name = 'NameOfMyRun'; % 保存名称;
mlc.parameters.Elitism = 1;
mlc.parameters.CrossoverProb = 0.3;
mlc.parameters.MutationProb = 0.4;
mlc.parameters.ReplicationProb = 0.7;
mlc.parameters.PopulationSize = 50; % 种群的大小

```

### 保存与加载

我们可以对现有的MLC项目进行保存.
/!\请注意在MATLAB中对于文件的加载会导致现有MLC面板的丢失，请保存现有面板之后再进行加载!

```
mlc.save_matlab;
mlc.load_matlab('NameOfMyRun');
```

### 目录结构
主要包括以下目录及结构:
- *README.md*
- *README-en.md*
- *Initialization.m*, *Restart.m*, 初始化和重新启动项目.
- *@MLC/*, *@MLCind/*, *@MLCpop/*, *@MLCtable/* 包括了主要的对于使用MLC所封装的类.
- *MLC_tools/* 包括了连接其他MLC项目一些脚本工具的文件.
- *ODE_Solvers/* 包含了一些求解微分方程的求解器.
- *Plant/* 包括了问题和相关的参数，一个问题一个参数。默认可更改的配置文件在*MLC_tools/*目录中.
- *Compatibility/* 一些脚本文件来检测MLC是否可以在MATLAB和Octave运行.
- *save_runs/* 项目储存位置.
