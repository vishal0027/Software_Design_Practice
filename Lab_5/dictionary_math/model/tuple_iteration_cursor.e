note
	description: "Summary description for {TUPLE_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ITERATION_CURSOR[V,K]
inherit
	ITERATION_CURSOR[TUPLE[V,K]]
create
	make
feature -- Constructor
	make (sa : ARRAY[V]; key : LINKED_LIST[K] )
		-- Initailizes the cursor from one Array and onr Linked List
		do
			genric_v := sa
			genric_k := key
			cursor_pos := genric_v.lower
		end

feature -- Cursor Opertions
	item: TUPLE[V,K]
		local
			value : V
			key_id: K
		do
			value  := genric_v[cursor_pos]
			key_id := genric_k.at (cursor_pos)
			create Result
			Result := [value, key_id]
		end
	after: BOOLEAN
		do
			Result := (cursor_pos > genric_v.upper)
		end
	forth
		do
			cursor_pos := cursor_pos +1
		end

feature {NONE} -- Underlying lists
		genric_v : ARRAY[V]
		genric_k : LINKED_LIST[K]
		cursor_pos: INTEGER
invariant
	consistance_List :
		genric_v.count = genric_k.count
end

