{withr, may, $$, $, get, except, new_, lazy, try_, return_} = require \glad-functions
{ObjectID} = require \mongodb

module.exports =
  apply: (schema, o)-->
    schema
    |> obj-to-pairs
    |> map withr (
      ((is) `over` (at 0))
      >> (find _, (o |> obj-to-pairs))
      >> (may tail)
    )
    |> map concat # [ [k, caster, v], ...]
    |> map $$ [
      at 0
      (tail >> ($_at 0, may) >> apply $)
    ]
    |> pairs-to-obj
  getters:
    keys
    >> (map (withr get))
    >> pairs-to-obj
  # Casters
  string: (or "") >> String
  number: Number
  array: except (?), []
  boolean: Boolean
  date: new_ Date, _
  mongo_object_id:
    (lazy ObjectID, _)
    >> (try_ _, return_ "")

