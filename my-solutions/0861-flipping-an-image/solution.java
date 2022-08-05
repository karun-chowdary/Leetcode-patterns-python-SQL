class Solution {
    public int[][] flipAndInvertImage(int[][] A) {
      //  return flip(image);
       int C = A[0].length;
        for (int[] row: A)
            for (int i = 0; i < (C + 1) / 2; ++i) {
                int tmp = row[i] ^ 1;
                row[i] = row[C - 1 - i] ^ 1;
                row[C - 1 - i] = tmp;
            }

        return A; 
        
    }
   /* static int[][] flip(int[][] a){
       int  n = a.length;
        for (int[] j : a){
            int n1 = j.length;
            for(int i =0;i<n1/2;i++){
                int temp = j[i];
                j[i] = j[n1-i-1];
                j[n1-i-1]= temp;
                 j[i] = j[i]==0 ? 1:0;
                j[n1-i-1] = j[n1-i-1]==0 ? 1:0;
            }
            if(n1%2!=0&&n1!=1) j[n1%2]=j[n1%2]==0? 1:0;
            if(n1==1) j[0] = j[0]==0? 1:0;
        }
        return a;
    }*/
}
