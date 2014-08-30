svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/POWHEG-BOX
cd POWHEG-BOX/VBF_Wp_Wp/
make COMPILER=gfortran pwhg_main
cd testrun
ln -s ../../pdfdata/cteq6m.tbl cteq6m
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
#maybe change the number of events from 100000 to something smaller
../pwhg_main
# it will prompt you to "enter which seed"
#enter 1 and press enter
