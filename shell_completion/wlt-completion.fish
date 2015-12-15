#
# Fish completion for ustc-wlt
#

complete --command wlt --arguments info   --description "Show profile infomation"
complete --command wlt --arguments status --description "Show current ISP status"
complete --command wlt --arguments list   --description "Show the list of available ISPs"
complete --command wlt --arguments set    --description "Set ISP"
complete --command wlt --arguments log    --description "Show recent log"
complete --command wlt --arguments dump   --description "Dump the whole page"
complete --command wlt --no-files
