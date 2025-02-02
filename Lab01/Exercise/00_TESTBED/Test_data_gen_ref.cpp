// ========================================================
// Project:  Lab01 reference code
// File:     Test_data_gen_ref.cpp
// Author:   Lai Lin-Hung @ Si2 Lab
// Date:     2021.09.15
// ========================================================

#include <bits/stdc++.h>
 
using namespace std;
#define RED "\033[0;32;31m"
#define NONE "\033[m"
#define CYAN "\033[0;36m"

#define PATTERN_NUM 100000  //可調整PATTERN_NUM來決定PATTERN數目


/* dram.dat format
1. @10000
2. XX XX XX XX
3. @10004
4. XX XX XX XX
...
*/

/* Input format
1. [PATTERN_NUM] 

repeat(PATTERN_NUM)
	1. [mode] 
	2. [W_0 V_GS_0 V_DS_0]
	3. [W_1 V_GS_1 V_DS_1]
	4. [W_2 V_GS_2 V_DS_2]
	5. [W_3 V_GS_3 V_DS_3]
	6. [W_4 V_GS_4 V_DS_4]
	7. [W_5 V_GS_5 V_DS_5]

*/
/* Output format
1. [out_n]

*/

static const int TRIODE = 0;
static const int SATURATION = 1;

int get_work_mode(int vgs, int vds) {
	if (vgs - 1 > vds) {
		return TRIODE; // triode
	}
	else {
		return SATURATION; // saturation	
	}
}


int main(){
	FILE *pIFile = fopen("input.txt", "w");
	FILE *pOFile = fopen("output.txt", "w");

	// INIT
    //srand(time(NULL));
	srand(2);
	int num_pattern = PATTERN_NUM;
	int mode = 0, out_n;
	int w[6],vgs[6],vds[6],gm[6],id[6];
	srand(time(NULL)); // set random seed


	int count = 0;
	fprintf(pIFile,"%d\n",PATTERN_NUM);
	while(num_pattern--)
	{
        // You can generate test data here
		mode = rand()%4; // mode = 0 ~ 3
		auto mode_bit = bitset<2>(mode);
		for(int i = 0; i < 6; i++)
		{
			// all w, vgs, vds, gm, id are in the range of 1~7 integer
			w[i] = rand()%7+1;
			vgs[i] = rand()%7+1;
			vds[i] = rand()%7+1;

			// calculate id & gm
			int work_mode = get_work_mode(vgs[i], vds[i]); // get triode (0) or saturation (1)
			if (work_mode == TRIODE) {
				id[i] = (w[i] * (2*(vgs[i] - 1) * vds[i] - vds[i] * vds[i])) / 3;
				gm[i] = (2*w[i]*(vds[i])) / 3;
			}
			else {
				// saturation mode
				id[i] = (w[i] * (vgs[i] - 1) * (vgs[i] - 1)) / 3;
				gm[i] = (2*w[i]*(vgs[i] - 1)) / 3;
			}
		}


        // Show on terminal
		printf(RED "PATTERN %d\n" NONE,num_pattern);
		for(int i = 0; i < 6; i++)
			printf("NO: %d | w: %d vgs: %d vds: %d\n",i,w[i],vgs[i],vds[i]);
		for(int i = 0; i < 6; i++)
			printf("id[%d]: %3d ",i,id[i]);
		printf("\n");
		for(int i = 0; i < 6; i++)
			printf("gm[%d]: %3d ",i,gm[i]);
		printf("\n");
		
		// get a copy of the Sorted id and gm in non-ascending order
		int id_sorted[6], gm_sorted[6];
		for(int i = 0; i < 6; i++) {
			id_sorted[i] = id[i];
			gm_sorted[i] = gm[i];
		}
		sort(id_sorted, id_sorted+6, greater<int>());
		sort(gm_sorted, gm_sorted+6, greater<int>());
		cout << "id_sorted: ";
		for(int i = 0; i < 6; i++) {
			cout << id_sorted[i] << " ";
		}
		cout << endl;
		cout << "gm_sorted: ";
		for(int i = 0; i < 6; i++) {
			cout << gm_sorted[i] << " ";
		}
		cout << endl;

		// calculate out_n
		if ((int)mode_bit[0] == 1) {
			if ((int)mode_bit[1] == 1) {
				out_n = 3*id_sorted[0] + 4*id_sorted[1] + 5*id_sorted[2];
			}
			else {
				out_n = 3*id_sorted[3] + 4*id_sorted[4] + 5*id_sorted[5];
			}
		}
		else {
			if ((int)mode_bit[1] == 1) {
				out_n = gm_sorted[0] + gm_sorted[1] + gm_sorted[2];
			}
			else {
				out_n = gm_sorted[3] + gm_sorted[4] + gm_sorted[5];
			}
		}
		printf("mode[1:0] = %d%d, out_n = %d\n", (int)mode_bit[1], (int)mode_bit[0], out_n);

        // Output file
		fprintf(pIFile,"\n%d\n",mode);
		for(int i = 0; i < 6; i++)
			fprintf(pIFile,"%d %d %d\n",w[i],vgs[i],vds[i]);
		
		fprintf(pOFile,"%d\n",out_n);

	}


    return 0;

}
