{throws, does-not-throw, equal, deep-equal} = require \assert
{string: _string, number: _number, array: _array, boolean: _boolean, date: _date, mongo_object_id: _mongo_object_id} = require \../../lib/index.ls
module.exports = new class DomfAssertion
  apply:
    (apply)->
      shema_human =
          name           : _string
          age            : _number
          birthday       : _date
          is_married     : _boolean
          favorite_foods : _array
      impl_human_1 =
          name           : /^hogehoge/
          age            : "123"
          birthday       : 19291201
          is_married     : no
          favorite_foods : []
          is_flyable     : true
      impl_human_2 =
          name           : 123456
          age            : "123"
          birthday       : 19291201
          is_married     : "yes"
          favorite_foods : ["foods", 22]
          is_flyable     : "maybe"

      impl_human_1 |> apply shema_human
      |> deep-equal _, {
        name: "/^hogehoge/"
        age: 123
        birthday: new Date 19291201
        is_married: false
        favorite_foods: []
      }
      impl_human_2 |> apply shema_human
      |> deep-equal _, {
        name: "123456"
        age: 123
        birthday: new Date 19291201
        is_married: true
        favorite_foods: ["foods", 22]
      }

  getters:
    (getters)->
      shema_human =
          name           : _string
          age            : _number
          birthday       : _date
          is_married     : _boolean
          favorite_foods : _array
      impl_human =
          name           : "name"
          age            : "123"
          birthday       : 19291201
          is_married     : "yes"
          favorite_foods : ["foods", 22]
      #impl_human |> getters |> console~log

  string:
    (string)->
      equal typeof string!, \string
  number:
    (number)->
      equal typeof number!, \number
  array:
    (array)->

  boolean:
    (boolean)->
      equal typeof boolean!, \boolean
  date:
    (date)->
      equal typeof date!, \object
  mongo_object_id:
    (mongo_object_id)->
