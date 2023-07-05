func minLength(_ s: String) -> Int {
       var arr = Array(s)
       var index = 0;
       while( index + 1 < arr.count ){
            if((arr[index] == "A" && arr[index+1] == "B") ||
               (arr[index] == "C" && arr[index+1] == "D")){
                   arr.remove(at: index)
                   arr.remove(at: index)
                   index = 0
               } else {
                   index = index + 1
               }
       }
       return arr.count
   }
