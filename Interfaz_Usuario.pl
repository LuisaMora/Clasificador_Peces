 :- use_module(library(pce)).
 :- pce_image_directory('./imagenes').
 :- use_module(library(pce_style_item)).
 :- dynamic color/2.

 resource(img_principal, image, image('Principal.jpg')).
 resource(portada, image, image('Menu.jpg')).
 resource(gambusia_affinis_macho, image, image('Pez_Mosquito_Macho.jpg')).
 resource(gambusia_affinis_hembra, image, image('Pez_Mosquito_Hembra.jpg')).
 resource(gambusia_Punctata, image, image('Gambusia_Punctata.jpg')).
 resource(luchadores_de_Siam,image,image('Pez_Luchador.jpg')).
 resource(perca_Trepadora, image, image('Pez_Trepador.jpg')).
 resource(pez_Joya, image, image('Pez_Joya.jpg')).
 resource(lo_siento_pez_desconocido, image, image('desconocido.jpg')).


 resource(dientes, image, image('dientes.jpg')).
 resource(gono, image, image('gonopodio.jpg')).
 resource(color_gris, image, image('colorgris.jpg')).
resource(manchas, image, image('manchas.jpg')).
 resource(rayas_verdes, image, image('rayasverdes.jpg')).
 resource(canales, image, image('canaleslab.jpg')).
 resource(medio, image, image('percamedia.jpg')).
 resource(azul, image, image('pezazul.jpg')).
 resource(rayas_rojas, image, image('rayasrojas.jpg')).
 resource(sin_rayas, image, image('sinrayas.jpg')).
 resource(rojo, image, image('pezrojo.jpg')).
 resource(boca_pequenia, image, image('bocapequenia.jpg')).
 resource(cola_redonda, image, image('colaredonda.jpg')).

 mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).
  mostrar_imagen_consultas(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).
  imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
  botones:-borrado,


                send(@boton, free),
                send(@btnclasificacion,free),
                mostrar_pez(Car),

                send(@resp1, selection(Car)),
                new(@boton, button('Iniciar Preguntas',
                message(@prolog, botones)
                )),

                new(@btnclasificacion,button('Detalles del Pez',
                message(@prolog, mostrar_clasificacion,Car)
                )),
                send(@main, display,@boton,point(20,450)),
                send(@main, display,@btnclasificacion,point(138,450)).



  mostrar_clasificacion(X):-new(@tratam, dialog('Tonsultas')),
                          send(@tratam, append, label(nombre, 'Clasificador de peces: ')),
                          send(@tratam, display,@lblExp1,point(70,51)),
                          send(@tratam, display,@lblExp2,point(50,80)),
                          consultas(X),
                          send(@tratam, transient_for, @main),
                          send(@tratam, open_centered).

consultas(X):- send(@lblExp1,selection('De acuerdo a las preguntas el pez que tienes es:')),
                 mostrar_imagen_consultas(@tratam,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   preguntar(Preg,Resp):-new(Di,dialog('Colsultar Pez:')),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
                        id_imagen_preg(Preg,Imagen),
                        imagen_pregunta(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(si,and(message(Di,return,si)))),
                        new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'si'),
                        send(Di,open_centered),get(Di,confirm,Answer),
                        free(Di),
                        Resp=Answer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  interfaz_principal:-new(@main,dialog('Sistema experto clasificador de peces',
        size(1000,1000))),
        new(@texto, label(nombre,'El pez que tienes apartir de las preguntas es:',font('times','roman',18))),
        new(@resp1, label(nombre,'',font('times','roman',22))),
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@salir,button('SALIR',and(message(@main,destroy),message(@main,free)))),
        new(@btnclasificacion,button('??consultas?')),
        new(@boton, button('Iniciar',message(@prolog, botones))),

        nueva_imagen(@main, img_principal),
        send(@main, display,@boton,point(138,450)),
        send(@main, display,@texto,point(20,130)),
        send(@main, display,@salir,point(300,450)),
        send(@main, display,@resp1,point(20,180)),
        send(@main,open_centered).

       borrado:- send(@resp1, selection('')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  crea_interfaz_inicio:- new(@interfaz,dialog('Bienvenido al Sistema Experto clasificador',
  size(1000,1000))),

  mostrar_imagen(@interfaz, portada),

  new(BotonComenzar,button('COMENZAR',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('SALIDA',and(message(@interfaz,destroy),message(@interfaz,free)))),
  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz,open_centered).

  :-crea_interfaz_inicio.


/* BASE DE CONOCIMIENTOS:*/

conocimiento('luchadores_de_Siam',
['el pez posee canales laberinticos para respirar','el pez es de tamanio medio','el pez es de color azul','el pez tiene rayas rojas']).

conocimiento('perca_Trepadora',['el pez no tiene rayas','el pez es de tamanio medio']).

conocimiento('pez_Joya',['el pez tiene boca pequenia','el pez tiene la cola redondeada','el pez es de color rojo']).

conocimiento('gambusia_Punctata',
['el pez tiene manchas a lo largo del cuerpo','el pez tiene dientes punteagudos','el pez es de color gris','el pez tiene rayas verdes']).

conocimiento('gambusia_affinis_macho',
['el pez tiene manchas a lo largo del cuerpo','el pez tiene dientes punteagudos','el pez tiene gonopodio']).

conocimiento('gambusia_affinis_hembra',
['el pez tiene manchas a lo largo del cuerpo','el pez tiene dientes punteagudos']).


id_imagen_preg('el pez tiene dientes punteagudos','dientes').
id_imagen_preg('el pez tiene gonopodio','gono').
id_imagen_preg('el pez es de color gris','color_gris').
id_imagen_preg('el pez tiene rayas verdes','rayas_verdes').
id_imagen_preg('el pez posee canales laberinticos para respirar','canales').
id_imagen_preg('el pez es de tamanio medio','medio').
id_imagen_preg('el pez es de color azul','azul').
id_imagen_preg('el pez tiene rayas rojas','rayas_rojas').
id_imagen_preg('el pez tiene no tiene rayas','sin_rayas').
id_imagen_preg('el pez tiene boca pequenia','boca_pequenia').
id_imagen_preg('el pez tiene la cola redondeada','cola_redonda').
id_imagen_preg('el pez es de color rojo','rojo').
id_imagen_preg('el pez tiene manchas a lo largo del cuerpo','manchas').



/* MOTOR DE INFERENCIA: Esta parte del sistema experto se encarga de
 inferir cual es el pez a partir de las preguntas realizadas
 */
:- dynamic conocido/1
.%Solo permite considerar Si o No

  mostrar_pez(X):-verificar_pez(X),clean_scratchpad.
  mostrar_pez(lo_siento_pez_desconocido):-clean_scratchpad .

  verificar_pez(Pez):-
                      obten_posible(Pez,ListaDeCaracteristicas),
                       prueba(Pez, ListaDeCaracteristicas).


  obten_posible(Pez, ListaDeCaracteristicas):-
                            conocimiento(Pez, ListaDeCaracteristicas).


prueba(Pez, []).
prueba(Pez, [Head | Tail]):- prueba_verdad(pez, Head),
                             prueba(Pez, Tail).


prueba_verdad(pez, Caracteristica):- conocido(Caracteristica).
prueba_verdad(pez, Caracteristica):- not(conocido(is_false(Caracteristica))),
pregunta_sobre(pez, Caracteristica, Reply), Reply = 'si'.


pregunta_sobre(pez, Caracteristica, Reply):- preguntar(Caracteristica,Respuesta),
                          process(Pez, Caracteristica, Respuesta, Reply).


process(Pez, Caracteristica, si, si):- asserta(conocido(Caracteristica)).
process(Pez, Caracteristica, no, no):- asserta(conocido(is_false(Caracteristica))).


clean_scratchpad:- retract(conocido(X)), fail.
clean_scratchpad.


conocido(_):- fail.

not(X):- X,!,fail.
not(_).
