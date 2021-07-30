# 机器学习控制（MLC）
灵感启发自达尔文优胜劣汰的进化算法，采用线性遗传编程技术（LGP）解决无控制模型的控制优化问题。


### 版本可行性
针对于Octave，和Matlab设计了两个版本，可以支持在不同的系统中运行Linux/Windows，如果需要在Linux下运行，可能会添加一些shell脚本。
如果在Windows运行请添加文件到指定的工作区。不同运行器下的完整文件可见 *Compatibility/* 文件夹。


### 初始化并运行
初始化：在主文件目录下运行 Initialization.m 来添加可执行文件的路径和加载不同层次的类对象。

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
之后的每一代通过
To start the optimization process of the toy problem, run the *go.m* method.
Run alone it process one generation of optimization.
For the first iteration, it will initialize the data base with new individiduals.
Then it will create the new generations by evolving the last population thanks to genetic operators.

```
mlc.go;
```

To run several generations, precise it.

```
mlc.go(10); %To run 10 generations.
```

## Post processing and analysis.

To visualize the best individual, use :

```
mlc.best_individual;
```

To visualize the learning process, use : 

```
mlc.convergence;
```



The current figure can be directly saved in save_runs/NameOfMyRun/Figures/ thanks to the following command:
```
mlc.print('NameOfMyFigure');
mlc.print('NameOfMyFigure',1); % to overwrite an existing figure
```
### Useful parameters

```
mlc.parameters.name = 'NameOfMyRun'; % This is the used to save;
mlc.parameters.Elitism = 1;
mlc.parameters.CrossoverProb = 0.3;
mlc.parameters.MutationProb = 0.4;
mlc.parameters.ReplicationProb = 0.7;
mlc.parameters.PopulationSize = 50; % Size of the population

```

### Save/Load

One can save and load one run.
/!\ When loading, the current mlc object will be overwritten, be careful!

```
mlc.save_matlab;
mlc.load_matlab('NameOfMyRun');
```

### Content
The main folder should contain the following folders and files:
- *README.md*
- *Initialization.m*, *Restart.m*, to initialize and restart the toy problem.
- *@MLC/*, *@MLCind/*, *@MLCpop/*, *@MLCtable/* contains the object definition files for the MLC algorithm.
- *MLC_tools/* contains functions and scripts that are not methods used by the MLC class objects.
- *ODE_Solvers/* contains other functions such ODE solvers
- *Plant/* contains all the problems and associated parameters. One folder for each problem. Default parameters are in *MLC_tools/*.
- *Compatibility/* contains functions and scripts for MATLAB/Octave compatibility.
- *Control_laws/* contains functions and scripts to be used for experiments.
- *save_runs/* contains the savings.
