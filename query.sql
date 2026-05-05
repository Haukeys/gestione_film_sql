--1 Il nome di tutte le sale di Pisa

select nome as nome_sala, citta as città
from Sala
where citta = "Pisa";

--2 Il titolo dei film di F. Fellini prodotti dopo il 1960.

select titolo
from Film
where regista="F. Fellini"
AND anno_produzione >1960 ;

--3 Il titolo e la durata dei film di fantascienza giapponesi o francesi prodotti dopo il 1990

select titolo,durata
from Film
where (nazionalita="Giappone"
OR nazionalita="Francia")
AND anno_produzione >1990 ;

--4 Il titolo dei film di fantascienza giapponesi prodotti dopo il 1990 oppure francesi

select titolo
from Film
where (genere = "Fantascienza"
AND nazionalita="Giappone")
AND anno_produzione >1990 
OR nazionalita="Francia";

--5 I titolo dei film dello stesso regista di “Casablanca”

with RegistaCasablanca as (
select regista
from Film 
where titolo="Casablanca")

select titolo 
from Film 
where regista = (select regista from RegistaCasablanca)
AND titolo <> "Casablanca";

--6 Il titolo ed il genere dei film proiettati il giorno di Natale 2004

select f.titolo,f.genere
from Film f , Proiezione p 
where p.data_proiezione = '2004-12-25'
AND f.idFilm = p.idfilm;

--7 Il titolo ed il genere dei film proiettati a Napoli il giorno di Natale 2004

select f.titolo,f.genere
from Film f , Proiezione p ,Sala s
where s.citta ="Napoli"
AND p.idsala = s.idsala
AND p.data_proiezione = '2004-12-25'
AND f.idFilm = p.idfilm;


--8 I nomi delle sale di Napoli in cui il giorno di Natale 2004 è stato proiettato un film con R.Williams

select s.nome as nome_sala 
from Attore a, Film f, Attore_film af, Proiezione p, Sala s
where a.nome ='Robin Williams'
AND a.idAttore=af.id_attore
AND f.idFilm=af.id_film
AND s.citta ="Napoli"
AND p.idsala = s.idsala
AND f.idFilm = p.idfilm
AND p.data_proiezione = '2004-12-25'
;

--9 Il titolo dei film in cui recita M. Mastroianni oppure S.Loren

select distinct f.titolo as titoli_dei_film 
from Attore a, Film f, Attore_film af
where (a.nome ='Marcello Mastroianni'
AND a.idAttore=af.id_attore
AND f.idFilm=af.id_film)
OR a.nome= 'Leonardo DiCaprio';



--10 Il titolo dei film in cui recitano M. Mastroianni e S.Loren

select f.titolo as FilmDoppiAttori
from Film f,Attore a1, Attore a2, Attore_film af1, Attore_film af2
where f.idFilm = af1.id_film 
AND a1.idAttore = af1.id_attore
AND f.idFilm = af2.id_film 
AND a2.idAttore = af2.id_attore
AND a1.nome = 'Marcello Mastroianni'
AND a2.nome = 'Sophia Loren';


--11 Per ogni film in cui recita un attore francese, il titolo del film e il nome dell’attore

select f.titolo, a.nome
from Film f, Attore_film af, Attore a
where f.idFilm = af.id_film 
AND a.idAttore = af.id_attore 
AND a.nazionalita = 'Francia';


--12 Per ogni film che è stato proiettato a Pisa nel gennaio 2005, il titolo del film e il nome della sala.

select f.titolo, s.nome as nome_sala
from Film f
join Proiezione p on f.idFilm = p.idfilm
join Sala s on p.idsala = s.idSala
where s.citta = 'Pisa' 
AND P.data_proiezione BETWEEN '2005-01-01' AND '2005-01-31';



--13 Il numero di sale di Pisa con più di 60 posti

select f.titolo, s.nome as nome_sala
from Film f
join Proiezione p on f.idFilm = p.idfilm
join Sala s on p.idsala = s.idSala
where s.citta = 'Pisa' 
AND p.data_proiezione BETWEEN '2005-01-01' AND '2005-01-31';


--14 Il numero totale di posti nelle sale di Pisa

select sum(posti) as totale_posti
from Sala
where citta = "Pisa"


--15 Per ogni città, il numero di sale

select citta, count(idSala) as numero_sale
from Sala
group by citta;


--16 Per ogni città, il numero di sale con più di 60 posti

select citta, count(idSala) as numero_sale
from Sala
where posti > 60
group by citta;

--17 Per ogni regista, il numero di film diretti dopo il 1990

select regista, count(idFilm) as numero_film
from Film
where anno_produzione > 1990
group by regista;

--18 Per ogni regista, l’incasso totale di tutte le proiezioni dei suoi film

select f.regista, sum(p.incasso)as incasso_totale
from Film f join Proiezione p 
	on f.idFilm = p.idfilm
group by f.regista

--19 Per ogni film di S.Spielberg, il titolo del film, il numero totale di proiezioni a Pisa e l’incasso totale

select f.titolo, count(p.idProiezione) as numero_proiezioni,sum(p.incasso) as incasso_totale
from Film f join Proiezione p
	on f.idFilm = p.idFilm
join Sala s 
	on p.idsala = s.idSala
where f.regista = 'S. Spielberg'
And s.citta = "Pisa"
group by f.idFilm, f.titolo;

--20 Per ogni regista e per ogni attore, il numero di film del regista con l’attore

select a.nome as nome_attore, count(f.idFilm) as numero_film_regista
from Film f
join Attore_film af on f.idFilm = af.id_film
join Attore a on af.id_attore = a.idAttore
group by f.regista, a.idAttore, a.nome;

--21 Il regista ed il titolo dei film in cui recitano meno di 6 attori

select f.regista,f.titolo
from Film f join Attore_film af 
	on f.idFilm = af.id_film
group by f.idFilm,f.regista,f.titolo
having count(af.id_attore) < 6;

--22 Per ogni film prodotto dopo il 2000, il codice, il titolo e l’incasso totale di tutte le sue proiezioni



--23 Il numero di attori dei film in cui appaiono solo attori nati prima del 1970



--24 Per ogni film di fantascienza, il titolo e l’incasso totale di tutte le sue proiezioni



--25 Per ogni film di fantascienza il titolo e l’incasso totale di tutte le sue proiezioni successive al 1/1/01



--26 Per ogni film di fantascienza che non è mai stato proiettato prima del 1/1/01 il titolo e l’incasso totale di tutte le sue proiezioni



--27 Per ogni sala di Pisa, che nel mese di gennaio 2005 ha incassato più di 20000 €, il nome della sala e l’incasso totale (sempre del mese di gennaio 2005)



--28 I titoli dei film che non sono mai stati proiettati a Pisa


--29 I titoli dei film che sono stati proiettati solo a Pisa