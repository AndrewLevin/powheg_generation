sign=$1
parallelstage=$2
xgriditeration=$3

if [ -z "$1" ]
then
    echo "the sign must be set"
fi

if [ "$sign" != "+" ] && [ "$sign" != "-" ]
then
    echo "sign must be + or -, exiting"
    exit
fi

if [ "$sign" == "+" ]
then
    sign_label=wp_wp
else
    sign_label=wm_wm
fi

if [ -z "$2" ]
then
    echo "the parellel stage needs to be set, exiting"
    exit
else
    if (( $parallelstage == 1 ))
    then
	if [ -z "$3" ]
	    then
	    echo "the xgriditeration needs to be set for parallelstage 1, exiting"
	    exit
	fi
	wget https://raw.githubusercontent.com/AndrewLevin/genproductions/for_wp_wp_powheg_production/bin/Powheg/production/vbf_wp_wp/powheg.input.${sign_label}.parallelstage${parallelstage}.xgriditeration${xgriditeration} -O ${sign_label}/CMSSW_7_1_14/src/POWHEG-BOX/vbf_wp_wp/testrun/powheg.input
	stderr_stdout_filename_base=stderr_stdout_${sign_label}_parallelstage${parallelstage}_xgriditeration${xgriditeration}
	log_filename_base=log_${sign_label}_parallelstage${parallelstage}_xgriditeration${xgriditeration}
    else
	if ! [ -z "$3" ]
	then
	    echo "the xgriditeration should not be set for parallelstage greater than 1, exiting"
	fi
	wget https://raw.githubusercontent.com/AndrewLevin/genproductions/for_wp_wp_powheg_production/bin/Powheg/production/vbf_wp_wp/powheg.input.${sign_label}.parallelstage${parallelstage} -O ${sign_label}/CMSSW_7_1_14/src/POWHEG-BOX/vbf_wp_wp/testrun/powheg.input
	stderr_stdout_filename_base=stderr_stdout_${sign_label}_parallelstage${parallelstage}
	log_filename_base=log_${sign_label}_parallelstage${parallelstage}
    fi
fi


n_jobs=100

i=1


while((i<=n_jobs)); do
	cat > submit.cmd <<EOF
universe = vanilla
Executable = `pwd`/run_pwhg_main.sh
Arguments = "$i `pwd`/${sign_label}/CMSSW_7_1_14/src/POWHEG-BOX/vbf_wp_wp/testrun/"
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

