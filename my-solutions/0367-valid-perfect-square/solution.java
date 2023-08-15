class Solution {
    public boolean isPerfectSquare(int n) {
        long start = 1;
        long end = n/2;
        if( n==1) return true;
        while(start<=end){
            long mid = start +(end - start)/2;
            if(mid*mid == n) return true;
            else if(mid*mid >n) end = mid-1;
            else start = mid+1;
        }
        return false;

    }
}
