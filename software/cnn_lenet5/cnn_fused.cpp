#include <stdio.h>
#include "params_init.h"
//#include "params_20_identity.h"
#include "test_images.h"
#include "test_labels.h"
#include <sys/time.h>

#define SIZE 10000

typedef struct {
    // Layer Parameters
    int neu_c;
    int win_s;
    int fea_c;
    int fea_s;
} nnl;

float neu_mac (float* , float* , int );
float neu_mac_ws (float* , float* , int , int );
float neu_mac_w (float* , float* , int , int* , nnl* );

// ******** I0 ******** //
float outI0[1024];

nnl I0 = {1024, 0, 1, 32};

// ******** C1 ******** //
float outC1[4704];
float* i_n_addC1[4704];
float* w_n_addC1[4704];
float* b_n_addC1[4704];
float* o_n_addC1[4704];
int* c_n_addC1[4704];
int ctC1[6][1] = {1,1,1,1,1,1};
int idC1[4704];

nnl C1 = {4704, 5, 6, 28};

// ******** S2 ******** //
float outS2[1176];
float* i_n_addS2[1176];
float* w_n_addS2[1176];
float* b_n_addS2[1176];
float* o_n_addS2[1176];

nnl S2 = {1176, 2, 6, 14};

// ******** C3 ******** //
float outC3[1600];
float* i_n_addC3[1600];
float* w_n_addC3[1600];
float* b_n_addC3[1600];
float* o_n_addC3[1600];
int* c_n_addC3[1600];
int ctC3[16][6] = { {1,1,1,0,0,0},
                    {0,1,1,1,0,0},
                    {0,0,1,1,1,0},
                    {0,0,0,1,1,1},
                    {1,0,0,0,1,1},
                    {1,1,0,0,0,1},
                    {1,1,1,1,0,0},
                    {0,1,1,1,1,0},
                    {0,0,1,1,1,1},
                    {1,0,0,1,1,1},
                    {1,1,0,0,1,1},
                    {1,1,1,0,0,1},
                    {1,1,0,1,1,0},
                    {0,1,1,0,1,1},
                    {1,0,1,1,0,1},
                    {1,1,1,1,1,1}
                  };
int idC3[1600];
nnl C3 = {1600, 5, 16, 10};

// ******** S4 ******** //
float outS4[400];
float* i_n_addS4[400];
float* w_n_addS4[400];
float* b_n_addS4[400];
float* o_n_addS4[400];

nnl S4 = {400, 2, 16, 5};

// ******* C5 ******** //
float outC5[120];
float* i_n_addC5[120];
float* w_n_addC5[120];
float* b_n_addC5[120];
float* o_n_addC5[120]; 

nnl C5 = {120, 0, 1, 1};

// ******* F6 ******** //
float out[10];
float* i_n_addF6[10];
float* w_n_addF6[10];
float* b_n_addF6[10];
float* o_n_addF6[10]; 

nnl F6 = {10, 0, 1, 1};

// ******** Result ******* //
float accuracy;
int no_c;
int num_correct;

int main ()
{
    
    // Lenet 5 Architecture
    int n;
    
    // Precomputation of I/W/B/O addresses
    int i,j,k; 
    int nc,index,indexp;
    float* w_ptr;
    float* b_ptr;
    float* i_ptr;
    float* o_ptr;
    int* c_ptr; 
    // C1
    nc = 0;
    w_ptr = wbC1; 
    b_ptr = &wbC1[150];
    c_ptr = &ctC1[0][0];
    for (i=0; i < C1.fea_c; i++)
    {
        for(j=0; j < C1.fea_s;j+=2)
        {
            for(k=0; k < C1.fea_s; k+=2)
            {
                index = i * C1.fea_s * C1.fea_s + j * C1.fea_s + k;
                indexp = j * I0.fea_s + k;
                i_ptr = outI0 + indexp;
                o_ptr = outC1 + index;
                i_n_addC1[nc] = i_ptr;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index;
                nc++;
                i_n_addC1[nc] = i_ptr+1;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+1;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+1;
                nc++;
                i_n_addC1[nc] = i_ptr+I0.fea_s;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+C1.fea_s;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+C1.fea_s;
                nc++;
                i_n_addC1[nc] = i_ptr+I0.fea_s+1;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+C1.fea_s+1;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+C1.fea_s+1;
                nc++;
            }
        }
        w_ptr += C1.win_s * C1.win_s;
        b_ptr ++;
        c_ptr+= I0.fea_c;
    }
    // S2
    nc = 0;
    w_ptr = wbS2; 
    b_ptr = &wbS2[6];
    for (i=0; i < S2.fea_c; i++)
    {
        for(j=0; j < S2.fea_s;j++)
        {
            for(k=0; k < S2.fea_s; k++)
            {
                index = i * C1.fea_s * C1.fea_s + j*2*C1.fea_s + k*2;
                i_ptr = outC1 + index;
                o_ptr = outS2 + nc;
                i_n_addS2[nc] = i_ptr;
                w_n_addS2[nc] = w_ptr;
                b_n_addS2[nc] = b_ptr;
                o_n_addS2[nc] = o_ptr;
                nc++;
            }
        }
        w_ptr ++;
        b_ptr ++;
    }
    // C3
    nc = 0;
    w_ptr = wbC3; 
    b_ptr = &wbC3[2400];
    for (i=0; i < C3.fea_c; i++)
    {
        c_ptr = &ctC3[i][0];
        for(j=0; j < C3.fea_s;j+=2)
        {
            for(k=0; k < C3.fea_s; k+=2)
            {
                index = i * C3.fea_s * C3.fea_s + j * C3.fea_s + k;
                indexp = j * S2.fea_s + k;
                i_ptr = outS2 + indexp;
                o_ptr = outC3 + index;
                i_n_addC3[nc] = i_ptr;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index;
                nc++;
                i_n_addC3[nc] = i_ptr+1;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr+1;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index+1;
                nc++;
                i_n_addC3[nc] = i_ptr+S2.fea_s;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr+C3.fea_s;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index+C3.fea_s;
                nc++;
                i_n_addC3[nc] = i_ptr+S2.fea_s+1;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr+C3.fea_s+1;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index+C3.fea_s+1;
                nc++;
            }
        }
        for(j=0;j<S2.fea_c;j++)
        {
            if(ctC3[i][j]==1)
            {
                w_ptr += C3.win_s * C3.win_s;
            }
        }
        b_ptr ++;
    }
    // S4
    nc = 0;
    w_ptr = wbS4; 
    b_ptr = &wbS4[16];
    for (i=0; i < S4.fea_c; i++)
    {
        for(j=0; j < S4.fea_s;j++)
        {
            for(k=0; k < S4.fea_s; k++)
            {
                index = i*C3.fea_s * C3.fea_s + j*2*C3.fea_s + k*2;
                i_ptr = outC3 + index;
                o_ptr = outS4 + nc;
                i_n_addS4[nc] = i_ptr;
                w_n_addS4[nc] = w_ptr;
                b_n_addS4[nc] = b_ptr;
                o_n_addS4[nc] = o_ptr;
                nc++;
            }
        }
        w_ptr ++;
        b_ptr ++;
    }

    // C5
    nc = 0;
    w_ptr = wbC5; 
    b_ptr = &wbC5[48000];
    i_ptr = outS4;
    o_ptr = outC5;
    for (i=0; i < C5.neu_c; i++)
    {
        i_n_addC5[nc] = i_ptr;
        w_n_addC5[nc] = w_ptr + nc * S4.neu_c;
        b_n_addC5[nc] = b_ptr + nc;
        o_n_addC5[nc] = o_ptr + nc;
        nc++;
    }
    
    // F6
    nc = 0;
    w_ptr = wbF6; 
    b_ptr = &wbF6[1200];
    i_ptr = outC5;
    o_ptr = out;
    for (i=0; i < F6.neu_c; i++)
    {
        i_n_addF6[nc] = i_ptr;
        w_n_addF6[nc] = w_ptr + nc * C5.neu_c;
        b_n_addF6[nc] = b_ptr + nc;
        o_n_addF6[nc] = o_ptr + nc;
        nc++;
    }
    // *************** Actual forward propagation ***************** //
    int size = SIZE;
    num_correct = 0;
    int ipc;
    timeval st_time,end_time;
    gettimeofday(&st_time,NULL);
    for (ipc=0;ipc<size;ipc++)
    {
        for(n=0; n < I0.neu_c; n++)
        {
            outI0[n] = test_images[ipc][n];
        }
        // C1S2
        //printf("Next layer\n");
        for(n=0; n < S2.neu_c ; n++)
        {
            float neu_out = 0.0;
            int C1_n = 4 * n; 
            neu_out = neu_mac_w(i_n_addC1[C1_n],w_n_addC1[C1_n],C1.win_s,c_n_addC1[C1_n], &I0) + *(b_n_addC1[C1_n]); 
            C1_n++;            
            neu_out += neu_mac_w(i_n_addC1[C1_n],w_n_addC1[C1_n],C1.win_s,c_n_addC1[C1_n], &I0) + *(b_n_addC1[C1_n]); 
            C1_n++;            
            neu_out += neu_mac_w(i_n_addC1[C1_n],w_n_addC1[C1_n],C1.win_s,c_n_addC1[C1_n], &I0) + *(b_n_addC1[C1_n]); 
            C1_n++;            
            neu_out += neu_mac_w(i_n_addC1[C1_n],w_n_addC1[C1_n],C1.win_s,c_n_addC1[C1_n], &I0) + *(b_n_addC1[C1_n]);
            *(o_n_addS2[n]) = neu_out * (*(w_n_addS2[n])) * 0.25 +  *(b_n_addS2[n]);
           // printf(" %d : %f\n",n,*(o_n_addS2[n]));
        }
        // C3S4
//        printf("Next layer\n");
        for(n=0; n < S4.neu_c ; n++)
        {
            float neu_out = 0.0;
            int C3_n = 4 * n; 
            neu_out = neu_mac_w(i_n_addC3[C3_n],w_n_addC3[C3_n],C3.win_s,c_n_addC3[C3_n], &S2) + *(b_n_addC3[C3_n]); 
           // printf(" %d : %f\n",idC3[C3_n],neu_out);
            C3_n++;            
            neu_out += neu_mac_w(i_n_addC3[C3_n],w_n_addC3[C3_n],C3.win_s,c_n_addC3[C3_n], &S2) + *(b_n_addC3[C3_n]); 
           // printf(" %d : %f\n",idC3[C3_n],neu_out);
            C3_n++;            
            neu_out += neu_mac_w(i_n_addC3[C3_n],w_n_addC3[C3_n],C3.win_s,c_n_addC3[C3_n], &S2) + *(b_n_addC3[C3_n]); 
           // printf(" %d : %f\n",idC3[C3_n],neu_out);
            C3_n++;            
            neu_out += neu_mac_w(i_n_addC3[C3_n],w_n_addC3[C3_n],C3.win_s,c_n_addC3[C3_n], &S2) + *(b_n_addC3[C3_n]);
           // printf(" %d : %f\n",idC3[C3_n],neu_out);
            *(o_n_addS4[n]) = neu_out * (*(w_n_addS4[n])) * 0.25 +  *(b_n_addS4[n]);
           // printf(" %d : %f\n",n,*(o_n_addS2[n]));
        
        }
        // C5
//        printf("Next layer\n");
        for(n=0; n < C5.neu_c ; n++)
        {
            *(o_n_addC5[n]) = neu_mac(i_n_addC5[n],w_n_addC5[n],S4.neu_c);
            *(o_n_addC5[n]) += *(b_n_addC5[n]);
//            printf(" %d : %f\n",n,*(o_n_addC5[n]));
        }
        // F6
//        printf("Next layer\n");
        for(n=0; n < F6.neu_c ; n++)
        {
            *(o_n_addF6[n]) = neu_mac(i_n_addF6[n],w_n_addF6[n],C5.neu_c);
            *(o_n_addF6[n]) += *(b_n_addF6[n]);
//            printf(" %d : %f\n",n,*(o_n_addF6[n]));
        }
        
        // Find Max value to get label and update result
        
        //printf("OUTPUT %d\n",ipc);
        float max_val = -10000.0;
        int prediction = -1; 
        for(n=0;n <  F6.neu_c ; n++)
        {
            if (out[n] > max_val) 
            {
                max_val = out[n];
                prediction = n;
            }
         //   printf("%f\n",out[n]);

        }
        if( prediction == test_labels[ipc])
        {
            num_correct++;
        }
    }
    gettimeofday(&end_time,NULL);
    printf("Time: %f\n",end_time.tv_sec-st_time.tv_sec+((double)(end_time.tv_usec-st_time.tv_usec))/1000000);// Update
    accuracy = (float)num_correct/size;
    printf("Correct: %d out of %d\n",num_correct,size);// Update
}


float neu_mac (float* ip_st, float* w_st, int size)
{
    int i;
    float* ip = ip_st;
    float* w = w_st;
    float op = 0.0;
    for (i=0;i < size; i++)
    {
        op += *ip * *w;
        ip++;
        w++;
    }
    return (op);
}

float neu_mac_ws (float* ip_st, float* w_st, int win_size, int ip_fea_dim)
{
    int i,j;
    float* ip = ip_st;
    float op = 0.0;
    int ip_incr = ip_fea_dim - win_size;
    for (i=0;i < win_size; i++)
    {
        for(j=0;j<win_size;j++)
        {
            op += *ip * *w_st;
            ip++;
        }
        ip += ip_incr; 
    }
    return (op/(win_size*win_size));
}

float neu_mac_w (float* ip_st, float* w_st, int win_size, int* ct_st, nnl* ip_lay)
{
    int h,i,j;
    float* ip; 
    float* w = w_st;
    float op = 0.0;
    int ip_incr = ip_lay->fea_s - win_size;
    for (h=0; h < ip_lay->fea_c ; h++)
    {
        ip = ip_st + h * ip_lay->fea_s * ip_lay->fea_s;
        if(*(ct_st+h)==1)
        {
            for (i=0;i < win_size; i++)
            {
                for(j=0;j<win_size;j++)
                {
                    op += *ip * *w;
                    ip++;
                    w++;
                }
                ip += ip_incr; 
            }
        }
    }
    return (op);
}




/*
                i_n_addC1[nc] = i_ptr+2;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+2;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+2;
                nc++;
                i_n_addC1[nc] = i_ptr+3;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+3;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+3;
                nc++;
*/
