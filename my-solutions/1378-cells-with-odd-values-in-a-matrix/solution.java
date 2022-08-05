class Solution {
    public int oddCells(int m, int n, int[][] in) {
        int[][] a = new int[m][n];
        int c =0;
        for( int i =0;i<in.length;i++){
            for(int j =0;j<n;j++){
                a[in[i][0]][j]+=1;
                
            }
            for(int k =0;k<m;k++){
                a[k][in[i][1]]+=1;
                
            }
        }
        for(int i =0;i<m;i++){
            for(int j =0;j<n;j++){
                if(a[i][j]%2!=0) c+=1;
            }
        }
        return c;
        
    }
}
