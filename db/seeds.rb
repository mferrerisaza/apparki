# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ticket.destroy_all
ParkingZone.destroy_all
User.destroy_all
Vehicle.destroy_all

p "Empezando..."
p "Creando Usuarios"

u1 = User.new(
  email: "dan@gmail.com",
  password: "123456",
  )
u1.save!

p "Usuario 1 creado"
u2 = User.new(
  email: "mike@gmail.com",
  password: "123456",
  )
p "Usuario 2 creado"
u2.save!

p "Creando Zonas de parqueo"

z1 = ParkingZone.new(
  name: "Zona 1",
  city: "El Retiro",
  user: u1,
  )
z1.save!

p "Zona de parqueo 1 creada"

z2 = ParkingZone.new(
  name: "Zona 2",
  city: "El Retiro",
  user: u1,
  )
z2.save!

p "Zona de parqueo 1 creada"

z3 = ParkingZone.new(
  name: "Zona 3",
  city: "El Retiro",
  user: u2,
  )
z3.save!

p "Zona de parqueo 3 creada"

p "Creando Vehículos"

v1 = Vehicle.new(
  plate: "DJP779"
  )

p "Vehiculo 1 creado"

v1.save!

v2 = Vehicle.new(
  plate: "FAT458"
  )

p "Vehiculo 2 creado"

v2.save!

v3 = Vehicle.new(
  plate: "RIG165"
  )

p "Vehiculo 3 creado"

v3.save!

v4 = Vehicle.new(
  plate: "RIG525"
  )

p "Vehiculo 4 creado"

v4.save!

p "Creando Tickets"

month = Time.now.month
day = Time.now.day
hour = Time.now.hour
min = Time.now.min
sec = Time.now.min

t1 = Ticket.new(
  entry: Time.new(2018,month,day,hour-2,min,sec),
  status: "pendiente",
  vehicle: v1,
  parking_zone: z1
  )
t1.save!
p "Ticket 1 creado"

t2 = Ticket.new(
  entry: Time.new(2018,month,day,hour-1,min,sec),
  status: "pendiente",
  vehicle: v2,
  parking_zone: z2
  )
t2.save!
p "Ticket 2 creado"

t3 = Ticket.new(
  entry: Time.new(2018,month,day,hour-2,min,sec),
  exit: Time.new(2018,month,day,hour,min,sec ),
  status: "pagado",
  vehicle: v3,
  parking_zone: z1
  )
t3.save!
p "Ticket 3 creado"

t4 = Ticket.new(
  entry: Time.new(2018,month,day,hour-2,min,sec),
  exit: Time.new(2018,month,day,hour,min,sec),
  status: "pagado",
  vehicle: v4,
  parking_zone: z2
  )
t4.save!
p "Ticket 4 creado"
