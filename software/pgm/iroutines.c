/* iroutines.c: simple image processing routines for use with demopgm.c 
 * by Richard Zanibbi May 1998 for CISC 859 at Queen's University.
 * 
 * all routines take a 2D array of MAXROWS x MAXCOLS dimensions
 * along with the number of rows and columns in the actual image,
 * and manipulate the array in-place. 
 */

#include "PGM.h"
#include "iroutines.h"
#include <stdlib.h>
#include <stdio.h>

/* image processing routine: inverse image (b->w, w->b) */
//used for generating the raw pixels - araha
void invert (long rows,long cols,unsigned char image[MAXROWS][MAXCOLS]) {
    long i,j;
    FILE *fp;
    //fp = fopen("orig_pixels.h","w");
    //fprintf(fp,"int orig[%d][%d]={\n",rows,cols);
    //fp = fopen("raw_pixels.h","w");
    //fprintf(fp,"int app[%d][%d]={\n",rows,cols);
    fp = fopen("input.h","w");
    fprintf(fp,"int image[%d][%d]={\n",rows,cols);//input the type and array name
    for (i=0; i < rows; i++) {
	   fprintf(fp,"{");
         for (j=0; j < cols; j++) {
	   fprintf(fp,"%d,",image[i][j]);
	}
	   fprintf(fp,"},\n");
        }
	   fprintf(fp,"};");
    for (i=0; i < rows; i++) {
         for (j=0; j < cols; j++) {
	      image[i][j] = MAXVALUE - image[i][j];
	 }
    }     
}
/* image processing routine: mirror image (horizontal axis) */
void flipVertical (long rows,long cols,unsigned char image[MAXROWS][MAXCOLS]){
    long i,j; 
    unsigned char temp[MAXCOLS];
    for (i=0; i < (div(rows,2).quot); i++) {
        for (j=0; j < cols; j++) {
	     temp[j] = image[i][j];
	}
	for (j=0; j < cols; j++) {
	     image[i][j] = image[(rows - i)][j];
	}
	for (j=0; j < cols; j++) {
	     image [(rows - i)][j] = temp[j];
	}
    }
}
/* image processing routine: mirror image (vertical axis)  */
void flipHorizontal (long rows,long cols,
		     unsigned char image[MAXROWS][MAXCOLS]){
     long i,j;
     unsigned char temp[MAXROWS];
     for (i=0; i< (div(cols,2)).quot; i++) {
        for (j=0; j < rows; j++) {
	     temp[j] = image [j][i];
	}
	for (j=0; j < rows; j++) {
	     image[j][i] = image[j][(cols - i)];
	}
	for (j=0; j < rows ;j++) {
	     image [j][(cols - i)] = temp[j];
	}
    }
}
/* synthesis routine - vertical shaded bars */
//used for subsampling - araha
void synthBars (long rows,long cols,int ratio,unsigned char image[MAXROWS][MAXCOLS]){
    long i,j;
    //int ratio = 2;
    for (i=0; i < rows/ratio; i=i++) {
         for (j=0; j < cols/ratio; j=j++) {
              //image[i][j] = div(j,MAXVALUE).rem;
              image[i][j] = image[ratio*i][ratio*j];
	 }
    }
}
/* synthesis routine no. 2 : random generation */
void synthRand (long rows,long cols,unsigned char image[MAXROWS][MAXCOLS]){
    long i,j;
    for (i=0; i < rows; i++) {
         for (j=0; j < cols; j++) {
              image[i][j] = div(rand(),MAXVALUE).rem;
	 }
    }
}
