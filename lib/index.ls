{args, need, $_at, withr, may, $$, $, get, except, new_, lazy, try_, return_} = require \glad-functions
{ObjectID} = require \mongodb

module.exports =
  apply: _apply = (schema, o)-->
    o
    |> obj-to-pairs
    |> map withr (
      ((is) `over` (at 0))
      >> (find _, (schema |> obj-to-pairs))
      >> (may tail)
    )
    |> map concat # [ [k, v, caster], ...]
    |> filter (at 2) >> (?)
    |> map $$ [
      at 0
      (tail >> ($_at 1, may) >> apply (|>))
    ]
    |> pairs-to-obj
  getters:
    keys
    >> (map (withr get))
    >> pairs-to-obj
  # Casters
  string: (or "") >> String
  number: Number
  array: need 2,
    args >> ($_at 1, except (?), return_ []) >> apply map
  object: _apply
  boolean: Boolean
  date: new_ Date, _
  mongo_object_id:
    (lazy ObjectID, _)
    >> (try_ _, return_ "")

