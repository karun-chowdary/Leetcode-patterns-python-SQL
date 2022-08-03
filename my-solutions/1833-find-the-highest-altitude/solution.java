class Solution {
    public int largestAltitude(int[] gain) {
        return highestAltitude(gain);
        
    }
    
    
    
    static int highestAltitude(int[] gain){
        int[] a = new int[gain.length+1];
        a[0]=0;
        for(int i=1;i<gain.length+1;i++){
            a[i]=gain[i-1]+a[i-1];
        }
        /*int start = 0;
        int end = a.length-1;
        while(start<end){
            int mid = start+(end - start)/2;
            if(a[mid]>a[mid+1]) end = mid;
            else start = mid+1;
            }
        return a[start];*/
        int max = a[0];
        for (int i : a) if(i>max) max = i;
        return max;
    }
}
