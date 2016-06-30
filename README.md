# Binary tree

Odin Project : Ruby Programming : Data Structures

The methods #build_tree and #build_tree_rec construct a tree of Nodes from an input array.

The #build_tree_rec method assumes that the array is sorted and builds the left and right trees recursively

The #build_tree method does not assume a sorted array, and builds the tree iteratively.

Duplicate values are discarded.

The #bread_first_search method searches the tree for a target value, using BFS.  The key processing is in #check_children.

The #depth_first_search method does a DFS non-recursively, using a separate stack

The #dfs_rec method also does DFS, this time recursively.

Node includes 2 convenience methods, #children and #to_s.  #children returns all the non-nil child nodes in an array

The other methods - #make_array, #print_array, #new_tree are just to simplify testing