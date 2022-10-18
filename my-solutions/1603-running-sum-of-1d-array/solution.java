class Solution {
    public int[] runningSum(int[] nums) {
        int[] ar = new int[nums.length];
         
        for(int i =nums.length-1;i>=0;i--){
            ar[i]=sum(nums,i);
        }
        return ar;
    }
    int sum(int[] arr,int n){
        
        if(n==0) return arr[0];
        return arr[n]+sum(arr,n-1);
    }
}
