class Solution {
    public int[] buildArray(int[] nums) {
       return  per(nums,nums.length);
        
        
    }
    static int[] per(int[] arr,int n){
         int[] ar = new int[n];
        for(int i =0;i<arr.length;i++){
            ar[i]=arr[arr[i]];
        }
        return ar;
    }
}
