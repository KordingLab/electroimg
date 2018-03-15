INPUT file Format for Subtracts

The elements are ordered as follows

First column:
[0,1] is this the origin subtrack meaning that it describes the soma as its first and only detection.  (0 for NO, 1 for YES)

Second column:
[0,1] can there be a split FOLLOWING this subtrack.  This should not generally be zero


Third column:
[0,1] can this subtrack terminate a branch.  I prefer this to be more commonly zero.  

Fourth column:
Real valued cost associated with the subtrack.  This describes the cost associated with including this subtrack in the tree.  

Fifth column to end (if the length of subtract is 2 then we have 6 column):
indexes associated with subtrack ordered in time from earliest (left) to latest (right).  No two detections can occur at the same time but they may be separated by arbitrary amounts of time. 

The index of detections should be ordered in time from earliest to latest.  Lets assume that for now subtracks are of length 3.  Then the origin subtract has -1 -1 ,0.  -1 indicates the empty detection.  

Subtracks that can succeed the origin subtrack would have -1 0, x for some x unique for each of possible successors. An arbitrary subtrack made up of (x1,x2,x3) can be succeeded by any subtract any subtrack of the format (x2,x3,x4).  


Note that every ordered sequence of three detections in time is not a subtrack.  Only reasonable scoring ones should be provided to me.  For the initial file I expect all subtracks to be on length 2 as we discussed on the phone. 
