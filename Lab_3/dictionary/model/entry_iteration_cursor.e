note
	description: "Summary description for {ENTRY_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENTRY_ITERATION_CURSOR[V,K]
inherit
	ITERATION_CURSOR[ENTRY[V,K]]

create
	make

feature -- Constructor
	make (value : ARRAY[V]; keys : LINKED_LIST[K])
		do
			genric_value := value
			genric_key   := keys
			cursor_pos 	 := genric_value.lower
		end

feature -- Cursor Operations
	item: ENTRY[V,K]
		local
			temp_value	: V
			temp_key		: K
			e : ENTRY[V,K]
		do
			temp_value	:= genric_value[cursor_pos]
			temp_key		:= genric_key.at(cursor_pos)
			 create e.make(temp_value, temp_key)
			 Result := e
		end

	after : BOOLEAN
		do
			Result := (cursor_pos > genric_value.upper)
		end
	forth
		do
			cursor_pos := cursor_pos + 1
		end

feature -- Intialization

	genric_value  : ARRAY[V]
	genric_key	  : LINKED_LIST[K]
	cursor_pos 	  : INTEGER
invariant
	consistance_List :
		genric_value.count = genric_key.count
end
