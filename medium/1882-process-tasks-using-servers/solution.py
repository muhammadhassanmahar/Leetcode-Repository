import heapq

class Solution:
    def assignTasks(self, servers: list[int], tasks: list[int]) -> list[int]:
        n = len(servers)
        m = len(tasks)
        
        # Min-heap for free servers: stores (weight, index)
        free_servers = [(servers[i], i) for i in range(n)]
        heapq.heapify(free_servers)
        
        # Min-heap for busy servers: stores (free_time, weight, index)
        busy_servers = []
        
        ans = [0] * m
        current_time = 0
        
        for j, duration in enumerate(tasks):
            current_time = max(current_time, j)
            
            # Release all servers that become free by current_time
            while busy_servers and busy_servers[0][0] <= current_time:
                free_time, weight, index = heapq.heappop(busy_servers)
                heapq.heappush(free_servers, (weight, index))
                
            # If no free servers are available, jump time to the next server's free time
            if not free_servers:
                current_time = busy_servers[0][0]
                while busy_servers and busy_servers[0][0] <= current_time:
                    free_time, weight, index = heapq.heappop(busy_servers)
                    heapq.heappush(free_servers, (weight, index))
                    
            # Assign the task to the best available server
            weight, index = heapq.heappop(free_servers)
            ans[j] = index
            
            # Push the server into the busy heap with its updated release time
            heapq.heappush(busy_servers, (current_time + duration, weight, index))
            
        return ans