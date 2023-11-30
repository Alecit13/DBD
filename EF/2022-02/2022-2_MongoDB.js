/*Establecer una regla de validación
utilizando JSON Schema para una colección de documentos que representen
el detalle por alojamiento de acuerdo con las pantallas mostradas.*/
use Airbnb
db.createCollection('apartamento',{
validator:{
$jsonSchema: {
bsonType: 'object',
required: ['foto','nombre','monto','ciudad','calificacion','arrendadora','descripcion','servicios_principales','reseñas_importantes', 'arrendadoradetalle'],
properties:{
foto:{
bsonType: 'string'
},
nombre:{
bsonType: 'string'
},
monto:{
bsonType: 'int'
},
ciudad:{
bsonType:'string'
},
calificacion:{
bsonType:'double'
},
arrendadora:{
bsonType:'object',
required:['foto','nombre'],
properties:{
foto:{
bsonType:'string'
},
nombre:{
bsonType:'string'
},
}
},
descripcion:{
bsonType:'object',
required:['huespedes','habitaciones','camas','banos'],
properties:{
huespedes:{ bsonType:'int'},
habitaciones:{bsonType:'int'},
camas:{bsonType:'int'},
banos:{bsonType:'int'}
}
},
serviciosprincipales:{
bsonType:'array',
items:{
bsonType:'object',
required: ['id','nombre','foto'],
properties:{
id:{bsonType:'int'},
nombre:{bsonType:'string'},
foto:{bsonType:'string'}
}
}
},
resenasprincipales:{
bsonType:'array',
items:{
bsonType:'object',
required:['id','autor','calificacion','texto'],
properties:{
id:{bsonType:'int'},
autor:{bsonType:'string'},
calificacion:{bsonType:'int'},
texto:{bsonType:'string'}
}
}
}

}
}
}
})

db.createCollection('servicios',{
    validator:{
        $jsonSchema:{
            bsonType:'object',
            required:['id','nombre','foto'],
            properties:{
            id:{bsonType:'int'},
            nombre:{bsonType:'string'},
            foto:{bsonType:'string'}
            }
        }
    }

})

db.createCollection('resenas',{
    validator:{
        $jsonSchema:{
        bsonType: 'object',
        required:['id','autor','calificacion','texto','fecha'],
        properties:{
        id:{bsonType:'int'},
        autor:{bsonType:'string'},
        calificacion:{bsonType:'int'},
        texto:{bsonType: 'string'},
        fecha:{bsonType: 'date'}
        }
        }
    }
})

db.createCollection('anfitriondetalle',{
    validator:{
        $jsonSchema:{
        bsonType:'object',
        required:['nombre','fecha_registro','foto','resenas','descripcion'],
        properties:{
        nombre:{bsonType:'string'},
        fecha_registro:{bsonType:'date'},
        foto:{bsonType:'string'},
        resenas:{bsonType:'int'},
        descripcion:{bsonType:'string'}
        }
        }
    }
})

db.createCollection('inspecciones',{
    validator:{
        $jsonSchema:{
        bsonType:'object',
        required:['address','business_name','certificate_number','date','id','result','sector']m
        properties:{
        address:{bsonType:'object',
            required:['city','number','street','zip'],
            properties:{
            city:{bsonType:'string'},
            number:{bsonType:'int'},
            street:{bsonType:'string'},
            zip:{bsonType:'int'}
            }
        },
        business_name:{bsonType:'string'},
        certificate_number:{bsonType:'int'},
        date:{bsonType:'date'},
        id:{bsonType:'int'},
        result:{bsonType:'string'},
        sector:{bsonType:'string'}
        }
        }
    }

})
/*Escribir una consulta que permita mostrar la cantidad de inspecciones realizadas por cada ciudad.*/

db.aggregate(
[{$group:{_ciudad:'$address.city',
count:{$sum:1}}},
{$sort:{'count':1}}
]
)
/*Escribir una consulta que permita mostrar la cantidad de inspecciones realizadas por cada resultado obtenido solo para la ciudad de NEW YORK.*/
db.aggregate(
[
{$match:{'$address.city':'NEW YORK'}},
{$group:{_id:'$result', _count:{$sum:1}}},
{$sort:{'_id':1}}
]
)