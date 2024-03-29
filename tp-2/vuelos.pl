vuelo(salta, cordoba, 80).
vuelo(cordoba, formosa, 120).
vuelo(cordoba, rosario, 55).
vuelo(cordoba, neuquen, 100).
vuelo(cordoba, mendoza, 65).
vuelo(formosa, corrientes, 50).
vuelo(corrientes, posadas, 70).
vuelo(corrientes,  parana, 57).
vuelo(corrientes, santaFe, 93).
vuelo(posadas, parana, 85).
vuelo(santaFe, rosario, 30).
vuelo(rosario, parana, 25).
vuelo(rosario, buenosAires, 55).
vuelo(rosario, mendoza, 175).
vuelo(mendoza, buenosAires, 85).
vuelo(mendoza, neuquen, 83).
vuelo(neuquen,  buenosAires, 90).
vuelo(buenosAires, calafate, 115).
vuelo(buenosAires,  puertoMadryn, 75).
vuelo(neuquen, calafate, 65).

% Verificar si 2 ciudades se encuentran conectadas
conectadas(A, B, Tiempo) :- vuelo(A, B, Tiempo).
conectadas(A, B, Tiempo) :- vuelo(B, A, Tiempo).

% Ejemplos de uso:
%	breadthFirstSearch([[rosario]], neuquen, Ruta).
%	deepFirstSearch(rosario, neuquen, [rosario], Ruta).


breadthFirstSearch([[Destino|Ruta]|_], Destino, RutaFinal) :- 
	reverse([Destino|Ruta], RutaFinal),
	tiempoViaje(RutaFinal, Tiempo), 
	write('\nTiempo: '), write(Tiempo).
breadthFirstSearch([PrimerRuta|OtrasRutas], Destino, Ruta) :-
	hijosNodo(PrimerRuta, NuevasRutas),
	concatenar(OtrasRutas, NuevasRutas, NuevaListaNodos),
	breadthFirstSearch(NuevaListaNodos, Destino, Ruta).


% Ciudades conectadas que se no se encuentren en la ruta actual
hijosNodo([Nodo|Ruta], Hijos) :-
	findall(
		[Hijo,Nodo|Ruta], 
		(
			conectadas(Nodo, Hijo, _),
			not(in(Hijo, [Nodo|Ruta]))
		),
		Hijos
	).
hijosNodo(_, []).


% Concatenar listas
concatenar([], B, B).
concatenar([H|T], B, [H|C]) :- concatenar(T, B, C).


deepFirstSearch(Origen, Origen, Ruta, RutaFinal) :-
	reverse(Ruta, RutaFinal),
	tiempoViaje(RutaFinal, Tiempo), 
	write('\nTiempo: '), write(Tiempo).
deepFirstSearch(Origen, Destino, RutaParcial, Ruta) :- 
	conectadas(Origen, Ciudad, _),
	not(in(Ciudad, RutaParcial)),
	deepFirstSearch(Ciudad, Destino, [Ciudad|RutaParcial], Ruta).


% Verificar si un elemento se encuentra en la lista
in(X, [X|_]).
in(X, [_|T]) :- in(X, T).


% Calcular tiempo de viaje de una ruta
tiempoViaje([_], 0).
tiempoViaje([C1, C2|T], S) :- conectadas(C1, C2, T1), tiempoViaje([C2|T], T2), S is T1 + T2.