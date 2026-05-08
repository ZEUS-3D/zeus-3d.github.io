#============== SOURCE FILE TO CREATE THE ZEUS EXECUTABLE =============#
#                                                                      #
#                      2 - D   M H D   B L A S T                       #
#                                                                      #
#  test problem described in Gardener & Stone, 2005, JCP, 205, 509     #
#                                                                      #
#  itote=1, iord=2, iords=3, istp=2, qcon=1.0, qlin=0.1, courno=0.5    #
#  time=2.00873939E-02, nhy=193, last dt=1.14714E-04, nwarn=0          #
#                                                                      #
#  nwarn = the number of negative internal energies reset              #
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
       parameter     (   in = 205,   jn = 205,   kn =   1 )
       parameter     ( nxpx = 400, nypx = 400, nxrd =   1, nyrd =   1 )
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
          , speccopt='-O0', specdk='nmlsts','plot1d','plot2d','tslplot'
          , libs='checkin.o dnamelist.a dsci01.a grfx03.a psplot.a 
  noncar.a'                                                            \$
EOF
chmod 755 xedit21
./xedit21
#--------------------------------------> Create the input deck for ZEUS.
rm -f inzeus
cat << EOF > inzeus
 \$iocon    iotty=6, iolog=2                                            \$
 \$rescon   dtdmp=0.0, idtag='gs', resfile='zr000gs'                    \$
 \$ggen1    nbl=200,x1min=-0.5,x1max= 0.5, igrid=1, x1rat=1.0, lgrid=.t.\$
 \$ggen2    nbl=200,x2min=-0.5,x2max= 0.5, igrid=1, x2rat=1.0, lgrid=.t.\$
 \$ggen3                                                                \$
 \$pcon     nlim= 20000, tlim=0.02, ttotal=1.0e+7, tsave=10.0           \$
 \$hycon    qcon=1.0, qlin=0.1, courno=0.5, iord=2, iords=3, istp=2
         , itote=1                                                     \$
 \$iib      niib(1:205,1:  1)=9                                         \$
 \$oib      noib(1:205,1:  1)=9                                         \$
 \$ijb      nijb(1:  1,1:205)=9                                         \$
 \$ojb      nojb(1:  1,1:205)=9                                         \$
 \$ikb                                                                  \$
 \$okb                                                                  \$
 \$grvcon                                                               \$ 
 \$eqos     gamma=1.66666666666667                                      \$
 \$gcon                                                                 \$
 \$extcon                                                               \$
 \$plt1con  dtplt1=0.005, iplt1dir=1,2, iplt1=1,102, jplt1=102,1
         , corl=1, np1h=2, np1v=2, norpp1=2, allxl=1
         , plt1var='d ','p ','u1','et','v1','v2','b1','b2','m ','ma'
                  ,'vv','pb'                                           \$
 \$plt2con  dtplt2=0.005, iplt2dir=3, lplt2=1, norpp2=2
         , plt2var='d ','p ','pb','an'
         , ngplt2 =   0,   0,   0,   0
         , numcl  =   0,   0,   0, 100
         , pscolr =   2,   2,   2,   0
         , pscntr =   0,   0,   0,   1                                 \$
 \$pixcon   ipixdir=3, dtpix=0.0005, lpix=1, iflippx=1
         , npi=400, npj=400, ipixmm=0, iref=0
         , pixvar= 'd ', 'p ', 'pb', 'an'
         , nlpix =   10,   10,   10,    0
         , pixmax= 4.80, 50.0, 80.0,  0.0
         , pixmin= 0.15,  0.7, 20.0,  0.0                              \$
 \$voxcon                                                               \$
 \$usrcon                                                               \$
 \$hdfcon                                                               \$
 \$tslcon   dttsl=0.005, dttslp=0.0005, norptsl=1                       \$
 \$discon                                                               \$
 \$radcon                                                               \$
 \$pgen     r=0.125, d0=1.0, p0=  1.0, b10=7.0711, b20=7.0711
         ,          d1=1.0, p1=100.0, b11=7.0711, b21=7.0711           \$
EOF
#============================================> MAKE the ZEUS executable.
make -f makezeus
#===================================================> Tidy up directory.
rm -f editlp inedit output xedit21
