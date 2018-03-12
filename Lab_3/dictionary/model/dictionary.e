note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	DICTIONARY[V, K]

inherit
	ITERABLE[TUPLE[V,K]]
create
	make

feature {INSTRUCTOR_DICTIONARY_TESTS} -- Do not modify this export status!  ----(CHANGE BACK TO INSTRUCTOR_DICTIONARY_TESTS)
	-- You are required to implement all dictionary features using these two attributes.
	values: ARRAY[V]
	keys: LINKED_LIST[K]
--------------------------------------------------------------------------------------------------------------
feature -- Feature(s) required by ITERABLE
	-- Your Task
	-- See test_iterable_dictionary and test_iteration_cursor in INSTRUCTOR_DICTIONARY_TESTS.
	-- As soon as you make the current class iterable,
	-- define the necessary feature(s) here.
	new_cursor : ITERATION_CURSOR[TUPLE[V,K]]

	------------One Way To Do it---------------
	--	local
	--		cursor : TUPLE_ITERATION_CURSOR[V,K]
	--	do
	--		create cursor.make (values, keys)
	--		Result := cursor
	-----------Other Way to Do it--------------	
		do
			create {TUPLE_ITERATION_CURSOR[V,K]} Result.make (values, keys)
		end


--------------------------------------------------------------------------------------------------------------
feature -- Alternative Iteration Cursor
	-- Your Task
	-- See test_another_cursor in INSTRUCTOR_DICTIONARY_TESTS.
	-- A feature another_cursor is expected to be defined here.

	another_cursor : ITERATION_CURSOR[ENTRY[V,K]]

	------------One Way To Do it---------------
	--	local
	--		cursor : ENTRY_ITERATION_CURSOR[V,K]
	--	do
	--		create cursor.make (values, keys)
	--		Result := cursor
	-----------Other Way to Do it--------------	
		do
			create {ENTRY_ITERATION_CURSOR[V,K]} Result.make (values, keys)
		end
--------------------------------------------------------------------------------------------------------------
feature -- Constructor
	make
			-- Initialize an empty dictionary.
		do
			create  values.make_empty
			create  keys.make
			keys.compare_objects
			values.compare_objects
		ensure
			empty_dictionary: values.is_empty and keys.is_empty
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values:
				values.object_comparison
		end
--------------------------------------------------------------------------------------------------------------
feature -- Commands

	add_entry (v: V; k: K)
			-- Add a new entry with key 'k' and value 'v'.
			-- It is required that 'k' is not an existing search key in the dictionary.
		require
			non_existing_key: not exists(k)

		do
			values.force (v, values.count+1)
			keys.force (k)
		ensure
			entry_added:  (get_value(k) ~ v)
				-- Hint: In the new dictionary, the associated value of 'k' is 'v'
		end
--------------------------------------------------------------------------------------------------------------
	remove_entry (k: K)
			-- Remove the corresponding entry whose search key is 'k'.
			-- It is required that 'k' is an existing search key in the dictionary.
		require
			existing_key: exists(k) -- Your Task
		local
					old_value : ARRAY[V]
					i : INTEGER
		do
			from
				keys.start
			until
				keys.exhausted
			loop
				 if (keys.item ~ k) then
				 	i :=  keys.index
				 	keys.remove
				 end
				 keys.forth
			end
			old_value := values.twin
			values.make_empty
			across
					1 |..| (i-1) as j
				loop
						 values.force (old_value[(j).item],(j).item)
				end
			across
					i |..| (old_value.count-1) as j
				loop
							 values.force (old_value[(j).item+1],((j).item))
				end

			ensure
				dictionary_count_decremented: count = (old count - 1)
				key_removed: not exists(k)
		end
--------------------------------------------------------------------------------------------------------------
feature -- Queries
	count: INTEGER
			-- Number of entries in the dictionary.
		do
			Result := keys.count
		ensure
			correct_result: values.count = keys.count
		end
--------------------------------------------------------------------------------------------------------------
	exists (k: K): BOOLEAN
			-- Does key 'k' exist in the dictionary?
		do
			Result :=	keys.has (k)

		ensure
			correct_result: Result = keys.has (k)
		end

--------------------------------------------------------------------------------------------------------------
	get_keys (v: V): ITERABLE[K]
			-- Return an iterable collection of keys that are associated with value 'v'.
		-- Hint: Refere to the architecture BON diagram of the Iterator Pattern, to see
			-- what classes can be used to instantiate objects that are iterable.
		local
			id : ARRAY[K]

		do
			create id.make_empty

			across
				1|..| values.count as j
			loop
				if v ~ values[j.item] then
				id.force (keys.at (j.item), id.count+1)

				end
			end
			Result := id
		ensure
			correct_result:
			across
				Result as j
			all
					get_value(j.item) ~ v
			end

				 -- Your Task
				-- Hint: Since Result is iterable, go accross it and make sure
				-- that every key in that iterable collection has its corresponding
				-- value equal to 'v'. Remember that in this naive implementation
				-- strategy, an existing key and its associated value have the same index.
		end
--------------------------------------------------------------------------------------------------------------
	get_value (k: K): detachable V
			-- Return the assocated value of search key 'k' if it exists.
			-- Void if 'k' does not exist.
			-- Declaring "detachable" besides the return type here indicates that
			-- the return value might be void (i.e., null).
		do
			from
				keys.start
			until
				keys.exhausted
			loop
				 if (keys.item ~ k) then
				 	Result := values[keys.index]
				 end
				 keys.forth
			end

			ensure
			case_of_void_result: (not exists(k) implies Result = Void)
			case_of_non_void_result:
			across
				1|..| keys.count as j
			all
					(keys.at (j.item) ~ k) implies values[j.item] ~ Result
			end
		end
--------------------------------------------------------------------------------------------------------------
invariant
	consistent_counts_of_keys_and_values:
		keys.count = values.count
	consistent_counts_of_imp_and_adt:
		keys.count = count
end
