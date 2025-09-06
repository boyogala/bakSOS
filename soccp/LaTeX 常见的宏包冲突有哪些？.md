## **LaTeX 常见的宏包冲突有哪些？**

LaTeX 宏包冲突是写文档时最常见、最令人头疼的问题之一，尤其是当多个宏包试图修改同一部分的底层命令时，就会出现报错、功能失效或排版异常。下面我整理了 **常见的宏包冲突类型及代表例子**，并给出冲突原因与应对思路。[GPT-5 来了，LaTeX 能力大幅提升，看看测评吧！](https://mp.weixin.qq.com/s/NXDPBsGTjYngu0HaxgXD9Q)

------

## **1. \**字体与编码冲突\****

### **典型组合：**

- `inputenc` vs. `fontspec`
- `CJK`/`xeCJK` vs. `ctex`
- `mathspec` vs. `unicode-math`

**原因**：

- `inputenc` 是专为 pdfLaTeX 设计的，用来处理输入文件编码（如 UTF-8），但在 XeLaTeX / LuaLaTeX 中，`fontspec` 已经直接支持 UTF-8，因此两者功能重叠，加载顺序或同时加载会出错。
- `CJK`、`xeCJK`、`ctex` 都会处理中文字体与编码，重复加载会导致字体命令覆盖。
- `mathspec` 和 `unicode-math` 都试图接管数学字体系统，无法共存。

**解决思路**：

- pdfLaTeX → 用 `inputenc` + `fontenc`。
- XeLaTeX / LuaLaTeX → 用 `fontspec` / `xeCJK`，不要再用 `inputenc`。
- 数学字体只选一个方案（`unicode-math` 或 `mathspec`）。

------

## **2. \**图形与超链接冲突\****

### **典型组合：**

- `hyperref` vs. `cleveref` / `autonum` / `caption`
- `hyperref` vs. `bookmark`
- `graphicx` vs. `epsfig` / `psfig`

**原因**：

- `hyperref` 会在文档末尾修改很多引用、标题、目录的内部命令，如果其他宏包也做相同的改动（如 `cleveref`、`caption`），且加载顺序错误，就会报错或链接失效。
- `bookmark` 是 `hyperref` 的书签扩展，如果不注意加载顺序会覆盖对方定义。
- `epsfig`、`psfig` 是非常老的图形接口，与现代 `graphicx` 命令冲突。

**解决思路**：

- 永远 **最后** 加载 `hyperref`（除了可能的 `cleveref`，它要在 `hyperref` 后）。
- 避免使用过时宏包（`epsfig`、`psfig`）。
- 如果一定要自定义标题或目录格式，确保它在 `hyperref` 之前完成。

------

## **3. \**数学公式冲突\****

### **典型组合：**

- `amsmath` vs. `mathtools`（其实 `mathtools` 基于 `amsmath`）
- `amsmath` vs. `breqn`
- `amssymb` vs. `txfonts` / `pxfonts`

**原因**：

- `mathtools` 是 `amsmath` 的超集，所以如果重复加载 `amsmath` 会浪费资源甚至覆盖配置。
- `breqn` 会修改数学公式断行算法，与 `amsmath` 的结构冲突。
- `txfonts` / `pxfonts` 会定义自己的数学符号集，与 `amssymb` 定义的符号重复，导致符号样式不一致。

**解决思路**：

- 用 `mathtools` 代替 `amsmath`（不再单独加载 `amsmath`）。
- 避免 `breqn` 和 `amsmath` 混用（或者只在少量地方用 `breqn` 环境）。
- 数学字体一次选定，不混合不同字体宏包。

------

## **4. \**页眉页脚与版面冲突\****

### **典型组合：**

- `fancyhdr` vs. `titlesec`
- `geometry` vs. `typearea`（KOMA-script）
- `geometry` vs. `fullpage`

**原因**：

- `fancyhdr` 和 `titlesec` 都可能修改章节标题与页眉页脚的高度参数，冲突会导致页眉被覆盖或页码消失。
- `geometry` 用于设置页面尺寸，但 KOMA-script 类文档（如 `scrartcl`）自带 `typearea` 控制版面，两者同时使用会相互覆盖。
- `fullpage` 会强行压缩页边距，和 `geometry` 冲突。

**解决思路**：

- 确定一个版面控制方案，避免重复设置。
- 如果用 `titlesec` 改章节格式，要在 `fancyhdr` 之后再手动调整页眉。

------

## **5. \**表格与浮动环境冲突\****

### **典型组合：**

- `longtable` vs. `array`（某些旧版本）
- `float` vs. `hyperref`
- `subfigure` vs. `subfig` / `subcaption`

**原因**：

- `longtable` 旧版本与 `array` 的列格式宏定义冲突。
- `float` 重写浮动对象放置机制，如果和 `hyperref` 交互不当，会导致链接位置错误。
- `subfigure` 已废弃，与 `subfig` / `subcaption` 定义重叠。

**解决思路**：

- 使用 `array` 的新版本或只用 `booktabs` 等更现代的表格增强宏包。
- 避免 `subfigure`，用 `subcaption`（配合 `caption`）替代。

------

## **6. \**过时宏包与现代宏包冲突\****

### **典型例子：**

- `epsfig`、`psfig` → 现代替代是 `graphicx`
- `subfigure` → 用 `subcaption`
- `picins` → 用 `wrapfig`
- `times` → 用 `mathptmx` 或 `newtxtext/newtxmath`

**原因**：

- 老宏包直接重写底层命令，与现代宏包或新版 LaTeX 内核不兼容。

**解决思路**：

- 检查宏包的最后更新年份，超过 10 年未维护的尽量找替代品。
- 查 CTAN 宏包说明，选择推荐方案。

# **LaTeX 这个报错 Alignment tab changed to \cr 是什么问题？**

这个 **“Alignment tab changed to \cr”** 错误是 LaTeX 在**表格或对齐环境**（`tabular`、`array`、`align` 等）里最常见的一类语法错误提示，它的意思是：

> 你在表格（或对齐环境）里，某一行的 **列分隔符 `&` 的数量和定义的列数不一致**，或者 `&` 出现在了不该出现的地方，LaTeX 被迫把它当成换行 `\cr`（等价于 `\\`）来处理。

------

## **1. 错误成因**

常见触发原因有：

### ***\*(1) 每行的列数不一致\****

```
\begin{tabular}{ccc} % 3 列
A & B & C \\      % ✅ 正确
1 & 2 \\          % ❌ 少了一个单元格
\end{tabular}
```

LaTeX 发现第二行的 `&` 数量不足，就会报 _Alignment tab changed to \cr_。

------

### ***\*(2) 多了或少了 `&`\****

```
\begin{tabular}{ccc}
A & B & C & D \\  % ❌ 多了一个 &
\end{tabular}
```

列定义是 3 个，但行里出现了 3 个 `&`（意味着 4 列），也会出错。

------

### ***\*(3) `&` 出现在数学环境外\****

```
$ a & b $   % ❌ 在数学模式外的 & 会被当作表格分隔符
```

`&` 只有在对齐环境（`tabular`、`align`、`array` 等）里才有特殊意义，其他地方需要转义 `\&`。

------

### ***\*(4) 在 `align` / `array` 等数学对齐环境中列数不匹配\****

```
\begin{align}
x &= y \\
a &= b & c   % ❌ 多出一个 &，LaTeX 以为这是下一行
\end{align}
```

------

## **2. 解决方法**

1. **检查列定义和行里的 `&` 是否匹配**

   - 如果你定义了 `{ccc}`（3 列），每行必须有 **2 个 `&`**（因为 `&` 是列间分隔符）。

   - 比如：

     ```tex
     \begin{tabular}{ccc}
     A & B & C \\   % 2 个 &
     1 & 2 & 3 \\   % 2 个 &
     \end{tabular}
     ```

2. **确保 `&` 只在合法环境使用**

   - 在普通文本中要写 `\&`。

   - 例如：

     ```tex
     Google \& Microsoft
     ```

3. **对齐环境中保持结构一致**

   - 在 `align`、`array` 等数学环境中，每行的对齐列数必须一致。

   - 如果某个单元格想空着，可以直接留空：

     ```tex
     \begin{align}
     x &= y \\
     a &=    & c
     \end{align}
     ```

4. **调试小技巧**

   - 出错时，LaTeX 会告诉你大概是第几行。
   - 你可以用注释 `%` 把表格/对齐的一部分注释掉，然后逐行恢复，找到那一行列数不匹配的地方。

------

如果你愿意，我可以帮你做一份 **“对齐类环境 & 符号检查速查表”**，专门防止这种 Alignment tab 错误，在写 `tabular`、`align`、`array` 时直接对照就能避免。这样以后遇到就能秒修。 你要我帮你做这份表吗？

# **用 tikz 画一个行列式乘法计算的示例**

好的，我帮你用 **TikZ** 画一个行列式乘法的示例图，把两个矩阵相乘的过程可视化，比如一个 矩阵乘以一个 矩阵，显示对应行列相乘求和的箭头连接。

这里是一个可编译的 LaTeX 示例：

```tex
\documentclass[tikz,border=5mm]{standalone}
\usepackage{amsmath}

\begin{document}
\begin{tikzpicture}[scale=1, every node/.style={scale=1}]
    % 左边矩阵 A
    \matrix (A) [matrix of math nodes,left delimiter={[},right delimiter={]},nodes={minimum size=8mm}]
    {
      a_{11} & a_{12} & a_{13} \\
      a_{21} & a_{22} & a_{23} \\
    };

    % 右边矩阵 B
    \matrix (B) [matrix of math nodes,right=4cm of A,left delimiter={[},right delimiter={]},nodes={minimum size=8mm}]
    {
      b_{11} & b_{12} \\
      b_{21} & b_{22} \\
      b_{31} & b_{32} \\
    };

    % 结果矩阵 C
    \matrix (C) [matrix of math nodes,below right=1.2cm and 2cm of A,left delimiter={[},right delimiter={]},nodes={minimum size=8mm}]
    {
      c_{11} & c_{12} \\
      c_{21} & c_{22} \\
    };

    % 文字 × =
    \node at ($(A.east)!0.5!(B.west)$) {\Huge$\times$};
    \node at ($(B.south)!0.5!(C.north)$) {\Huge$=$};

    % 箭头示例：计算 c_{11}
    \draw[->,thick,red] (A-1-1.north east) .. controls +(0.5,0.8) and +(-0.5,0.8) .. (B-1-1.north west);
    \draw[->,thick,red] (A-1-2.north east) .. controls +(0.5,0.4) and +(-0.5,0.4) .. (B-2-1.north west);
    \draw[->,thick,red] (A-1-3.east)       .. controls +(0.5,0.0) and +(-0.5,0.0) .. (B-3-1.west);
    \draw[->,thick,red] (B-1-1.south)      .. controls +(0,-1.0) and +(-1.0,0.5) .. (C-1-1.west);

    % 箭头示例：计算 c_{12}
    \draw[->,thick,blue] (A-1-1.south east) .. controls +(0.5,-0.2) and +(-0.5,0.8) .. (B-1-2.north west);
    \draw[->,thick,blue] (A-1-2.south east) .. controls +(0.5,-0.6) and +(-0.5,0.4) .. (B-2-2.north west);
    \draw[->,thick,blue] (A-1-3.south east) .. controls +(0.5,-1.0) and +(-0.5,0.0) .. (B-3-2.west);
    \draw[->,thick,blue] (B-1-2.south)      .. controls +(0,-1.0) and +(-1.0,0.5) .. (C-1-2.east);

    % 标注说明
    \node[red,below=0.1cm of C-1-1] {\scriptsize 行1$\cdot$ 列1};
    \node[blue,below=0.1cm of C-1-2] {\scriptsize 行1$\cdot$ 列2};

\end{tikzpicture}
\end{document}
```

------

### **图的特点**

- 左边矩阵 ：**2×3**
- 右边矩阵 ：**3×2**
- 结果矩阵 ：**2×2**
- 用 **红色箭头** 表示计算 （第一行·第一列）
- 用 **蓝色箭头** 表示计算 （第一行·第二列）
- 也可以继续加箭头画出 、 的计算过程

------

如果你愿意，我可以帮你做一个 **行列式（determinant）计算过程的 TikZ 动画**，用箭头一步步展示乘法加法的流程，这样在讲课或论文里更直观。 你想让我把这个例子扩展成动画版本吗？

# **我想要 LaTeX 下的直立 pi 和 积分号 如何实现？**

在 LaTeX 里， 和积分号 默认是**斜体（数学符号字体）**， 如果你想让它们变成 **直立体**（upright），可以用不同的方式，取决于你用的编译方式和字体需求。

------

## ***\*1. 直立\**** 

### **（1）常用方法：`\upPi` / `\uppi`（来自 `upgreek` 宏包）**

```tex
\usepackage{upgreek} % 导入直立希腊字母tex
```

然后在数学模式中：

```tex
\uppi   % 直立小写 π
\upPi   % 直立大写 Π
```

示例：

```tex
\[
  C = 2\uppi r
\]
```

------

### **（2）使用 `newtxmath` 或 `unicode-math`**

- 如果用 **`unicode-math`**（XeLaTeX/LuaLaTeX），可以直接：

```tex
\setmathfont{XITS Math}
\symup{\pi}  % symup 是 upright 的意思tex
```

- 如果用 **`newtxmath`** 或其他数学字体宏包，也可能内置 `\uppi`。

------

## ***\*2. 直立积分号\****

LaTeX 默认的积分号是 _斜的_，如果你想让它直立，有几种方法。

### **（1）`txfonts` / `newtxmath`**

```tex
\usepackage{newtxmath} % 或 \usepackage{txfonts}
```

这类字体的积分号是直立的。

------

### **（2）`esint` 宏包**

`esint` 提供各种形状的积分符号，包括直立：

```tex
\usepackage{esint}
```

然后：

```tex
\[
  \int\limits_a^b f(x)\,dx
\]
```

积分号会变得更直（而且多了一些可选符号，比如 `\oiint` 双重积分等）。

------

### **（3）`unicode-math`（XeLaTeX/LuaLaTeX）**

```tex
\setmathfont{XITS Math}
\symup{\int}
```

这里 `\symup{\int}` 会调用直立的积分符号。

------

## ***\*3. 常用组合方案（推荐）\****

如果你只是想**同时**得到直立的 和直立的积分号，可以这样：

```tex
\usepackage{upgreek}   % 直立希腊字母
\usepackage{newtxmath} % 直立积分符号
```

然后：

```
\[
  \int_0^{\uppi} \sin x \, dx
\]
```

这样效果就是直立 π + 直立积分号。

------

如果你愿意，我可以帮你做一个**对照表**，列出 LaTeX 里所有希腊字母和积分号在直立/斜体下的效果，这样在写公式时可以直接查表使用。 你要我帮你做这个表吗？

# **我想用 LaTeX 输入一个带有合并行，合并列的跨页表格样例**

好的，我给你一个 **可编译的 LaTeX 跨页大表格示例**，同时包含 **合并行（rowspan）** 和 **合并列（colspan）**，适合展示你要的效果。 跨页表格我们一般用 `longtable` 宏包，合并单元格用 `multirow`（行合并）和 `\multicolumn`（列合并）。

------

## ***\*代码示例\****

```tex
\documentclass[a4paper,12pt]{article}
\usepackage{longtable} % 支持跨页表格
\usepackage{multirow}  % 合并行
\usepackage{array}     % 更灵活的列格式
\usepackage{booktabs}  % 好看的表格线
\usepackage{lipsum}    % 生成测试文字

\begin{document}

\begin{longtable}{|c|c|c|p{7cm}|}
\caption{跨页表格示例：同时包含合并行和合并列} \\
\hline
\textbf{序号} & \textbf{类别} & \textbf{编号} & \textbf{描述} \\
\hline
\endfirsthead

\multicolumn{4}{c}%
{{\bfseries 表 \thetable\ （续）}} \\
\hline
\textbf{序号} & \textbf{类别} & \textbf{编号} & \textbf{描述} \\
\hline
\endhead

\hline
\multicolumn{4}{r}{{接下页}} \\
\endfoot

\hline
\endlastfoot

% ==== 表格内容 ====
\multirow{4}{*}{1} & \multirow{2}{*}{A类} & A-001 & \lipsum[1][1-5] \\
                   &                     & A-002 & \lipsum[1][6-10] \\
                   & \multirow{2}{*}{B类} & B-001 & \lipsum[2][1-5] \\
                   &                     & B-002 & \lipsum[2][6-10] \\
\hline
\multirow{3}{*}{2} & \multirow{3}{*}{\multicolumn{2}{c|}{合并列示例}} & \lipsum[3][1-5] \\
                   &                                                & \lipsum[3][6-10] \\
                   &                                                & \lipsum[4][1-5] \\
\hline
\multirow{5}{*}{3} & \multirow{3}{*}{C类} & C-001 & \lipsum[4][6-10] \\
                   &                     & C-002 & \lipsum[5][1-5] \\
                   &                     & C-003 & \lipsum[5][6-10] \\
                   & \multirow{2}{*}{D类} & D-001 & \lipsum[6][1-5] \\
                   &                     & D-002 & \lipsum[6][6-10] \\
\end{longtable}

\end{document}
```

------

## ***\*说明\****

1. **跨页**
   - `longtable` 自动处理分页，不需要 `table` 环境。
   - `\endfirsthead`、`\endhead`、`\endfoot`、`\endlastfoot` 用来定义表格跨页时的页眉页脚。
2. **合并行**
   - `\multirow{n}{*}{内容}` 让单元格跨 `n` 行。`*` 表示宽度自动。
3. **合并列**
   - `\multicolumn{列数}{对齐格式}{内容}`，比如 `\multicolumn{2}{c|}{合并列}`。
4. **跨页 + 合并**
   - `multirow` 和 `multicolumn` 可以嵌套使用，但要注意对齐格式（`c|`, `l|` 等）要和 `longtable` 列格式对应。

------

如果你愿意，我可以帮你改成 **三线表（booktabs 风格）+ 彩色背景 + 跨页合并单元格** 的版本，这样更适合正式论文和报告。 你要我帮你做这个增强版吗？

# **请给 LaTeX book 基础类的目录格式中，章名字 chapter 补上。如何实现**

我明白你的意思了——LaTeX 的 **`book`** 基础类默认目录 (`\tableofcontents`) 只显示 *章号* 和 _章标题_， 但没有在目录里额外加上类似 `Chapter 1` 这样的字样。

要在目录中补上 "Chapter"（或中文“第 X 章”），有两种主流实现方式：

------

## ***\*方法 1：修改章节标题的 TOC 格式（推荐，简单稳定）\****

使用 `tocloft` 宏包，可以直接在目录中对 chapter 项加前缀：

```tex
\documentclass{book}
\usepackage{tocloft}

% 修改目录中 chapter 的前缀
\renewcommand{\cftchappresnum}{Chapter~}
\renewcommand{\cftchapaftersnum}{:} % 章号后的符号，可改成空格或其他
\setlength{\cftchapnumwidth}{7em}   % 调整数字区域宽度以适配前缀

\begin{document}
\tableofcontents

\chapter{Introduction}
\chapter{Literature Review}
\chapter{Methodology}

\end{document}
```

效果：

```tex
Chapter 1: Introduction
Chapter 2: Literature Review
Chapter 3: Methodology
```

------

## ***\*方法 2：改 `\numberline` 定义（更底层）\****

如果不想用额外宏包，可以直接改 `\numberline` 在目录里的显示：

```tex
\documentclass{book}

\makeatletter
\renewcommand{\numberline}[1]{Chapter~#1\hspace{1em}}
\makeatother

\begin{document}
\tableofcontents

\chapter{Introduction}
\chapter{Literature Review}
\chapter{Methodology}

\end{document}
```

这种方法会直接影响所有目录编号的格式，但可控性没 `tocloft` 高。

------

## ***\*方法 3：中文“第 X 章”版本\****

如果你写中文书，可以这样：

```tex
\documentclass{book}
\usepackage{tocloft}

% 中文前缀
\renewcommand{\cftchappresnum}{第}
\renewcommand{\cftchapaftersnum}{章}
\setlength{\cftchapnumwidth}{4em}

\begin{document}
\tableofcontents

\chapter{绪论}
\chapter{相关研究}
\chapter{研究方法}

\end{document}
```

效果：

```
第1章 绪论
第2章 相关研究
第3章 研究方法
```