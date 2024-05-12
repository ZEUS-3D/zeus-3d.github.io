#---+----1----+----2----+----3----+--+----3----+----2----+----1----+---#
#============== SCRIPT FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                 Relaxation in cylindrical coordinates                #
#                                                                      #
#  last dt= 5.050505050505051E-03, nhy=396                             #
#                                                                      #
#--------------------------------> Set FORTRAN compiler and problem tag.
#  Supported compilers include:
#     cf77 (Cray), f90 (Sun), g95 (g95.org), gfortran (Gnu), ifort 
#     (Intel), pgf77 (Portland Group), xlf (IBM)
#
setenv FCOMP gfortran
setenv TAG gj
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
       parameter     (   in =   1,   jn =8197,   kn =   1 )
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
 \$ggen1                                                                \$
 \$ggen2    nbl=100, x2min=0.0, x2max=1.0, igrid=1, x2rat=1.0, lgrid=.t.\$
 \$ggen3                                                                \$
 \$pcon     nlim= 999999, tlim=-2.0, ttotal=900.0, tsave=10.0           \$
 \$hycon    qcon=2.0, qlin=0.0, courno=0.5, iord=2, istp=0, dtrat=0.2
         , trnvrsn=1, itote=0                                          \$
 \$iib                                                                  \$
 \$oib                                                                  \$
 \$ijb      nijb(1:1  ,1:1  )=1                                         \$
 \$ojb      nojb(1:1  ,1:1  )=9                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$ambcon                                                               \$
 \$eqos                                                                 \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$pl1con   dtpl1=2.0, pl1dir=2, corl=1, aspect=0.9, npl1h=3, npl1v=2
         , norppl1=2, pl1ftr=1, allxl=1, pl1hdr=0, pl1mm=0
         , pl1var='d ','e1','v3','v1','b3','b1'
         , pl1ref=2*0.0183156,0.0182241,1.0,0.0182241,0.0183156
         , pl1min=2*0.0175,-0.001,0.0,-0.001,0.0175
         , pl1max=2*0.0185,0.02,0.0,0.02,0.0185                        \$
 \$pl2con                                                               \$
 \$pixcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$crkcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     idirect=2, d0=1.0, v0=1.0
         , advvar= 'e1', 'v1', 'b1', 'v3', 'b3'
         , ishp=3*1,6,6, amp=5*1.0, floor=5*1.0                        \$
EOF
#============================================> MAKE the ZEUS executable.
make -f ./makezeus
#===================================================> Tidy up directory.
rm -f ./editlp ./inedit ./output ./xedit22 ./*.a
