note
	description: "A linear container implemented via an array."
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_CONTAINER

create
	make

feature {NONE} -- Implementation of container via an array

	imp : ARRAY[STRING]


feature -- Constructors

	make
			-- Initialize an empty container.
		do
			-- This implementation is correct, just given to you.
			create {ARRAY[STRING]} imp.make_empty

		ensure
			empty_container: count = 0 -- Your task
		end


feature -- Commands
------------------------------------------------------------------
	assign_at (i: INTEGER; s: STRING)
			-- Change the value at position 'i' to 's'.
		require
			valid_index: valid_index(i)
		do
				imp[i] := s
		ensure
			size_unchanged: count = (old imp.twin).count
			item_assigned: imp [i] ~ s
			others_unchanged:
				across
					1 |..| imp.count as j
				all
					j.item /= i implies imp [j.item] ~ (old imp.deep_twin) [j.item]
				end
		end
------------------------------------------------------------------
	insert_at (i: INTEGER; s: STRING)
			-- Insert value 's' into index 'i'.
		require
			valid_index: valid_index(i) 
			local
				old_imp : ARRAY[STRING]
				temp_count: INTEGER
				tempS:STRING
		do
			-- Your task
			-- We have to write a loop to copy every item to
			-- new array with inserted new element at position. Then add
			-- everything back to previous array.
		    create old_imp.make_filled ("",1,(imp.count+1))
			temp_count:= imp.count
			across
				 1|..| (i-1) as k
			loop
			     old_imp[k.item]:= imp[(k).item]
			end
			old_imp.force (s, i)
			across
				 (i)|..| (temp_count) as k
			loop

				old_imp[(k.item)+1] := (imp[(k).item])
			end
			imp.make_filled("",1,old_imp.count)
			across
						 (1)|..| (old_imp.count) as k
					loop
						imp.force (old_imp[(k).item], (k).item)
					end

		ensure
			size_changed: imp.count = (old imp.count +1)   -- Your task
			inserted_at_i:imp.entry (i) ~ s             -- Your task
			left_half_the_same: 						   -- Your task
			across
							1 |..| (i-1) as j
						all
							imp [j.item] ~  (old imp.twin) [j.item]
						end
			right_half_the_same: 						-- Your task
			across
									(i+1) |..| imp.count as j
								all
									imp [j.item] ~  (old imp.twin) [(j).item -1 ]
								end
		end
------------------------------------------------------------------
	delete_at (i: INTEGER)
			-- Delete element stored at index 'i'.
		require
			valid_index: valid_index(i) -- Your task	local
		local
					old_imp : ARRAY[STRING]
		do
			old_imp := imp.twin
			imp.make_filled ("", 1, (old_imp.count-1))
		across
				1 |..| (i-1) as j
			loop
						 imp[(j).item] := old_imp[(j).item]
			end
		across
					i |..| (old_imp.count-1) as j
				loop
							 imp[(j).item] := old_imp[(j).item+1]
				end

		ensure
			size_changed: imp.count = (old imp.count -1) -- Your task
			left_half_the_same:
			 	across
							1 |..| (i-1) as j
						all
							imp [j.item] ~  (old imp.twin) [j.item]
						end
			right_half_the_same:  -- Your task
			across
				(i+1) |..| (imp.count) as j
					all
							imp [j.item] ~  (old imp.twin) [(j).item +1 ]
					end
			end
------------------------------------------------------------------

	insert_last (s: STRING)
			-- Insert 's' as the last element of the container.

		do
			imp.force (s, (count+1))-- Your task
		ensure
			size_changed: imp.count = (old imp.count + 1) -- Your task
			last_inserted: imp[imp.count] ~ s -- Your task  -- I forget to fo these!! :-(
			others_unchanged: -- Your task
			across
						1 |..| (imp.count-1) as j
					all
						 imp [j.item] ~ (old imp.deep_twin) [j.item]
					end
		end

------------------------------------------------------------------
	remove_first
			-- Remove first element from the container.
		require
			not_empty: count >= 1
			local
					old_imp : ARRAY[STRING]
		do
			old_imp := imp.deep_twin
			imp.make_filled ("", 1, (old_imp.count-1))
		across
				2 |..| count as j
			loop
						 imp[(j).item-1] := old_imp[(j).item]
			end

		ensure
			size_changed: imp.count =( old imp.count)-1
			others_unchanged:
			across
					1 |..| (imp.count -1) as j
				all
					 imp [j.item] ~ (old imp.twin) [j.item+1]
				end
		end
------------------------------------------------------------------


feature -- Queries

	count: INTEGER -- Your task
		do
			result:= imp.count
		end
	  -- Number of items currently stored in the container.
      -- It is up to you to either implement 'count' as an attribute,
      -- or to implement 'count' as a query (uniform access principle).
------------------------------------------------------------------
	valid_index (i: INTEGER): BOOLEAN
			-- Is 'i' a valid index of current container?
		do
			result := 1 <= i and i <= count
		ensure
			size_unchanged: imp.count = old imp.count
			result_correct: result ~ imp.valid_index (i)
 			no_elements_changed:
						across
							1 |..| imp.count as j
						all
							imp [j.item] ~  (old imp.twin) [j.item]
						end
		end
------------------------------------------------------------------
	get_at (i: INTEGER): STRING
			-- Return the element stored at index 'i'.
		require
			valid_index: valid_index(i)
		do
			Result := imp[i]
		ensure
			size_unchanged:  imp.count =	old imp.count
			result_correct: imp[i] ~  result
			no_elements_changed:
						across
									1 |..| imp.count as j
								all
									imp [j.item] ~  (old imp.twin) [j.item]
								end
		end
------------------------------------------------------------------

invariant
	-- Size of container and size of implementation array always match.
	consistency: imp.count = count
end
