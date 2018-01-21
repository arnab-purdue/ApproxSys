#APP SYS - HAAR
#Arnab Raha

#cp -r haar_step2x.cpp haar.cpp

echo " "
echo "solvay"
#cp -r solvay4xqbin2.pgm Face.pgm
cp -r solvay.pgm Face.pgm
make clean
make all
make run
#cp -r Output.pgm solvay_step1cam4xqbin2_output.pgm
cp -r Output.pgm solvay_output.pgm

echo " "
echo "dfb"
#cp -r dfb4xqbin2.pgm Face.pgm
cp -r dfb.pgm Face.pgm
make clean
make all
make run
#cp -r Output.pgm dfb_step1cam4xqbin2_output.pgm
cp -r Output.pgm dfb_output.pgm

echo " "
echo "nasa"
#cp -r nasa4xqbin2.pgm Face.pgm
cp -r nasa.pgm Face.pgm
make clean
make all
make run
#cp -r Output.pgm nasa_step1cam4xqbin2_output.pgm
cp -r Output.pgm nasa_output.pgm

cp -r haar_step1.cpp haar.cpp

#echo " "
#echo "solvay2x"
#cp -r solvay2x.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm solvay2x_output.pgm
#
#echo " "
#echo "dfb2x"
#cp -r dfb2x.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm dfb2x_output.pgm
#
#echo " "
#echo "nasa2x"
#cp -r nasa2x.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm nasa2x_output.pgm
#
#echo " "
#echo "solvay4x"
#cp -r solvay4x.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm solvay4x_output.pgm
#
#echo " "
#echo "dfb4x"
#cp -r dfb4x.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm dfb4x_output.pgm
#
#echo " "
#echo "nasa4x"
#cp -r nasa4x.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm nasa4x_output.pgm
#
#echo " "
#echo "solvayqbin2"
#cp -r solvayqbin2.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm solvayqbin2_output.pgm
#
#echo " "
#echo "dfbqbin2"
#cp -r dfbqbin2.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm dfbqbin2_output.pgm
#
#echo " "
#echo "nasaqbin2"
#cp -r nasaqbin2.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm nasaqbin2_output.pgm
#
#
#echo " "
#echo "solvayqbin4"
#cp -r solvayqbin4.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm solvayqbin4_output.pgm
#
#echo " "
#echo "dfbqbin4"
#cp -r dfbqbin4.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm dfbqbin4_output.pgm
#
#echo " "
#echo "nasaqbin4"
#cp -r nasaqbin4.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm nasaqbin4_output.pgm
#
#echo " "
#echo "solvayqbin6"
#cp -r solvayqbin6.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm solvayqbin6_output.pgm
#
#echo " "
#echo "dfbqbin6"
#cp -r dfbqbin6.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm dfbqbin6_output.pgm
#
#echo " "
#echo "nasaqbin6"
#cp -r nasaqbin6.pgm Face.pgm
#make clean
#make all
#make run
#cp -r Output.pgm nasaqbin6_output.pgm
