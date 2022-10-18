class Solution {
    public int[] twoSum(int[] nums, int target) {
        int n = nums.length;
        int[] ar = new int[2];
        for(int i =0;i<n-1;i++){
           for(int j =i+1;j<n;j++){
                if(nums[i]+nums[j]==target) {
                    ar[0]=i;
                    ar[1]=j;
                    break;
                    
                }
            }
        }
        
        return ar; 
    }
}
