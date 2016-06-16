## Usage

#### apply
Apply the "schema" (the object that has keys and "Caster" objects as value) to the any other object.
When the schema is applied, the object's keys that don't exists in the schema will be deleted, and value's type will be casted to the type that defined with "Caster".
This will let the object values valid on MongoDB.

#####Casters
* string
* number
* date
* boolean
* array
* mongo_object_id

```livescript

# define a schema
shema_human =
    name           : string
    age            : number
    birthday       : date
    is_married     : boolean
    favorite_foods : array
    obj_id         : mongo_object_id

# apply the schema
impl_human =
    name           : \test
    age            : "24"
    birthday       : "1989/12/01"
    is_married     : "ok"
    favorite_foods : ["egg", "fish"]
    is_flyable     : "maybe"
    obj_id         : mongo_object_id
applied_human = impl_human |> apply shema_human
#applied_human=>
#{ name: 'test',
#  age: 24,
#  birthday: Fri Dec 01 1989 00:00:00 GMT+0900 (JST),
#  is_married: true,
#  favorite_foods: [ 'egg', 'fish' ] }
```

#### getters
Generate getters from schema.

```livescript
# define a schema
shema_human =
    name           : string
    age            : number
    birthday       : date
    is_married     : boolean
    favorite_foods : array

# generate getters from the schema
    shema_human |> getters

```
