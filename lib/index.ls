{withr, may, $$, $, get, except, new_, lazy, try_, return_, Obj: {let_}} = require \glad-functions
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
      (tail >> apply $)
    ]
    |> pairs-to-obj
  # Schema -> {Key:Getter}
  getters:
    keys
    >> (map (withr get))
    >> pairs-to-obj
  # Casters
  string: String
  number: Number
  array: except (let_ Array, \isArray ,_ ), return_ []
  boolean: Boolean
  date: new_ Date, _
  mongo_object_id:
    (lazy ObjectID, _)
    >> (try_ _, return_ "")
