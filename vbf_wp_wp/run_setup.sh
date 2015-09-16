export SCRAM_ARCH=slc6_amd64_gcc481
scram p CMSSW CMSSW_7_1_14
cd CMSSW_7_1_14/src
eval `scramv1 runtime -sh`

BOOK_HISTO="pwhg_bookhist-multi.o"

export FASTJET_BASE=`scram tool info fastjet | grep FASTJET_BASE | sed -e s%FASTJET_BASE=%%`

export PATH=$FASTJET_BASE/bin/:$PATH

export LHAPDF_BASE=`scram tool info lhapdf | grep LHAPDF_BASE | sed -e s%LHAPDF_BASE=%%`
export PATH=$LHAPDF_BASE/bin/:$PATH
export LHAPATH=`scram tool info lhapdf | grep LHAPATH | sed -e s%LHAPATH=%%`
export LHAPDF6TOOLFILE=$CMSSW_BASE/config/toolbox/$SCRAM_ARCH/tools/available/lhapdf6.xml

if [ -e $LHAPDF6TOOLFILE ]; then
  export LHAPDF6_BASE=`grep LHAPDF6_BASE $CMSSW_BASE/config/toolbox/$SCRAM_ARCH/tools/available/lhapdf6.xml | head -1 | cut -d \\" -f 4 `
  export LHAPDF_DATA_PATH=`$LHAPDF6_BASE/bin/lhapdf-config --datadir`
fi

export PATH=`pwd`:${PATH}

svn checkout --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/POWHEG-BOX-V2 POWHEG-BOX

cd POWHEG-BOX

svn co --username anonymous --password anonymous svn://powhegbox.mib.infn.it/trunk/User-Processes-V2/vbf_wp_wp

cd -

wget https://raw.githubusercontent.com/AndrewLevin/genproductions/master/bin/Powheg/patches/pdfweights.patch

patch -l -p0 -i pdfweights.patch

cd POWHEG-BOX/vbf_wp_wp/

mkdir -p include

sed -i -e "s#STATIC[ \t]*=[ \t]*-static#STATIC=-dynamic#g" Makefile
sed -i -e "s#PDF[ \t]*=[ \t]*native#PDF=lhapdf#g" Makefile

sed -i -e "s#COMPILER[ \t]*=[ \t]*ifort#COMPILER=gfortran#g" Makefile

sed -i -e "s#PWHGANAL[ \t]*=[ \t]*#\#PWHGANAL=#g" Makefile
sed -i -e "s#ANALYSIS[ \t]*=[ \t]*#\#ANALYSIS=#g" Makefile
sed -i -e "s#LHAPDF_CONFIG[ \t]*=[ \t]*#\#LHAPDF_CONFIG=#g" Makefile
sed -i -e "s#pwhg_bookhist.o# #g" Makefile
sed -i -e "s#pwhg_bookhist-new.o# #g" Makefile
sed -i -e "s#pwhg_bookhist-multi.o# #g" Makefile

echo "LIBS+=-lz -lstdc++" >> Makefile

echo "ANALYSIS=none 
PWHGANAL=$BOOK_HISTO pwhg_analysis-dummy.o
LHAPDF_CONFIG=${LHAPDF6_BASE}/bin/lhapdf-config" >> tmpfile
mv Makefile Makefile.interm
cat tmpfile Makefile.interm > Makefile
rm -f Makefile.interm tmpfile


make pwhg_main || fail_exit "Failed to compile pwhg_main"

