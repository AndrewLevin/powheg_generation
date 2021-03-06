mkdir wm_wm-2017
cd wm_wm-2017
export SCRAM_ARCH=slc6_amd64_gcc630
scram p CMSSW CMSSW_9_3_0
cd CMSSW_9_3_0/src
eval `scramv1 runtime -sh`
git clone https://github.com/cms-sw/genproductions.git genproductions
cd genproductions/bin/Powheg
#python ./run_pwg_condor.py -p 0 -i /afs/cern.ch/work/a/amlevin/powheg_generation/vbf_wp_wp/wm_wm-2017/CMSSW_9_3_0/src/genproductions/bin/Powheg/production/2017/13TeV/vbf_wp_wp/powheg.input.wm_wm.parallelstage1 -m vbf_wp_wp -f wm_wm-2017 -d 1
#python ./run_pwg_condor.py -p 1 -x 1 -i /afs/cern.ch/work/a/amlevin/powheg_generation/vbf_wp_wp/wm_wm-2017/CMSSW_9_3_0/src/genproductions/bin/Powheg/production/2017/13TeV/vbf_wp_wp/powheg.input.wm_wm.parallelstage1 -m vbf_wp_wp -f wm_wm-2017 -d 1 -q microcentury -j 100
#python ./run_pwg_condor.py -p 1 -x 2 -i /afs/cern.ch/work/a/amlevin/powheg_generation/vbf_wp_wp/wm_wm-2017/CMSSW_9_3_0/src/genproductions/bin/Powheg/production/2017/13TeV/vbf_wp_wp/powheg.input.wm_wm.parallelstage1 -m vbf_wp_wp -f wm_wm-2017 -d 1 -q microcentury -j 100
#python ./run_pwg_condor.py -p 1 -x 3 -i /afs/cern.ch/work/a/amlevin/powheg_generation/vbf_wp_wp/wm_wm-2017/CMSSW_9_3_0/src/genproductions/bin/Powheg/production/2017/13TeV/vbf_wp_wp/powheg.input.wm_wm.parallelstage1 -m vbf_wp_wp -f wm_wm-2017 -d 1 -q microcentury -j 100
#python ./run_pwg_condor.py -p 2 -i /afs/cern.ch/work/a/amlevin/powheg_generation/vbf_wp_wp/wm_wm-2017/CMSSW_9_3_0/src/genproductions/bin/Powheg/production/2017/13TeV/vbf_wp_wp/powheg.input.wm_wm.parallelstage2 -m vbf_wp_wp -f wm_wm-2017 -d 1 -q tomorrow -j 100
#python ./run_pwg_condor.py -p 3 -i /afs/cern.ch/work/a/amlevin/powheg_generation/vbf_wp_wp/wm_wm-2017/CMSSW_9_3_0/src/genproductions/bin/Powheg/production/2017/13TeV/vbf_wp_wp/powheg.input.wm_wm.parallelstage3 -m vbf_wp_wp -f wm_wm-2017 -d 1 -q tomorrow -j 100
#python ./run_pwg_condor.py -p 9 -i /afs/cern.ch/work/a/amlevin/powheg_generation/vbf_wp_wp/wm_wm-2017/CMSSW_9_3_0/src/genproductions/bin/Powheg/production/2017/13TeV/vbf_wp_wp/powheg.input.wm_wm.parallelstage3 -m vbf_wp_wp -f wm_wm-2017 -d 1 -k 1
