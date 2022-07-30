class Solution {
    public List<Boolean> kidsWithCandies(int[] candies, int extraCandies) {
        return candy(candies,extraCandies);
        
    }
    static List<Boolean> candy(int[] a,int c){
        int max = a[0];
        for (int i:a) if(i>max) max = i;
        List<Boolean> bool = new ArrayList<>();
        for(int i=0;i<a.length;i++){
            bool.add((a[i]+c)>=max); 
        }
        return bool;
        
    }
}
