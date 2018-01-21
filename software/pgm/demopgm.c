/* demopgm.c  by Richard Zanibbi (May 1998) for
 * CISC 859 at Queen's University.
 *
 * This program produces a menu that the user may
 * select from to open PGM (P2 or P5) files and perform
 * simple image processing on them, or view a couple of 
 * simple synthesis techniques.  
 *
 * NOTE:  all output is stored (repeatedly if necessary) to
 *   the file demo.pgm.  The program calls xv to display demo.pgm
 *   after each request.
 */

#include "PGM.h"
#include "iroutines.h"
#include <stdio.h>
#include <stdlib.h>
//#include "image.h"
//#include "panda.h"
//#include "input4x.h"
//#include "panda4x.h"
//#include "eagle_orig.h"
//#include "eagle9x_qbin8.h"
//#include "test2x_mnistqbin8100.h"
//#include "mt_nz_4x_qbin8.h"

unsigned char image[MAXROWS][MAXCOLS];  /* 2D array to hold the image */

int main (int argc, char *argv[]){
    long rows,cols;                         /* dimensions of the pixmap */
    char userInput[60];                     /* input from user */
    int readOK,loopCondition,request;       /* two flags and user's request */
    int writeOK;                           /* flag for succesful write */
    //printf ("Input Filename:\n"); /*  and manipulate it. */
    //scanf ("%s",argv[1]);
    
    //long rows2 = 600;
    //long cols2 = 1600;
    //unsigned char image[MAXROWS][MAXCOLS];  /* 2D array to hold the image */
    //int ratio = 1;

//For converting back to .h file --  Arnab
    readOK = pgmRead (argv[1],&rows,&cols,image);
    invert (rows,cols,image);//acquire raw_pixels - for quality
    
    //synthBars (rows,cols,ratio,image);//for subsampling pgm
    //writeOK = pgmWrite ("test1_1_5_2.pgm",rows/ratio,cols/ratio,image,"test");//with ratio
    //writeOK = pgmWrite ("test1_6_16.pgm",rows2,cols2,image,"test");//with absolute parameters
    //writeOK = pgmWrite ("input4x.pgm",rows2,cols2,image,"test");//with absolute parameters
  
//For converting *.h to *.pgm -- Arnab
/* 
    long rows3 = 600;
    long cols3 = 800; 
    writeOK = pgmWrite ("mt_nz4xqbin8.pgm",rows3,cols3,image,"test");//with absolute parameters
*/   
}
