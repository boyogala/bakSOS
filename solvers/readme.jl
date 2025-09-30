### 必要的安装软件包

## 优化建模语言
using JuMP,AmplNLWriter
## 数据处理包
using CSV,DataFrames

## 优化求解器
# 非线性优化求解器
using Ipopt
# （混合整数）线性规划求解器
using HiGHS

##################################
###Setting for Ipopt###START
# 创建带有 Ipopt 的优化模型
DBS = Model(Ipopt.Optimizer)

## 更多 Ipopt 的设置: https://coin-or.github.io/Ipopt/OPTIONS.html
# 注意：如果不设置额外的 linear_solver, 默认是 MUMPS

# 最大迭代次数
set_attribute(DBS, "max_iter", 10000)

# 确定要使用的障碍参数更新策略
set_attribute(DBS, "mu_strategy", "adaptive")

##############https://www.hsl.rl.ac.uk##############################
# 设置 linear_solver 为 ma86 ma57 ma97 ma27 ma77
########Problem size, Parallel
# ma57: Small/Medium,Threaded BLAS -> Sparse symmetric system: multifrontal method
# ma77: Huge,Limited -> Sparse symmetric system: multifrontal out of core
# ma86: Large,Highly -> Sparse solver for real and complex indefinite matrices using OpenMP
# ma97: Small/Medium/Large,Yes -> Bit-compatible parallel sparse symmetric/Hermitian solver using OpenMP

# 设置 动态链接库 libhsl.dll
set_attribute(DBS, "hsllib", "YOUR_PATH\\coin-hsl\\bin\\libhsl.dll")
# 设置 linear_solver 为 ma86 > ma57 > ma97 > ma27 > ma77 
set_attribute(DBS, "linear_solver", "ma57")

##############https://panua.ch/pardiso##############################
### 需申请一个月试用或者是学术购买
# 设置 动态链接库 libpardiso.dll
set_attribute(DBS, "pardisolib", "YOUR_PATH\\lib\\libpardiso.dll")
# 设置 linear_solver 为 pardiso
set_attribute(DBS, "linear_solver", "pardiso")
# 设置 显示 Pardiso 的求解过程
set_attribute(DBS, "pardiso_msglvl", 1)
###Setting for Ipopt### END
#################################
#################################
###Setting for HiGHS###START
# 创建带有 HiGHS 的优化模型
DBS = Model(HiGHS.Optimizer)

# 设置开启 预处理
set_attribute(DBS, "presolve", "on")
# 设置开启 并行
set_attribute(DBS, "parallel", "on")

###Setting for HiGHS### END





