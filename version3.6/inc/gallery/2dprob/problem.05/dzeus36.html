#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#              MHD 2-D blast wave (Gardiner & Stone, 2005)             #
#                                                                      #
#  last dt=7.839465033322466E-05, nhy=131                              #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG kh
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
       parameter     (   in = 505,   jn = 255,   kn =   1 )
       parameter     ( nxpx = 800, nypx = 400, nxrd =   1, nyrd =   1 )
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
 \$ggen1    nbl=200, x1min=-0.5, x1max=0.5, igrid=1, x1rat=1., lgrid=.t.\$
 \$ggen2    nbl=200, x2min=-0.5, x2max=0.5, igrid=1, x2rat=1., lgrid=.t.\$
 \$ggen3                                                                \$
 \$pcon     nlim=999999, tlim=-0.02, ttotal=1.0e+7, tsave=10.0          \$
 \$hycon    qcon=1.0, qlin=0.1, courno=0.75, iord=2, iords=2, istp=0
         , trnvrsn=1, itote=1                                          \$
 \$iib      niib(1:205,1:  1)=9                                         \$
 \$oib      noib(1:205,1:  1)=9                                         \$
 \$ijb      nijb(1:  1,1:205)=9                                         \$
 \$ojb      nojb(1:  1,1:205)=9                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con                                                               \$
 \$pl2con   dtpl2=0.02, pl2dir=3, lpl2=1, norppl2=2, pl2mm1=1, pl2ftr=1
         , pl2ccol=2, pl2yl=1
         , pl2sca1 ='d ','et','p ','pb','vv'
         , pl2sca2 ='  ','  ','  ','an'
         , pl2vec1 ='v '
         , pl2ng1  =  10,   1,   1,   1, -10
         , numcl2  =   0,   0,   0,  80                                \$
 \$pixcon   dtpix=0.0004, pixdir=3, npixi=400, npixj=400, pixmm=0
         , iflippix=1, ppmpix=0
         , pixvar= 'd ', 'et', 'p ', 'pb'
         , nlpix =   10,    0,  100,   10
         , pixmax=  3.2,132.0,100.0, 90.0
         , pixmin=  0.2, 38.0, 0.75, 24.0                              \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsp=0.0002, norptsp=2                                     \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     r=0.125, d0=1.0, p0=  1.0, b10=7.0711, b20=7.0711
         ,          d1=1.0, p1=100.0, b11=7.0711, b21=7.0711           \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22 ./*.a
