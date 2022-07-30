class Solution {
    public int subtractProductAndSum(int n) {
        return sub(n);
    }
    static int sub(int n){
        int s=0;
        int p =1;
        while(n>0){
           int r=n%10;
            s=s+r;
            p=p*r;
            n=n/10;
        }
        return p-s;
    }
}
