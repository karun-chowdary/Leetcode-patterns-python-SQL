class Solution {
    public int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        int t = minutesToTest/minutesToDie;
        int i =0;
        while(Math.pow(t+1,i)<buckets){
            i++;
        }
        return i;
        
    }
}
