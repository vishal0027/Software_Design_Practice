note
	description: "Summary description for {CONTAIN}."
	author: "vishal"
	date: "$Date$"
	revision: "$Revision$"
	
class
	CONTAIN
create
	make
-----------------------------------------------------------------------------
feature{NONE} --atrributes
	imp 	: ARRAY[STRING]
	count 	: INTEGER
-----------------------------------------------------------------------------
feature -- Intialization
	make
		do
			create imp.make_empty
		ensure
			empty_imp : imp.is_empty
		end
-----------------------------------------------------------------------------
feature -- COMMANDS
	assign_at (i : INTEGER; s : STRING)

		require
			valid_index : valid_index(i)
		do
			imp[i] := s
		ensure
			element_added_at_pos : (imp[i] ~ s)
		end
-----------------------------------------------------------------------------
	insert_last (s : STRING)
		require
			size_less : size_check(s)
		do
			imp.force (s,imp.count+1)
		end
-----------------------------------------------------------------------------
	remove_first
		require

		do
			remove(1)
		ensure
			size_changed 	: imp.count = (old imp.count - 1)
			other_unchaged 	:
				across
					1|..| (old imp.count - 1) as j
				all
					imp[j.item]	~ (old imp.twin)[j.item + 1]
				end
		end
-----------------------------------------------------------------------------
	remove (i : INTEGER)
		local
			temp : ARRAY[STRING]
		do
			temp := imp.deep_twin
			imp.make_empty
			across
				1 |..| (i-1) as j
			loop
				imp.force (temp.item(j.item), j.item)
			end
			across
				i |..| (temp.count -1) as j
			loop
				imp.force (temp.item(j.item + 1), j.item)
			end
		ensure
			size_changed 		: imp.count = (old imp.count - 1)
			left_unchanged 		:
				across
					1 |..| (i-1) as j
				all
					imp[j.item] ~ ( old imp.twin )[j.item]
				end
			right_unchanged 		:
				across
					i|..| (old imp.count - 1) as j
				all
					imp[j.item] ~ (old imp.twin)[j.item + 1]
				end
		end
-----------------------------------------------------------------------------
feature -- Queries
	valid_index (i: INTEGER) : BOOLEAN
		do
			Result := imp.valid_index (i)
		end
-----------------------------------------------------------------------------
	get_at (i : INTEGER) : STRING
		require
			valid_index : valid_index(i)
		do
			Result := imp.item (i)
		end
-----------------------------------------------------------------------------
	shift_to_right
		local
			temp : ARRAY[STRING]
			hold : STRING
		do
			temp := imp.deep_twin
			create imp.make_empty
			hold := temp[1]
			across
				1|..| (temp.count -1 ) as j
			loop
				imp.force (temp[j.item + 1], j.item)
			end
			imp.force (hold, imp.count+1)
		end
-----------------------------------------------------------------------------
	size_check( s : STRING) : BOOLEAN
		do
			if imp.count = 0 then
				Result := true
			else
				Result := (s.count < imp.item (imp.count).count)
			end
		end
-----------------------------------------------------------------------------
end
