class Node
	attr_accessor :parent, :l_child, :r_child, :value

	def initialize(value, parent)
		@value = value
		@parent = parent
		@l_child = nil
		@r_child = nil
	end

	def children
		# returns all non-nil child nodes as an array
		result = []
		result << @l_child if !@l_child.nil?
		result << @r_child if !@r_child.nil?
		result
	end

	def to_s
		left_val = @l_child.nil? ? nil : @l_child.value
		right_val = @r_child.nil? ? nil : @r_child.value
		parent_val = @parent.nil? ? nil : @parent.value
		"Value := #{@value}  Left:= #{left_val}  Right:= #{right_val}  Parent:=#{parent_val}"
	end
end

def build_tree_rec(data, parent=nil) # recursive builder, assumes sorted data
	dlen = data.length
	if dlen <= 0
		return nil
	elsif dlen == 1
		new_node = Node.new(data[0], parent)
		return new_node
	elsif dlen == 2
		value = data[0]
		new_node = Node.new(value, parent)
		new_node.r_child = build_tree(data[1..-1], new_node)
	else
		mid = dlen / 2
		left = data[0..mid-1]
		value = data[mid]
		right = data[mid+1 .. -1]
		new_node = Node.new(value, parent)
		new_node.l_child = build_tree(left, new_node)
		new_node.r_child = build_tree(right, new_node)
		return new_node
	end
end

def build_tree(data) # iterative, no assumptions
	root = Node.new(data[0],nil)
	data[1..-1].each do |value|
		node = root
		duplicate = false
		while !node.nil? do
			if node.value == value
				duplicate = true
				break
			else
				parent = node
				value > node.value ? node = node.r_child : node = node.l_child
			end
		end
		if !duplicate
			new_node = Node.new(value, parent)
			value > parent.value ? parent.r_child = new_node : parent.l_child = new_node
		end
	end
	root
end

def make_array(length)
	# returns an array of given length containing random integers
	result = []
	length.times {result << rand(99)}
	result
end


def check_children(target, node, visited, node_list)
	# used for breadth first traversal
	target_found = false
	result = nil
	child_list = node.children
	unvisited_children = child_list.select {|child| !visited.include?(child)}
	unvisited_children.each do |child|
		if child.value == target
			target_found = true
			result = child
		end
		visited << child
		node_list.unshift(child)
	end
	return target_found, result
end

def breadth_first_search(root, target)
	if root.nil?
		return nil
	elsif root.value == target
		return root
	else
		current_node = root
		visited = []
		queue = []
		target_found = false
		search_done = false
		result = nil
		while !target_found && !search_done do
			target_found, result = check_children(target, current_node, visited, queue)
			if target_found
				break
			end
			if queue.length == 0
				search_done = true
			else
				current_node = queue.pop
			end
		end
		result
	end
end

def depth_first_search(root, target)
	# iterative depth first search
	if root.nil?
		return nil
	elsif root.value == target
		return root
	else
		stack = []
		visited = []
		visited << root
		stack.push(root)
		found = false
		search_done = false
		result = nil
		while !found && !search_done do
			current_node = stack[-1]
			if current_node.value == target
				result = current_node
				found = true
				break
			end
			child_list = current_node.children
			unvisited_children = child_list.select {|child| !visited.include?(child)}
			if unvisited_children.length > 0
				next_node = unvisited_children[0]
			else
				next_node = nil
			end

			if next_node.nil? # no suitable children
				stack.pop
			else
				visited << next_node
				stack.push(next_node)
			end
			
			if stack.length <= 0
				search_done = true
				break
			end
		end
		result
	end
end

def dfs_rec(node, target, visited = [])
	# recursive depth first search
	if node.value == target
		return node
	else
		visited << node
		child_list = node.children
		unvisited_children = child_list.select {|child| !visited.include?(child)}
		if unvisited_children.length > 0
			dfs_rec(unvisited_children[0],target,visited)
		elsif !node.parent.nil?    # reached bottom, backtrack
			dfs_rec(node.parent,target,visited)
		end
	end
end

def print_array(inarray)
	inarray.each do |item|
		print "#{item} "
	end
	puts
end

def new_tree
	print "Enter a positive non-zero length for a test array: "
	n = gets.chomp.to_i
	test = make_array(n)
	print_array(test)
	root = build_tree(test)
	return test, root
end

test, root = new_tree

quit = false
while !quit do
	print "Enter d for depth first search, b for breadth first, n for new tree, p to print array, q to quit: "
	cmd = gets.chomp
	case cmd
	when "q"
		quit = true
	when "d"
		print "Enter target value: "
		target = gets.chomp.to_i
		result = dfs_rec(root,target)
		puts result
	when "b"
		print "Enter target value: "
		target = gets.chomp.to_i
		result = breadth_first_search(root, target)
		puts result
	when "p"
		print_array(test)
	when "n"
		test,root = new_tree
	else
		puts "I'm afraid I don't understand :-("
	end
end

