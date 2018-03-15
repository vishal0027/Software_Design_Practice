note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	-- Constrained genericity because V and K will be used
	-- in the math model class FUN, which require both to be always
	-- attached for void safety.
	DICTIONARY[V -> attached ANY, K -> attached ANY]
inherit
	ITERABLE[TUPLE[V, K]]
create
	make

feature {NONE} -- Do not modify this export status!
	values: ARRAY[V]
	keys: LINKED_LIST[K]

feature -- Abstraction function
	model: FUN[K, V]	-- Do not modify the type of this query.
		           		-- Abstract the dictionary ADT as a mathematical function.
		do
			create Result.make_empty
			across
				1 |..| keys.count as i
			loop
				Result.extend (create {PAIR[K, V]}.make(keys.i_th (i.item), values.item (i.item)))
			end
		ensure
			consistent_model_imp_counts:
					(model.count = keys.count) and (model.count = values.count)
			consistent_model_imp_contents:
					across
						1 |..| keys.count as i
					all
						Result.has (create {PAIR[K, V]}.make(keys.i_th (i.item), values.item (i.item)))
					end
		end
----------------------------------------------------------------------------------------------------------------------------------
feature -- feature required by ITERABLE
	new_cursor: ITERATION_CURSOR[TUPLE[V, K]]
		do
			create {TUPLE_ITERATION_CURSOR[V,K]} Result.make (values, keys)
		end
----------------------------------------------------------------------------------------------------------------------------------
feature -- Constructor
	make
		do
			create  values.make_empty
			create  keys.make
			values.compare_objects
			keys.compare_objects

		ensure
			empty_model: ( model.count = 0 ) and model.is_empty
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values:
				values.object_comparison
		end
----------------------------------------------------------------------------------------------------------------------------------
feature -- Commands

	add_entry (v: V; k: K)
		require
			non_existing_in_model:  (not model.has (create {PAIR[K,V]}.make(k,v)))
		do
			values.force (v, values.count+1)
			keys.force (k)
		ensure
			entry_added_to_model:

				  model.has (create {PAIR[K,V]}.make(k,v)) and
				 (old model).extended (create {PAIR [K, V]}.make (k, v)) ~ model

		end
----------------------------------------------------------------------------------------------------------------------------------
	remove_entry (k: K)
		require
			existing_in_model:  model.domain.has (k)
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
			entry_removed_from_model: (not model.domain.has (k))
		end
----------------------------------------------------------------------------------------------------------------------------------
feature -- Queries

	count: INTEGER
		do
			Result := keys.count
		ensure
			correct_model_result: Result = model.count
		end
----------------------------------------------------------------------------------------------------------------------------------
	get_keys (v: V): ITERABLE[K]
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
			correct_model_result:
					 result ~ model.range_restricted_by (v).intersected(model).domain.as_array  -- NOT QUITE SURE--

				-- Your Task: Every key in the result has the right corresponding value in model
		end
----------------------------------------------------------------------------------------------------------------------------------
	get_value (k: K): detachable V
			-- Assocated value of 'k' if it exists.
			-- Void if 'k' does not exist.
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
			case_of_void_result: (result = void) implies not(model.domain.has (k))
				-- Your Task: void result means the key does not exist in model
			case_of_non_void_result: (result /= void) implies (model.domain.has (k))
				-- Your Task: void result means the key exists in model
		end
----------------------------------------------------------------------------------------------------------------------------------		
invariant
	consistent_keys_values_counts:
		keys.count = values.count
	consistent_imp_adt_counts:
		keys.count = count
end
