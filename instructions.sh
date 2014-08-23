svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/POWHEG-BOX
cd POWHEG-BOX/Wp_Wp_J_J/
make COMPILER=gfortran pwhg_main
cd testrun
cp ../../../powheg.input.step1 powheg.input
../pwhg_main
# it will prompt you to "enter which seed"
# enter 1 and press enter
cp ../../../powheg.input.step2 powheg.input
../pwhg_main
# it will prompt you to "enter which seed"
# enter 1 and press enter
cp ../../../powheg.input.step3 powheg.input
../pwhg_main
# it will prompt you to "enter which seed"
#enter 1 and press enter
cp ../../../powheg.input.step4 powheg.input
../pwhg_main
# it will prompt you to "enter which seed"
#enter 1 and press enter
