#============== SOURCE FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                          Falle (2002) Fig 6                          #
#                                                                      #
#  last dt=1.23212E-05, nhy=2173                                       #
#                                                                      #
#=======================================> Get files from home directory.
if(! -e dzeus35) cp /home/dclarke/zeus/version3.5/dzeus35 .
if(! -e checkin.o) cp /home/dclarke/zeus/checkin.o .
if(! -e dnamelist.a) cp /home/dclarke/nmlst/dnamelist.a .
if(! -e dsci01.a) cp /home/dclarke/sci/dsci01.a .
if(! -e grfx03.a) cp /home/dclarke/grfx/grfx03.a .
if(! -e psplot.a) cp /home/dclarke/grfx/psplot.a .
if(! -e noncar.a) cp /home/dclarke/grfx/noncar.a .
if(! -e xedit21) cp /home/dclarke/editor/xedit21 .
#=======================> If necessary, create the directory "dzeus3.5".
if(! -e dzeus3.5) mkdir dzeus3.5
#----------------------------------------------> Create the change deck.
rm -f chgzeus
cat << EOF > chgzeus
*read zeus35.mac
*d par.42,43
       parameter     (   in =1005,   jn =   1,   kn =   1 )
       parameter     ( nxpx =   1, nypx =   1, nxrd =   1, nyrd =   1 )
EOF
#=======================> Create the input deck for EDITOR, and execute.
rm -f inedit
cat << EOF > inedit
 \$editpar   inname='dzeus35'
          , ibanner=0, idump=1, job=3, safety=0.20
          , ipre=1, inmlst=1, iupdate=1, iutask=0
          , chgdk='chgzeus'
          , branch='dzeus3.5'
          , makename='makezeus', xeq='xdzeus35'
c         , coptions='-g -C -ftrap=common', loptions='-g'
          , coptions='-fast -fsimple=1', loptions='-fast'
          , speccopt='-O0', specdk='plot1d','nmlsts','tslplot'
          , libs='checkin.o dnamelist.a dsci01.a grfx03.a psplot.a 
  noncar.a'                                                            \$
EOF
chmod 755 xedit21
./xedit21
#--------------------------------------> Create the input deck for ZEUS.
rm -f inzeus
cat << EOF > inzeus
 \$iocon    iotty=6, iolog=2                                            \$
 \$rescon   dtdmp=0.0, idtag='xt', resfile='zr00xt'                     \$
 \$ggen1    nbl=1000,x1min=0.0, x1max=1.0, igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2                                                                \$
 \$ggen3                                                                \$
 \$pcon     nlim= 999999, tlim=-0.06, ttotal=900.0, tsave=10.0          \$
 \$hycon    qcon=2.0, qlin=0.2, courno=0.75, iord=2, iords=2, istp=0
         , itote=1, iscyqq=0                                           \$
 \$iib      niib(1,1)=9                                                 \$
 \$oib      noib(1,1)=9                                                 \$
 \$ijb                                                                  \$
 \$ojb                                                                  \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$plt1con  iplt1dir=1, dtplt1=0.06, corl=1, aspect=0.9, np1h=3, np1v=3
         , norpp1=2, ip1ftr=0, allxl=1
         , plt1var= 'd ', 'p ', 'et', 'v1', 'v2', 'v3', 'b2', 'b3'
                  , 'ps'
         , ip1soln=9*1                                                 \$
 \$plt2con                                                              \$
 \$pixcon                                                               \$
 \$voxcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon                                                               \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     idirect=1, n0=500, d0=0.5, v10=0.0, v20=2.0, v30=0.0
         , b20=2.5, b30=0.0, e10=15.0, b10=2.0                         \$
 \$pgen     idirect=1, n0=500, d0=0.1, v10=-10.0, v20=0.0, v30=0.0
         , b20=2.0, b30=0.0, e10=0.15, b10=2.0                         \$
EOF
#============================================> MAKE the ZEUS executable.
make -f makezeus
#===================================================> Tidy up directory.
rm -f editlp inedit output xedit21
