seed=$1
dir=$2

cd $dir

eval `scramv1 runtime -sh`

### Prepare environments for FastJet ### 

export FASTJET_BASE=`scram tool info fastjet | grep FASTJET_BASE | sed -e s%FASTJET_BASE=%%`
export PATH=$FASTJET_BASE/bin/:$PATH 
### Prepare environments for LHAPDF ### 

export LHAPDF_BASE=`scram tool info lhapdf | grep LHAPDF_BASE | sed -e s%LHAPDF_BASE=%%`    
export PATH=$LHAPDF_BASE/bin/:$PATH 
export LHAPATH=`scram tool info lhapdf | grep LHAPATH | sed -e s%LHAPATH=%%`
export LHAPDF6TOOLFILE=$CMSSW_BASE/config/toolbox/$SCRAM_ARCH/tools/available/lhapdf6.xml 

if [ -e $LHAPDF6TOOLFILE ]; then 
    export LHAPDF6_BASE=`grep LHAPDF6_BASE $CMSSW_BASE/config/toolbox/$SCRAM_ARCH/tools/available/lhapdf6.xml | head -1 | cut -d \" -f 4 `
    export LHAPDF_DATA_PATH=`$LHAPDF6_BASE/bin/lhapdf-config --datadir` 
fi 

echo $seed | ../pwhg_main
