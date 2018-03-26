note
	description: "Summary description for {ARRAY_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_TEST

create
	make
feature
	imp : ARRAY[STRING]
feature -- Constructor
	make
		do
			create	imp.make_empty
		end
-----------------------------------------------------
feature
	insert_last (s : STRING)
		do
			imp.force (s, imp.count + 1)
			ensure
				item_added : 		imp.count = (old imp.count +1)
				others_uchanged:
					across
						 1 |..| (imp.count-1) as j
					all
						 imp[j.item] ~ (old imp.twin)[(j.item)]
					end
		end
----------------------------------------------------
feature
		get_at(i : INTEGER) : STRING
		require
			imp.valid_index (i)
		do
			Result :=	imp.item (i)
			ensure
				size_Unchanged : imp.count = old imp.count
		end
----------------------------------------------------
feature
		delete_at(i : INTEGER)

			require
				imp.valid_index (i)
				local
					old_imp : ARRAY[STRING]
			do
				create old_imp.make_empty
				old_imp := imp.twin
				-------------------
				imp.make_filled ("", 1, (old_imp.count-1))
				across
					1 |..| (i-1) as j
				loop
					imp[j.item] := old_imp[j.item]
				end
				across
					(i)|..| (old_imp.count-1) as k
				loop
					imp[k.item] := old_imp[k.item+1]
				end
			ensure
				size_changed : imp.count = (old imp.count - 1)
				left_half_same :
					across
						1 |..| (i-1) as j
					all
						imp[j.item] ~ (old imp.twin)[j.item]
					end
				right_half_same :
					across
						(i+1) |..| imp.count  as j
					all
						imp[j.item] ~ (old imp.twin)[j.item + 1]
					end
			end
----------------------------------------------------
feature
	assign_at (i: INTEGER; s: STRING)
			-- Change the value at position 'i' to 's'.
		require
			imp.valid_index(i)
		do
				imp[i] := s
		ensure
			size_unchanged: imp.count = (old imp.twin).count
			item_assigned: imp [i] ~ s
			others_unchanged:
				across
					1 |..| imp.count as j
				all
					j.item /= i implies imp [j.item] ~ (old imp.twin) [j.item]
				end
		end
----------------------------------------------------
feature
		insert_at(i : INTEGER; s : STRING)
			require
				imp.valid_index (i)
				local
					old_imp : ARRAY[STRING]
				do

					old_imp := imp.twin
				    imp.make_filled ("", 1, (old_imp.count+1))
					across
						1|..| (i-1) as j
					loop
						imp[j.item] := old_imp[j.item]
					end
					imp[i] := s
					across
						(i+1) |..| imp.count as j
					loop
						imp[j.item] := old_imp[(j.item)-1]
					end
				ensure
						size_changed : imp.count = (old imp.count +1)
						left_half_the_same:
							across
								1|..| (i-1) as j
							all
								imp[j.item] ~ (old imp.twin)[j.item]
							end
						 right_half_the_same: 						-- Your task
								across
									(i+1) |..| imp.count as j
									all
										imp [j.item] ~  (old imp.twin) [(j).item -1 ]
								end
				end
----------------------------------------------------

end
