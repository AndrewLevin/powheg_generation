export SCRAM_ARCH=slc6_amd64_gcc481
scram p CMSSW CMSSW_7_1_14
cd CMSSW_7_1_14/src
eval `scramv1 runtime -sh`
git clone git@github.com:AndrewLevin/genproductions.git genproductions
cd genproductions
git checkout fix_run_pwg
cd ../
mv genproductions/bin/Powheg/*.sh .
mv genproductions/bin/Powheg/patches .
wget https://raw.githubusercontent.com/AndrewLevin/genproductions/fix_run_pwg/bin/Powheg/run_pwg.py
#wget https://raw.githubusercontent.com/AndrewLevin/genproductions/master/bin/Powheg/run_pwg.py
#python ./run_pwg.py -p 0 -i powheg.input -m vbf_wp_wp -f my_working_directory -q 2nd
python ./run_pwg.py -p 0 -i powheg.input -m vbf_wp_wp -f my_working_directory_wp_wp

#wget https://raw.githubusercontent.com/AndrewLevin/genproductions/wpwp_powheg/bin/Powheg/production/wp_wp_j_j_ewk/powheg.input.wp_wp.step1
#mv powheg.input.wp_wp.step1 powheg.input
#python ./run_pwg.py -p 1 -x 1 -i powheg.input -m vbf_wp_wp -f my_working_directory_wp_wp -q 2nd -t 50000 -n 1000
#python ./run_pwg.py -p 1 -x 2 -i powheg.input -m vbf_wp_wp -f my_working_directory_wp_wp -q 2nd -t 50000 -n 1000
#python ./run_pwg.py -p 1 -x 3 -i powheg.input -m vbf_wp_wp -f my_working_directory_wp_wp -q 2nd -t 50000 -n 1000
#wget https://raw.githubusercontent.com/AndrewLevin/genproductions/wpwp_powheg/bin/Powheg/production/wp_wp_j_j_ewk/powheg.input.wp_wp.step2
#mv powheg.input.wp_wp.step2 powheg.input
#python ./run_pwg.py -p 2 -i powheg.input -m vbf_wp_wp -f my_working_directory_wp_wp -q 2nd -t 50000 -n 1000
#wget https://raw.githubusercontent.com/AndrewLevin/genproductions/wpwp_powheg/bin/Powheg/production/wp_wp_j_j_ewk/powheg.input.wp_wp.step3
#mv powheg.input.wp_wp.step3 powheg.input
#python ./run_pwg.py -p 3 -i powheg.input -m vbf_wp_wp -f my_working_directory_wp_wp -q 1nw -t 50000 -n 1000
#wget https://raw.githubusercontent.com/AndrewLevin/genproductions/wpwp_powheg/bin/Powheg/production/wp_wp_j_j_ewk/powheg.input.wp_wp.step4
#mv powheg.input.wp_wp.step4 powheg.input
#python ./run_pwg.py -p 4 -i powheg.input -m vbf_wp_wp -f my_working_directory_wp_wp -q 1nw -t 50000 -n 1000
