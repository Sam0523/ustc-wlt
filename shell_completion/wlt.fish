#
# Fish completion for ustc-wlt
#

function __fish_wlt_no_subcommand
	for i in (commandline -cpo)
		if contains -- $i info status list set log login dump
			return 1
		end
	end
	return 0
end

function __fish_wlt_set
	for i in (commandline -cpo)
		if contains -- $i set
			return 0
		end
	end
	return 1
end

complete -f -c wlt -n '__fish_wlt_no_subcommand' -a info   -d "Show profile information"
complete -f -c wlt -n '__fish_wlt_no_subcommand' -a status -d "Show current ISP status"
complete -f -c wlt -n '__fish_wlt_no_subcommand' -a list   -d "Show the list of available ISPs"
complete -f -c wlt -n '__fish_wlt_no_subcommand' -a set    -d "Set ISP"
complete -f -c wlt -n '__fish_wlt_no_subcommand' -a log    -d "Show recent log"
complete -f -c wlt -n '__fish_wlt_no_subcommand' -a login  -d "Browse interactively"
complete -f -c wlt -n '__fish_wlt_no_subcommand' -a dump   -d "Dump the whole page"

complete -f -c wlt -n '__fish_wlt_set' -a 1 -d '教育网出口(国际,仅用教育网访问,适合看文献)'
complete -f -c wlt -n '__fish_wlt_set' -a 2 -d '电信网出口(国际,到教育网走教育网)'
complete -f -c wlt -n '__fish_wlt_set' -a 3 -d '联通网出口(国际,到教育网走教育网)'
complete -f -c wlt -n '__fish_wlt_set' -a 4 -d '电信网出口2(国际,到教育网免费地址走教育网)'
complete -f -c wlt -n '__fish_wlt_set' -a 5 -d '联通网出口2(国际,到教育网免费地址走教育网)'
complete -f -c wlt -n '__fish_wlt_set' -a 6 -d '电信网出口3(国际,默认电信,其他分流)'
complete -f -c wlt -n '__fish_wlt_set' -a 7 -d '联通网出口3(国际,默认联通,其他分流)'
complete -f -c wlt -n '__fish_wlt_set' -a 8 -d '教育网出口2(国际,默认教育网,其他分流)'
complete -f -c wlt -n '__fish_wlt_set' -a 9 -d '移动网出口(国际,无P2P或带宽限制)'
