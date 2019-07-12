% disco(artista, nombreDelDisco, cantidad, año).
disco(floydRosa, elLadoBrillanteDeLaLuna, 1000000, 1973).
disco(tablasDeCanada, autopistaTransargentina, 500, 2006).
disco(rodrigoMalo, elCaballo, 5000000, 1999).
disco(rodrigoMalo, loPeorDelAmor, 50000000, 1996).
disco(rodrigoMalo, loMejorDe, 50000000, 2018).
disco(losOportunistasDelConurbano, ginobili, 5, 2018).
disco(losOportunistasDelConurbano, messiMessiMessi, 5, 2018).
disco(losOportunistasDelConurbano, marthaArgerich, 15, 2019).

%manager(artista, manager).
manager(floydRosa, normal(15)).
manager(tablasDeCanada, buenaOnda(cachito, canada)).
manager(rodrigoMalo, estafador).

% normal(porcentajeComision) 
% buenaOnda(nombre, lugar)
% estafador     


porcentaje(canada, 5).
porcentaje(mexico,1.5).

clasico(Artista) :-
  disco(Artista, loMejorDe, _, _).
clasico(Artista) :-
  disco(Artista, _, Ventas, _),
  Ventas > 1000000.

ventasTotales(Artista, Ventas) :-
	disco(Artista, _, _, _),
	findall(Ventas, disco(Artista, _, Ventas, _), ListaDeVentas),
	sum_list(ListaDeVentas, Ventas).

ventasBrutas(Artista, Bruto) :-
  ventasTotales(Artista, Total),
  Bruto is Total/10.

ventasNetas(Artista, Neto) :-
  ventasBrutas(Artista, Bruto),
  manager(Artista, Manager),
  descuento(Manager,Descuento),
  porcentaje(Descuento, Bruto, Neto).

ventasNetas(Artista, Bruto) :-
    ventasBrutas(Artista, Bruto),
    not(manager(Artista, _)).

descuento(buenaOnda(_,Pais), Descuento) :-
	porcentaje(Pais, Descuento).
descuento(estafador,100).
descuento(normal(Descuento), Descuento). 

porcentaje(Porcentaje, Bruto, Neto):-
	Neto is Bruto*(100-Porcentaje).

numberUan(Anio, Artista) :-
  artistaAutogestionado(Artista),
  disco(Artista, _, Cantidad, Anio),
  not((disco(OtroArtista, _, OtraCantidad, Anio),
	artistaAutogestionado(OtroArtista),
	Cantidad < OtraCantidad)).

artistaAutogestionado(Artista) :-
  disco(Artista, _, _, _),
  not(manager(Artista, _)).
