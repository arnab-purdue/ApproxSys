/*
 *  TU Eindhoven
 *  Eindhoven, The Netherlands
 *
 *  Name            :   faceDetection.cpp
 *
 *  Author          :   Francesco Comaschi (f.comaschi@tue.nl)
 *
 *  Date            :   November 12, 2012
 *
 *  Function        :   Main function for face detection
 *
 *  History         :
 *      12-11-12    :   Initial version.
 *
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program;  If not, see <http://www.gnu.org/licenses/>
 *
 * In other words, you are welcome to use, share and improve this program.
 * You are forbidden to forbid anyone else to use, share and improve
 * what you give them.   Happy coding!
 */

#include <stdio.h>
#include <stdlib.h>
#include "image.h"
#include "stdio-wrapper.h"
#include "haar.h"
#include <time.h>
#include <sys/timeb.h>




#define INPUT_FILENAME "Face.pgm"
#define OUTPUT_FILENAME "Output.pgm"

using namespace std;


int main (int argc, char *argv[]) 
{

//Arnab added
//clock_t start,end;
//double cpu_time_used;
long long int start_time,time_difference;
long long int start_time_sec, time_difference_sec;
timespec gettime_now;
clock_gettime(CLOCK_REALTIME, &gettime_now);
start_time_sec = gettime_now.tv_sec;
start_time = gettime_now.tv_nsec;


	int flag;
	
	int mode = 1;
	int i;

	/* detection parameters */
	float scaleFactor = 1.2;
	int minNeighbours = 1;


	printf("-- entering main function --\r\n");

	printf("-- loading image --\r\n");

	MyImage imageObj;
	MyImage *image = &imageObj;

	flag = readPgm((char *)"Face.pgm", image);
	if (flag == -1)
	{
		printf( "Unable to open input image\n");
		return 1;
	}

	printf("-- loading cascade classifier --\r\n");

	myCascade cascadeObj;
	myCascade *cascade = &cascadeObj;
	MySize minSize = {20, 20};
	MySize maxSize = {0, 0};

	/* classifier properties */
	cascade->n_stages=25;
	cascade->total_nodes=2913;
	cascade->orig_window_size.height = 24;
	cascade->orig_window_size.width = 24;


	readTextClassifier();


//start = clock();
	std::vector<MyRect> result;

	printf("-- detecting faces --\r\n");

	result = detectObjects(image, minSize, maxSize, cascade, scaleFactor, minNeighbours);
//end = clock();


timespec gettime_now_2;
clock_gettime(CLOCK_REALTIME, &gettime_now_2);
// Arnab added
time_difference_sec = gettime_now_2.tv_sec - start_time_sec; 
time_difference = gettime_now_2.tv_nsec - start_time + 1000000000LL*time_difference_sec;


	for(i = 0; i < result.size(); i++ )
	{
		MyRect r = result[i];
		drawRectangle(image, r);
	}

	printf("-- saving output --\r\n"); 
	flag = writePgm((char *)OUTPUT_FILENAME, image); 

	printf("-- image saved --\r\n");

	/* delete image and free classifier */
	releaseTextClassifier();
	freeImage(image);
//cpu_time_used = ((double)(end-start))/CLOCKS_PER_SEC;
//printf("Clocks/sec = %d\n",CLOCKS_PER_SEC);
//printf("Main = %f\n",cpu_time_used);
float time_sec = (float) time_difference/1000000000.0;
//printf("Main = %llu\n",time_difference);
//printf("Main = %f\n",time_sec);
	return 0;

}
