{throws, does-not-throw, equal, not-equal, deep-equal} = require \assert
{apply: _apply, string: _string, number: _number, array: _array, boolean: _boolean, date: _date, mongo_object_id: _mongo_object_id} = require \../../lib/index.ls

module.exports = new class SchemafAssertion
  apply:
    (apply)->
      shema_human =
          name           : _string
          age            : _number
          sub_name       : _string
          birthday       : _date
          is_married     : _boolean
          favorite_foods : _array
      impl_human_1 =
          name           : /^hogehoge/
          age            : "aaa"
          birthday       : "19791109"
          is_married     : no
          favorite_foods : \bread
          is_flyable     : true
      impl_human_1 |> apply shema_human
      |> $$ [
        (get \name) >> (equal _, "/^hogehoge/")
        (get \sub_name) >> (equal _, "undefined")
        (get \age) >> (isNaN _) >> (equal _, true)
        (get \birthday) >> (let_ _, \toString) >> (equal _, "Invalid Date" )
        (get \is_married) >> (equal _, false)
        (get \favorite_foods) >> (deep-equal _, [])
        (get \is_flyable) >> (equal _, undefined)
      ]
    (apply)->
      shema_human =
          name           : _string
          age            : _number
          birthday       : _date
          is_married     : _boolean
          favorite_foods : _array
          mongo_id: _mongo_object_id
      impl_human_2 =
          name           : 123456
          age            : "123"
          birthday       : "1929/12/01"
          is_married     : "yes"
          favorite_foods : ["foods", 22]
          is_flyable     : "maybe"
      impl_human_2 |> _apply shema_human
      |> $$ [
        (get \name) >> (equal _, "123456")
        (get \age) >> (equal _, 123)
        (get \birthday)  >>  (let_ _, \toString) >> (equal _, "Sun Dec 01 1929 00:00:00 GMT+0900 (JST)")
        (get \is_married) >> (equal _, true)
        (get \favorite_foods) >> (deep-equal _, ["foods", 22])
        (get \is_flyable) >> (equal _, undefined)
        (get \mongo_id) >> (not-equal _, false)
      ]
  #getters:
    #(getters)->
    #  shema_human =
    #      name           : _string
    #      age            : _number
    #      birthday       : _date
    #      is_married     : _boolean
    #      favorite_foods : _array
    #  impl_human =
    #      name           : "name"
    #      age            : "123"
    #      birthday       : 19291201
    #      is_married     : "yes"
    #      favorite_foods : ["foods", 22]
    #  impl_human
    #  |> _apply shema_human
    #  |> getters
  string:
    (string)->
      equal typeof string!, \string
  number:
    (number)->
      equal typeof number!, \number
  array:
    (array)->
      undefined |> array >> length >> (equal _, 0)
    (array)->
      <[lorem]> |> array >> length >> (equal _, 1)
    (array)->
      \lorem |> array >> length >> (equal _, 0)
  boolean:
    (boolean)->
      equal typeof boolean!, \boolean
  date:
    (date)->
      equal typeof date!, \object
  mongo_object_id:
    (mongo_object_id)->
      mongo_object_id!
      |> (not-equal _, false)
