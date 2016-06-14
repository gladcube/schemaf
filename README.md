## Usage

#### apply
Apply the "schema" (defined object keys and value types) to the any other object.
When the schema is applied, the object's keys that don't exists in the schema are deleted, and value types are casted to defined types.


```livescript
# define a schema
shema_human =
    name           : string
    age            : number
    birthday       : date
    is_married     : boolean
    favorite_foods : array

# apply the schema
impl_human =
    name           : \test
    age            : "24"
    birthday       : "1989/12/01"
    is_married     : "ok"
    favorite_foods : ["egg", "fish"]
    is_flyable     : "maybe"

applied_human = impl_human |> apply shema_human
#applied_human=>
#{ name: 'test',
#  age: 24,
#  birthday: Fri Dec 01 1989 00:00:00 GMT+0900 (JST),
#  is_married: true,
#  favorite_foods: [ 'egg', 'fish' ] }
```
