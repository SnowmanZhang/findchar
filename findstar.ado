* Authors:
* Xueren Zhang, snowmanzhang@whu.edu.cn
* December 10th, 2021
* 
* Please do not use this code for commerical purpose


program define findstar
	version 15
	syntax,cmd(string) xlist(string) ylist(string) [othercmd(string) findbest justresult dtalist(string)]
	
	if "`dtalist'" == ""{
		local dtalist "me"
	}
	
	local cmd `=ustrregexra("`cmd'"," ","-")'
	if "`othercmd'" == ""{
		local allcmd `cmd'
	}
	else{
		local othercmd `=ustrregexra("`othercmd'"," ","-")'
		local othercmd `=ustrregexra("`othercmd'","&"," ")'
		local allcmd `cmd' `othercmd'
	}

	sca bestbeta = 0
	foreach dtaname of local dtalist{
		if "`dtaname'" != "me"{
			use `dtaname',clear
		}
		foreach cmd of local allcmd{
			local cmd `=ustrregexra("`cmd'","-"," ")'
			foreach y of local ylist{
				foreach x of local xlist{
					local execmd `=ustrregexrf("`cmd'","xlist","`x'")'
					local execmd `=ustrregexrf("`execmd'","ylist","`y'")'
					qui `execmd'
					mat SE=e(V)
					sca se_x = sqrt(SE[1,1])
					sca t = abs(`=_b[`x']'/se_x)
					if t > bestbeta{
						sca bestbeta = t
						local bestinfo "组合 `y'  `x' 命令 `execmd' 数据集为`dtaname'"
					}
					if t > 2.76{
						local status "结果喜人"
					}
					else if t > 1.96{
						local status "结果不错"
					}
					else if t > 1.65{
						local status "结果还行"
					}
					disp "组合 `y' `x' 命令 `execmd' `status' 数据集为 `dtaname'"
					if "`justresult'" == ""{
						`execmd'
					}
				}
			}
		}
	}
	if "`findbest'" != ""{
		disp "最佳回归组合是  `bestinfo'"
	}

end
