class Solution {
    public int findNumbers(int[] nums) {
        return find(nums);
       // return findCount(nums);
        
    }
    static int findCount(int[] nums) {
        int count = 0;
        for (int i :nums) {
            if (even(i)) {
                count++;
            }
        }
        return count;
    }
    static boolean even(int n){
        int noOfDigits = digits(n);
        return noOfDigits%2==0;
    }
    static int digits(int n){
        if(n<0) n=n*-1;
        if(n==0) return 1;
        int count =0;
        while(n>0){
            count++;
            n/=10;
        }
        return count;
    }
    static int find(int[] nums) {
        int count = 0;
        for (int i :nums) {
            if (digits2(i)%2==0) {
                count++;
            }
        }
        return count;
    }
    static int digits2(int n){
        if(n<0) n*=-1;
        return (int)(Math.log10(n)+1);
    }

}
