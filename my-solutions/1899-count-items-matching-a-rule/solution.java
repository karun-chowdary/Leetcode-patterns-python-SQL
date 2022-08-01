class Solution {
    public int countMatches(List<List<String>> items, String ruleKey, String ruleValue) {
      /* int j=0 ,c=0;
        if(ruleKey.equals("type")) 
            j = 0;
        if(ruleKey.equals("color")) 
            j = 1;
        if(ruleKey.equals("name")) 
            j = 2;
        for(int i =0;i<items.size();i++){
            if(items.get(i).get(j).equals(ruleValue)) c+=1;
        }
        return c;*/
        
        
        /*int c =0;
        for(int i =0;i<items.size();i++){
            if(ruleKey.equals("type")&&(items.get(i).get(0).equals(ruleValue))) c+=1;
            if(ruleKey.equals("color")&&(items.get(i).get(1).equals(ruleValue))) c+=1;
            if(ruleKey.equals("name")&&(items.get(i).get(2).equals(ruleValue))) c+=1;
        }
        return c;*/
       /* int type = 0;
        if (ruleKey.equals("color")) type = 1;
        else if (ruleKey.equals("name")) type = 2;
        int res = 0;
        for (List<String> i : items) {
            if (i.get(type).equals(ruleValue)) res++; 
        }
        return res;*/
        int n;
        int m=items.size();
        if(ruleKey.equals("type"))
            n=0;
        else if(ruleKey.equals("color"))
            n=1;
        else
            n=2;
        int count=0;
        for(int j=0;j<m;j++)
        {
            //System.out.print(items.get(j).get(n));
            if(items.get(j).get(n).equals(ruleValue)==true)
                count++;
        }
        return count;
    }
}
