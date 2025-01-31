/* Programa: Music.prg
   Creditos: IBM, programa original en GWBASIC, 1981
             http://www.youtube.com/watch?v=y_bqgTDtV8s

             Dennis L. Dias, funcion TONE() en ensamblador 09/12/1987
             http://en.wikipedia.org/wiki/Denny_Dias

             Harbour Proyect: gttone.c, http://harbour-project.org

   Autor:    Juan Carlos Ocampo de la Cruz, Version en Clipper 04/11/1993
             e-mail: SodaStereano@hotmail.com
             video: http://www.youtube.com/watch?v=1wQMHsqxo_s
             Acapulco, Mexico
*/
   
#INCLUDE "INKEY.CH"

FUNC MAIN  // PONER * si se compila en Clipper

*** Los siguientes 2 mandatos, activa raton en Clipper 5.3 y Harbour/xHarbour
*** poner * si compila en Clipper 5.2
SET EVENTMASK TO INKEY_ALL  // Constante definida en inkey.ch
MSETCURSOR(.T.)             // Activa cursor de raton

SETMODE(25,80)
SETCANCEL(.F.)
SETCURSOR(0)
SETCOLOR("W+/B,W+/R,R")
SET WRAP ON
SET MESSAGE TO 24 CENTER

aColumna=Array(70)
nColumna=5
lTarSon =.T.

*** llena el arreglo de las columnas donde se colocara el simbolo musical
FOR nIndice=1 TO 70
    IF nIndice>39
       ++nColumna
    ENDIF
    IF nIndice=40 .OR. nIndice=45 .OR. nIndice=52 .OR. nIndice=57 .OR. nIndice=64 .OR. nIndice=70
       ++nColumna
    ENDIF
    aColumna[nIndice]=nColumna
NEXT

CLEAR
@0,0 TO 23,79
@03,0 SAY CHR(195)+REPLICATE(CHR(196),78)+CHR(180)
@21,0 SAY CHR(195)+REPLICATE(CHR(196),78)+CHR(180)
SETCOLOR("GR*+/B")
@0,34 SAY " Clipper M£sica "
SETCOLOR("BG+/B")
@02,1 SAY "(C) Copyright IBM & Juan Carlos Ocampo de la Cruz, 1982, 1993."
@22,1 SAY "["+CHR(25)+CHR(24)+"] Elige melodia  ["+CHR(17)+CHR(196)+CHR(217)+"] Toca   [Esc] Salir"

Piano()
cPantalla=SAVESCREEN(7,4,11,38)

WHILE .T.
  
  @04,40 PROMPT "A Yankee Doodle                   " MESSAGE "A n ¢ n i m o"
  @05,40 PROMPT "B La Cucaracha                    " MESSAGE "Melodia tradicional Mexicana"
  @06,40 PROMPT "C Vals del Danubio Azul           " MESSAGE "Johann Strauss (1825-1899)"
  @07,40 PROMPT "D Humoresque                      " MESSAGE "Anton Dvorak (1841-1904)"
  @08,40 PROMPT "E Pop! Goes The Weasel            " MESSAGE "A n ¢ n i m o"
  @09,40 PROMPT "F Sinfon¡a 40                     " MESSAGE "Wolfgang Amadeus Mozart (27/01/1756 - 05/12/1791)"
  @10,40 PROMPT "G Funeral March of a Marionette   " MESSAGE "Carlos Gounod (1818-1893)"
  @11,40 PROMPT "H Estrellas y barras para siempre " MESSAGE "John Philipp Sousa (1854-1932)"
  @12,40 PROMPT "I El Sombrero                     " MESSAGE "Melodia tradicional Mexicana"
  @13,40 PROMPT "J Sakura                          " MESSAGE "Melodia tradicional Japonesa"
  @14,40 PROMPT "K Escalas                         " MESSAGE "E s c a l a s"
  @15,40 PROMPT "L PC Speaker/Sound Card (default) " MESSAGE "Tocar por altavos interno o tarjeta de sonido"
  
  MENU TO nOpcion

  DO CASE

     CASE nOpcion=0
       EXIT
     CASE nOpcion=12
       nSn:=ALERT("Tocar musica usando:",{"PC Speaker","Sound Card"},"W+/RB")

       IF nSn=1
         lTarSon =.F.
       ELSE
         lTarSon =.T.
       ENDIF
     OTHERWISE
       TOCA(nOpcion)
  ENDCASE
  
ENDDO
CLEAR
RETURN

*** Calcula las frecuencias de las melodias y coloca un simbolo musical en el teclado
PROCEDURE Sonido(aFrecDurac)
  lLinea11=.T.
  FOR nIndice=1 TO LEN(aFrecDurac) STEP 2
     IF INKEY()=27  // Esc 
	EXIT
     ENDIF
     *** coloca un simbolo musical en el teclado de piano
     IF lLinea11
       @11,aColumna[aFrecDurac[nIndice]] SAY CHR(14)
       lLinea11=.F.
     ELSE
       @07,aColumna[aFrecDurac[nIndice]] SAY CHR(13)
       lLinea11=.T.
     ENDIF
     
     IF lTarSon // Sound Card
       *** Quien sabe que significa esta formula, pero funciona 
       TONESC(36.8*(2^(1/12))^(aFrecDurac[nIndice]-6),aFrecDurac[nIndice+1])
     ELSE       // PC Speaker
       TONE(36.8*(2^(1/12))^(aFrecDurac[nIndice]-6),aFrecDurac[nIndice+1])
     ENDIF

     RESTSCREEN(7,4,11,38,cPantalla)
  NEXT
RETURN

*** Toca la melodia
PROCEDURE Toca(nOpcion) 
  DO CASE
     CASE nOpcion=1  // Yankee Doodle
       aNotas={50,3,50,3,52,3,54,3,50,3,54,3,52,3,45,3,50,3,50,3,52,3,54,3,50,6,;
	       49,3,1,3,;
	       50,3,50,3,52,3,54,3,55,3,54,3,52,3,50,3,49,3,45,3,47,3,49,3,50,6,;
	       50,3,1,3,;
	       47,5,49,1,47,3,45,3,47,3,49,3,50,3,1,3,45,5,47,1,45,3,43,3,42,6,;
	       45,3,1,3,;
	       47,5,49,1,47,3,45,3,47,3,49,3,50,3,47,3,45,3,50,3,49,3,52,3,50,6,;
	       50,6}
     CASE nOpcion=2  // La Cucaracha
       aNotas={42,1,1,1,42,1,1,1,42,1,1,1,47,1,1,5,51,1,1,3,42,1,1,1,42,1,1,1,;
	       42,1,1,1,47,1,1,5,51,1,1,5,30,1,1,1,30,1,1,1,35,1,1,3,47,1,1,1,;
	       47,1,1,1,46,1,1,1,46,1,1,1,44,1,1,1,44,1,1,1,42,8,1,2,42,1,1,1,;
	       42,1,1,1,42,1,1,1,46,1,1,5,49,1,1,3,42,1,1,1,42,1,1,1,42,1,1,1,;
	       46,1,1,5,49,1,1,5,37,1,1,1,37,1,1,1,30,1,1,3,54,2,56,2,54,2,52,2,;
	       51,2,49,2,47,8}
     CASE nOpcion=3 // Blue Danube Waltz
       aNotas={42,4,46,4,49,4,49,4,1,4,61,2,1,2,61,2,1,6,58,2,1,2,58,2,1,6,42,4,42,4,;
	       46,4,49,4,;
	       49,4,1,4,61,2,1,2,61,2,1,6,59,2,1,2,59,2,1,6,41,4,41,4,44,4,51,4,51,4,;
	       1,4,63,2,1,2,63,2,1,6,59,2,1,2,;
	       59,2,1,6,41,4,41,4,44,4,51,4,51,4,1,4,63,2,1,2,63,2,1,6,58,2,1,2,58,2,;
	       1,6,42,4,;
	       42,4,46,4,49,4,54,4,1,4,66,2,1,2,66,2,1,6,61,2,1,2,61,2,1,6,42,4,;
	       42,4,46,4,49,4,54,4,1,4,66,2,1,2}
       *** Para evitar el error PARSE STACK OVERFLOW 
       aNotas2={66,2,1,6,63,2,1,2,63,2,1,6,44,4,44,4,47,4,51,2,1,2,51,14,1,2,48,4,;
		49,4,58,16,;
		54,4,46,4,46,8,44,4,51,8,49,4,42,4,1,2,42,2,42,4,1,8,49,2,1,2,47,2,;
		1,6,49,2,1,2,;
		47,2,1,6,49,4,58,16,56,4,49,2,1,2,46,2,1,6,49,2,1,2,46,2,1,6,49,4,;
		56,16,54,4,49,2,1,2,47,2,1,6,49,2,1,2,47,2,1,6,49,4,58,16,;
		56,4,49,4,54,4,56,4,58,4,61,8,59,4,58,2,58,2,58,4,58,2,1,2,54,4,1,8}
    CASE nOpcion=4  // Humoresque
       aNotas={47,3,1,2,49,1,47,3,1,2,49,1,51,3,1,2,54,1,56,3,1,2,54,1,;
	       59,3,1,2,58,1,61,3,1,2,59,1,58,3,1,2,61,1,59,3,1,2,56,1,;
	       54,3,1,2,54,1,56,3,1,2,54,1,59,3,1,2,56,1,54,3,1,2,51,1,;
	       49,24,47,3,1,2,49,1,47,3,1,2,49,1,51,3,1,2,54,1,56,3,1,2,54,1,;
	       56,3,1,2,58,1,61,3,1,2,59,1,58,3,1,2,61,1,59,3,1,2,56,1,;
	       54,3,1,2,54,1,59,3,1,2,47,1,49,6,54,6,47,18}
    CASE nOpcion=5 // Pop! Goes The Weasel
       aNotas={47,2,1,2,47,2,49,2,1,2,49,2,51,2,54,2,51,2,47,2,1,2,42,2,;
	       47,2,1,2,47,2,49,2,1,2,49,2,51,6,47,2,1,2,42,2,47,2,1,2,47,2,49,2,;
	       1,2,49,2,51,2,54,2,51,2,47,2,1,4,56,2,1,4,49,2,1,2,52,2,51,6,47,2,;
	       1,4,59,2,1,2,59,2,56,2,1,2,59,2,58,2,61,2,58,2,54,2,1,4,59,2,1,2,;
	       59,2,56,2,1,2,59,2,58,6,54,2,1,2,51,2,52,2,1,2,51,2,52,2,1,2,54,2,;
	       56,2,1,2,58,2,59,2,1,4,56,2,1,4,49,2,1,2,52,2,51,6,47,2}
    CASE nOpcion=6 // Symphony #40
      aNotas={55,2,54,2,54,4,55,2,54,2,54,4,55,2,54,2,54,4,62,4,1,4,;
	      62,2,61,2,59,4,59,2,57,2,55,4,55,2,54,2,;
	      52,4,52,4,1,4,54,2,52,2,52,4,54,2,52,2,52,4,54,2,52,2,;
	      52,4,61,4,1,4,61,2,59,2,58,4,58,2,55,2,54,4,54,2,52,2,;
	      50,4,50,4,1,4,62,2,61,2,61,4,64,4,58,4,61,4,;
	      59,4,54,4,1,4,62,2,61,2,61,4,64,4,58,4,61,4,;
	      59,4,62,4,61,2,59,2,57,2,55,2,54,4,46,4,47,4,49,4,;
	      50,4,52,2,50,2,49,4,47,4,54,4,1,4,65,8,;
	      66,2,1,6,65,8,66,2,1,6,65,8,;
	      66,4,65,4,66,4,65,4,66,4}
    CASE nOpcion=7 // Funeral March of a Marionette
      aNotas={37,1,1,2,30,1,1,5,42,3,42,3,41,3,39,3,41,3,1,3,42,3,44,3,1,3,37,1,1,2,;
	      30,1,1,5,42,3,42,3,41,3,39,3,41,3,1,3,42,3,44,3,1,3,37,3,42,3,1,3,45,3,;
	      49,6,47,3,45,3,1,3,49,3,52,6,50,3,49,3,1,3,53,3,56,6,54,3,53,3,50,3,;
	      49,3,47,3,45,3,44,3,30,1,1,5,42,3,42,3,41,3,39,3,41,3,1,3,42,3,44,3,;
	      1,3,37,1,1,2,30,1,1,5,42,3,42,3,41,3,39,3,41,3,1,3,42,3,44,3,1,3,;
	      37,3,45,3,1,3,49,3,52,6,50,3,49,3,47,3,45,3,43,3,47,3,50,3,42,3,;
	      41,3,42,3,44,3,1,3,45,1,1,2,44,9,42,1}
    CASE nOpcion=8 // Stars And Stripes Forever
      aNotas={54,6,54,6,52,3,51,3,51,6,50,3,51,3,51,16,1,2,50,3,;
	      51,3,51,6,50,3,51,3,;
	      54,6,51,3,54,3,52,12,49,6,1,3,49,3,49,6,48,3,49,3,;
	      49,6,48,3,49,3,;
	      52,16,1,2,51,3,49,3,51,3,54,9,56,9,56,3,49,16,1,2,54,6,;
	      54,6,52,3,51,3,51,6,50,3,51,3,51,16,1,2,50,3,51,3,51,6,50,3,51,3,;
	      52,3,51,3,49,5,46,1,49,12,47,6,1,3,47,3,47,6,46,3,47,3,50,6,49,3,47,3,;
	      59,15,1,3,47,3,49,3,51,3,54,1,1,2,47,3,49,3,51,3,54,1,1,2,42,3,44,5,;
	      51,1,49,12,47,1}
    CASE nOpcion=9 // El sombrero
      aNotas={52,2,57,2,1,2,52,2,57,2,1,2,52,2,57,6,1,4,52,2,57,2,59,2,57,2,56,4,;
	      57,2,59,2,1,8,52,2,56,2,1,2,52,2,56,2,1,2,52,2,56,6,1,4,52,2,;
	      56,2,57,2,56,2,54,4,56,2,57,2,1,6,64,2,63,2,64,2,61,2,60,2,61,2,;
	      57,2,56,2,57,2,52,2,1,4,49,2,50,2,52,2,54,2,56,2,57,2,59,2,61,2,;
	      62,2,59,2,1,4,62,2,61,2,62,2,59,2,58,2,59,2,56,2,55,2,56,2,52,2,;
	      1,4,64,2,63,2,64,2,66,2,64,2,62,2,61,2,59,2,57,2}
    CASE nOpcion=10 // Sakura
       aNotas={49,8,49,8,51,12,1,4,49,8,49,8,51,12,1,4,49,8,51,8,52,8,51,8,;
	       49,8,51,4,49,4,45,16,44,8,40,8,44,8,45,8,;
	       44,8,44,4,40,4,39,16,49,8,49,8,51,12,1,4,49,8,49,8,51,12,1,4,;
	       40,8,44,8,45,8,49,8,51,4,49,4,45,8,44,16}
    CASE nOpcion=11 // Escalas
      aNotas={38,1,39,1,40,1,41,1,42,1,43,1,44,1,45,1,46,1,47,1,;
	      48,1,49,1,50,1,51,1,52,1,53,1,54,1,55,1,56,1,;
	      57,1,58,1,59,1,60,1,61,1,62,1,63,1,64,1,65,8,1,4,;
	      65,8,64,1,63,1,62,1,61,1,60,1,59,1,58,1,57,1,;
	      56,1,55,1,54,1,53,1,52,1,51,1,50,1,49,1,48,1,;
	      47,1,46,1,45,1,44,1,43,1,42,1,41,1,40,1,39,1,38,8}
  ENDCASE
  Sonido(aNotas)      // Toca
  IF nOpcion=3 .AND. LASTKEY()#27
     Sonido(aNotas2) // Si es la melodia mas larga, toca la 2da. parte 
  ENDIF
RETURN

*** Dibuja teclado de piano
PROCEDURE Piano
  SETCOLOR("W+/N")
  FOR nColumna=0 TO 15
    FOR nLinea=0 TO 8
      @5+nLinea,5+nColumna*2 SAY CHR(219)+CHR(221)
    NEXT
  NEXT
  FOR nColumna=0 TO 12
    FOR nLinea=0 TO 4
      IF nColumna=2 .OR. nColumna=6 .OR. nColumna=9
        LOOP
      ENDIF
      @5+nLinea,8+nColumna*2 SAY CHR(32)+CHR(222)
    NEXT
  NEXT
  FOR nLinea=0 TO 9
    SETCOLOR("R/N")
    @4+nLinea,4  SAY CHR(221)
    SETCOLOR("W+/N")
    @4+nLinea,36 SAY CHR(221)
    SETCOLOR("R/B")
    ??CHR(221)
  NEXT
  SETPOS(4,4)
  FOR nColumna=0 TO 32
    ??CHR(219)
  NEXT
  ??CHR(221)
  SETPOS(13,4)
  FOR nColumna=0 TO 32
    ??CHR(219)
  NEXT
  ??CHR(221)
  SETCOLOR("W+/B")
RETURN

/* Agregado el 02/11/2011, dia de muertos...
   Version de tone con salida a la tarjeta de sonido, tomado de los demos
   de Harbour Minigui Extended 2.0.2 C:\MiniGUI\SAMPLES\Advanced\Tone
   publicado originalmente en hbtone.prg, xharbour news 8 feb 2007
*/

#pragma BEGINDUMP

/*
   Author: Andi Jahja <harbour@cbn.net.id>

   TONE() for Windows to replace the ugly-heard GT Tone :-)
   Mono approach. Duration has been roughly estimated to be Cli**per-like,
   please refer to tests/sound.prg.
   Using Windows MMsystem, sound card is a must in order to make
   this function work.

   Syntax: TONE( nFreq, nDuration, [ lSmooth ], [ nVol ] ) -> NIL

   nFreq     = INTEGER, Tone frequency
   nDuration = NUMERIC, Duration Time, as in Cl**per
   lSmooth   = LOGICAL, pass .F. to disable sound smoothing, default is .T.
   nVol      = INTEGER, Sound Intensity/Volume, value 0 - 127, Default 127 ( Max )

*/

#include "hbapi.h"
#include <windows.h>
#include <mmsystem.h>
#include <math.h>

#ifndef __XHARBOUR__
   #define ISLOG( n )            HB_ISLOG( n )
   #define ISNUM( n )            HB_ISNUM( n )
#endif

#define SAMPLING_RATE 44100

void HB_EXPORT hb_winTone( UINT, double, BOOL, UINT );

HB_FUNC( TONESC )
{
   if ISNUM( 1 )
   {
      hb_winTone( hb_parni( 1 ),
                ( ISNUM( 2 ) ? hb_parnd( 2 ) : 1.0 ) * 2100,
                  ISLOG( 3) ? hb_parl( 3 ) : TRUE,
                  ISNUM( 4 ) ? hb_parni( 4 ) : 127 );
   }
}

/* Keep it here for access from C programs */
void HB_EXPORT hb_winTone( UINT uFrequency, double dwDuration, BOOL bSmoothing, UINT uVolume )
{
   WAVEFORMATEX wfx;
   HWAVEOUT hWaveOut = NULL;

   wfx.wFormatTag = WAVE_FORMAT_PCM;
   wfx.nChannels = 1;
   wfx.nSamplesPerSec = SAMPLING_RATE;
   wfx.nAvgBytesPerSec = SAMPLING_RATE;
   wfx.nBlockAlign = 1;
   wfx.wBitsPerSample = 8;
   wfx.cbSize = 0;

   /*
   WAVE_MAPPER is the most commonly used device
   CallBack is unnecessary since we only play simple tone
   */
   if( waveOutOpen( &hWaveOut, WAVE_MAPPER, &wfx, NULL, NULL, CALLBACK_NULL ) == MMSYSERR_NOERROR )
   {
      char amp = uVolume;
      int i;
      unsigned char* buffer = (unsigned char*) hb_xgrab( (ULONG) dwDuration );
      double dKoef = uFrequency * 2 * 3.14159 / SAMPLING_RATE;
      WAVEHDR wh;

      if ( buffer )
      {
         wh.lpData = (LPSTR) buffer;
         wh.dwBufferLength = (DWORD) dwDuration;
         wh.dwFlags = WHDR_BEGINLOOP;
         wh.dwLoops = 1;

         if( waveOutPrepareHeader( hWaveOut, &wh, sizeof( wh ) ) == MMSYSERR_NOERROR )
         {
            wh.dwFlags = WHDR_BEGINLOOP | WHDR_ENDLOOP | WHDR_PREPARED;
            wh.dwLoops = 1;

            if ( bSmoothing )
            {
               /*
               Manipulating data to smooth sound from clicks at the start
               and end (particularly noted when we call TONE() many times
               in a row). This is a simulation of increasing volume gradually
               before it reaches the peak, and decreasing volume gradually
               before it reaches the end.
               */
               for( i = 0; i < dwDuration; i++ )
               {
                  if ( i < amp )
                  {
                     buffer[ i ] = (unsigned char) ( cos( i * dKoef ) * i + 127 );
                  }
                  else if ( dwDuration - i <= amp - 1  )
                  {
                     amp = max( 0, --amp );
                     buffer[ i ] = (unsigned char) ( cos( i * dKoef ) * amp + 127 );
                  }
                  else
                  {
                     buffer[ i ] = (unsigned char) ( cos( i * dKoef ) * amp + 127 );
                  }
               }
            }
            else
            {
               /*
               Raw sound, may cause annoying clicks when some tones are played
               in a row.
               */
               for( i = 0; i < (int) dwDuration; i++ )
               {
                  buffer[ i ] = (unsigned char) ( cos( i * dKoef ) * amp + 127 );
               }
            }

            /*
            Play the sound here
            */
            if ( waveOutWrite( hWaveOut, &wh, sizeof(WAVEHDR) ) == MMSYSERR_NOERROR )
            {
               /*
               Wait until the sound is finished
               */
               while (!(wh.dwFlags & WHDR_DONE))
               {
                  Sleep( 1 );
               }

               waveOutUnprepareHeader(hWaveOut, &wh, sizeof(WAVEHDR));
            }
         }

         hb_xfree( buffer );
      }
   }
}

#pragma ENDDUMP
