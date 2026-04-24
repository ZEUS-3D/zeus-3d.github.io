#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                 Magnetic braking of an aligned rotor                 #
#                                                                      #
#  last dt= 4.386244899703490E-02, nhy=286                             #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG cl
#=======================================> Get files from home directory.
if(! -e ./xedit22) cp ../editor/xedit22 .
if(! -e ./dnamelist.a) cp ../nmlst/dnamelist.a .
if(! -e ./dsci01.a) cp ../sci/dsci01.a .
if(! -e ./grfx03.a) cp ../grfx/grfx03.a .
if(! -e ./psplot.a) cp ../grfx/psplot.a .
if(! -e ./noncar.a) cp ../grfx/noncar.a .
#=======================> If necessary, create the directory "dzeus3.6".
if(! -e ./dzeus3.6) mkdir ./dzeus3.6
#----------------------------------------------> Create the change deck.
rm -f ./chgzeus
cat << EOF > ./chgzeus
*read zeus36.mac
*define $FCOMP
*d par.44,45
       parameter     (   in =8197,   jn =   1,   kn =   1 )
       parameter     ( nxpx =   1, nypx =   1, nxrd =   1, nyrd =   1 )
**read chguser
EOF
#=======================> Create the input deck for EDITOR, and execute.
rm -f ./inedit
cat << EOF > ./inedit
 \$editpar   inname='dzeus36', chgdk='chgzeus', idump=1, job=3
          , ipre=1, inmlst=1, iupdate=1, iutask=0, safety=0.20
          , branch='dzeus3.6', xeq='xdzeus36', makename='makezeus'
          , compiler='$FCOMP', coptions='optimise'
          , libs='checkin.o dnamelist.a dsci01.a grfx03.a psplot.a 
  noncar.a'                                                            \$
EOF
chmod 755 ./xedit22
./xedit22
#--------------------------------------> Create the input deck for ZEUS.
rm -f ./inzeus
cat << EOF > ./inzeus
 \$iocon    iotty=6, iolog=2                                            \$
 \$rescon   dtdmp=0.0, idtag='$TAG', resfile='zr000$TAG'                \$
 \$ggen1    nbl=300, x1min=0.0, x1max=15., igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2                                                                \$
 \$ggen3                                                                \$
 \$pcon     nlim= 999999, tlim=-13.0, ttotal=900.0, tsave=100.0         \$
 \$hycon    qcon=0.0, qlin=0.0, courno=1.3782, iord=2, istp=0
         , trnvrsn=1, itote=0                                          \$
 \$iib      niib(1:1  ,1:1  )=3                                         \$
 \$oib      noib(1:1  ,1:1  )=9                                         \$
 \$ijb                                                                  \$
 \$ojb                                                                  \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con   dtpl1=13.0, pl1dir=1, corl=1, aspect=0.9, npl1h=2, npl1v=2
         , norppl1=2, pl1ftr=1, allxl=1, pl1hdr=0, pl1mm=0
         , pl1var ='d ','v1','v3','b3'
         , pl1soln=   0,   0,   1,   1                                 \$
 \$pl2con                                                               \$
 \$pixcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     zcyl=1.0, wcyl=1.0e-6, eta=10.0, e1init=0.9, bzinit=1.0
         , dorc=1                                                      \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22 ./*.a
