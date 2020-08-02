class Bus{
  String pickup;
  String city;
  String departTime;
  String busName;
  String price;
  String bus_class;
  String dest;

  Bus(
    this.pickup,
    this.city,
    this.departTime,
    this.busName,
    this.price,
    this.bus_class,
    this.dest
  );
}

Bus fort_aguada = new Bus(
  "Margao/Colva res.",
  "Mayem lake, Aldona Cable",
  "Dpt: 8.45 am - Arr: 7.00 pm",
  "North Goa Tour",
  "Rs. 350",
  "AC",
  "Fort Aguada"
);

Bus se_cathedral = new Bus(
  "Miramar/Panjim res",
  "Shri Manguesh, Farmagudi",
  "Dpt: 8.30 am - Arr. 8.30 pm",
  "South Goa Tour",
  "Rs. 350",
  "AC",
  "Se Cathedral"
);


Bus getBusDetails(String monument){
  if(monument == "Fort Aguada, Sinquerim") return fort_aguada;

  if(monument == "Se Cathedral, Old Goa") return se_cathedral;
}