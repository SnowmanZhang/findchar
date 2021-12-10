{smcl}
{* 10Dec2021}{...}
{hi:help findstar}
{hline}

{title:Title}

{phang}
{bf:findstar} {hline 2} 
本指令用于在实证中遍历所有给定变量的排列组合，以期寻找显著性最佳的回归方程。

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:findstar}{cmd:,} cmd(string) xlist(string) ylist(string) [{it:options}]

{marker description}{...}
{title:Description}

{pstd}
你是否发愁实证时该选取哪种X和Y的组合才能回归显著？你是否好奇一个新指标和哪些既有指标可以做出结果？不要掩饰了，你需要这个命令！
{p_end}

{pstd}
{cmd:findstar}允许你指定任意多的X变量与Y变量，指令将对其进行排列组合，并报告有结果的回归组合。{p_end}
{pstd}需要提醒的是，由于这个指令是作者自娱自乐的产物（它甚至没有报错信息！），因而未做任何稳健性设计，请用户仔细阅读以下配置项，并严格按照示例操作。{p_end}

{marker options}{...}
{title:options for findstar}

{dlgtab:required options}

{phang}
{opt xlist(string)} 用于接收所有的自变量指标。你需要把各个变量写在一个字符串中，变量之间使用一个空格隔开。
{p_end}

{phang}
{opt ylist(string)} 用于接收所有的因变量指标。你需要把各个变量写在一个字符串中，变量之间使用一个空格隔开。
{p_end}

{phang}
{opt cmd(string)} 是你想要进行回归的原始命令，请注意在回归中，原本填写因变量和自变量的位置请使用ylist和xlist字样替代。
{p_end}

{dlgtab:other options}

{phang}
{opt othercmd}: 也许你希望对不同形式的固定效应进行遍历，此时你需要在本选项内填写多个回归命令，指令将对你填写的若干个回归命令进行遍历。
需要注意的是，在{opt othercmd}中填写的命令同样要替换ylist和xlist。另外，当你需要填写多个回归命令时，回归命令之间使用{opt &}符号连接。
{p_end}

{phang}
{opt dtalist}: 也许你希望对含有不同样本的数据集进行遍历，此时你需要在本选项内填写多个数据集的名称，指令将对你填写的若干个数据集进行遍历。
请注意，启用本选项后，指令将不对Stata内存中现有的数据集进行回归，请严格按照以下示例的方法填写本选项。
{p_end}

{phang}
{opt findbest}: 如果你在指令中填写了该项，那么指令最后将会输出在本次遍历中，表现最好（即自变量的T值绝对值最高）的参数组合。
请注意，即使所有的回归都不显著，{opt findbest}也会报告成效最好的参数组合。
{p_end}

{phang}
{opt justresult}: 如果你在指令中填写了该项，那么指令将只报告存在积极结果的参数组合本身，而不会报告这个参数组合的回归结果。
{p_end}




{marker example}{...}
{title:Example}

{pstd}
基本用例

{phang}
{stata `"sysuse auto,clear"'}
{p_end}
{phang}
{stata `"findstar,cmd("reg ylist xlist turn displacement") ylist("price length") xlist("mpg weight")"'}
{p_end}

{pstd}
报告最佳参数组合

{phang}
{stata `"sysuse auto,clear"'}
{p_end}
{phang}
{stata `"findstar,cmd("reg ylist xlist turn displacement") ylist("price length") xlist("mpg weight") findbest"'}
{p_end}


{pstd}
只报告参数结果

{phang}
{stata `"sysuse auto,clear"'}
{p_end}
{phang}
{stata `"findstar,cmd("reg ylist xlist turn displacement") ylist("price length") xlist("mpg weight") justresult"'}
{p_end}


{pstd}
多个stata命令的遍历

{phang}
{stata `"sysuse auto,clear"'}
{p_end}
{phang}
{stata `"findstar,cmd("reg ylist xlist turn displacement") ylist("price length") xlist("mpg weight") othercmd("reg ylist xlist displacement & reg ylist xlist turn")"'}
{p_end}

{pstd}
多个数据集的遍历(数据集较少时)

{phang}
{stata `"sysuse auto,clear"'}
{p_end}
{phang}
{stata `"save "./findstar-1.dta",replace"'}
{p_end}
{phang}
{stata `"drop in 1/10"'}
{p_end}
{phang}
{stata `"save "./findstar-2.dta",replace"'}
{p_end}

{phang}
{stata `"fs findstar-*"'}
{p_end}
{phang}
{stata `"findstar,cmd("reg ylist xlist turn displacement") ylist("price length") xlist("mpg weight") dtalist("findstar-1.dta findstar-2.dta")"'}
{p_end}

{pstd}
多个数据集的遍历(数据集较多时)

{phang}
{stata `"sysuse auto,clear"'}
{p_end}
{phang}
{stata `"save "./findstar-1.dta",replace"'}
{p_end}
{phang}
{stata `"drop in 1/10"'}
{p_end}
{phang}
{stata `"save "./findstar-2.dta",replace"'}
{p_end}

{phang}
{stata `"fs findstar-*"'}
{p_end}
{phang}
{stata `"findstar,cmd("reg ylist xlist turn displacement") ylist("price length") xlist("mpg weight") dtalist(`r(files)')"'}
{p_end}


{title:Author}

{pstd}Snowman Zhang{p_end}
{pstd}Wuhan, China{p_end}
{pstd}snowmanzhang@whu.edu.cn{p_end}



{title:Thanks}

{pstd}感谢郭慧宇同学为本指令提出了真诚而富有价值的建议{p_end}

{pstd}如果正在使用命令的您也同样有一些建议，我殷切期盼您的建议{p_end}