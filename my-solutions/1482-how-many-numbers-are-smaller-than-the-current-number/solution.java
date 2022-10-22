class Solution {
    public int[] smallerNumbersThanCurrent(int[] nums) {
        int n = nums.length;
        int[] ar = new int[n];
        int c =0;
        for(int i=0;i<n;i++){
            for(int j =0;j<n;j++){
                if(nums[i]>nums[j]) c+=1;
            }
            ar[i]=c;
            c=0;
        } 
        return ar;
        
    }
}
