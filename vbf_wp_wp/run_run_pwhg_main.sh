parallelstage=$1
xgriditeration=$2

if [ -z "$1" ]
then
    echo "the parellel stage needs to be set, exiting"
    exit
else
    if (( $parallelstage == 1 ))
    then
	if [ -z "$2" ]
	    then
	    echo "the xgriditeration needs to be set for parallelstage 1, exiting"
	    exit
	fi
	wget https://raw.githubusercontent.com/AndrewLevin/genproductions/wpwp_powheg/bin/Powheg/production/wp_wp_j_j_ewk/powheg.input.wp_wp.parallelstage${parallelstage}.xgriditeration${xgriditeration} -O CMSSW_7_1_14/src/POWHEG-BOX/vbf_wp_wp/testrun/powheg.input
	stderr_stdout_filename_base=stderr_stdout_parallelstage${parallelstage}_xgriditeration${xgriditeration}
	log_filename_base=log_parallelstage${parallelstage}_xgriditeration${xgriditeration}
    else
	if ! [ -z "$2" ]
	then
	    echo "the xgriditeration should not be set for parallelstage greater than 1, exiting"
	fi
	wget https://raw.githubusercontent.com/AndrewLevin/genproductions/wpwp_powheg/bin/Powheg/production/wp_wp_j_j_ewk/powheg.input.wp_wp.parallelstage${parallelstage} -O CMSSW_7_1_14/src/POWHEG-BOX/vbf_wp_wp/testrun/powheg.input
	stderr_stdout_filename_base=stderr_stdout_parallelstage${parallelstage}
	log_filename_base=log_parallelstage${parallelstage}
    fi
fi


n_jobs=50

i=1


while((i<=n_jobs)); do
	cat > submit.cmd <<EOF
universe = vanilla
Executable = /scratch5/anlevin/powheg_generation/vbf_wp_wp/run_pwhg_main.sh
Arguments = "$i"
GetEnv = True
Requirements = (Arch == "X86_64") && (OpSys == "LINUX") && (HasFileTransfer) && (OpSysAndVer == "SL6")
Should_Transfer_Files = YES
WhenToTransferOutput = ON_EXIT 
Output = ${stderr_stdout_filename_base}_${i}.dat
Error = ${stderr_stdout_filename_base}_${i}.dat
Log = ${log_filename_base}_${i}.dat
+AccountingGroup = "group_cmsuser.$USER"
Queue 1
EOF
i=$(($i+1))
condor_submit submit.cmd
rm submit.cmd
    done
