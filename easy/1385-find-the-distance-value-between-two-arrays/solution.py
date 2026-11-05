class Solution:
    def findTheDistanceValue(self, arr1: List[int], arr2: List[int], d: int) -> int:
        distance_value = 0
        
        for x in arr1:
            valid = True
            for y in arr2:
                if abs(x - y) <= d:
                    valid = False
                    break # Agar aik bhi condition match ho jaye toh mazeed check karne ki zaroorat nahi
            if valid:
                distance_value += 1
                
        return distance_value