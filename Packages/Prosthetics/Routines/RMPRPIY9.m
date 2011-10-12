RMPRPIY9 ;HINCIO/ODJ - AE - Add/Edit Locations and Items ;3/8/01
 ;;3.0;PROSTHETICS;**61,108**;Feb 09, 1996
 Q
 ;
 ;***** AE - Add Inventory LOCATIONS and ITEMS
 ;           option RMPR INV ADD
 ;           Replaces AE option in old PIP (cf ^RMPR5NAE)
 ;           no inputs required
 ;           other than standard VISTA vars. (DUZ, etc)
 ;
AE N RMPRERR,RMPRSTN,RMPREXC,RMPR5,RMPR1,RMPR11,RMPRVEND,RMPRTVAL,RMPRDUP
 N RMPRQTY,RMPRREO,RMPR61,RMPRUCST,RMPROVAL,RMPRI,RMPRUPDF
 ;
 ;***** STN - call prompt for Site/Station
STN S RMPROVAL=$G(RMPRSTN("IEN"))
 W @IOF S RMPRERR=$$STN^RMPRPIY1(.RMPRSTN,.RMPREXC)
 I RMPRERR G AEX
 I RMPREXC'="" G AEX
 I RMPROVAL'=RMPRSTN("IEN") K RMPR5
 ;
 ;***** LOCN - call prompt for Location
LOCN W !!,"Adding Item to a Location.",!
 S RMPROVAL=$G(RMPR5("IEN"))
 S RMPRERR=$$LOCNM^RMPRPIY2(RMPRSTN("IEN"),.RMPR5,.RMPREXC)
 I RMPREXC="T"!(RMPREXC="^") G AEX
 I RMPREXC="P" G STN
 I RMPROVAL'=RMPR5("IEN") K RMPR1
 I $P($G(^RMPR(661.5,RMPR5("IEN"),0)),U,4)="I" W !!,"LOCATION IS INACTIVE AND CANNOT BE EDITED, OR ASSOCIATED ITEMS!!" K RMPR5 G LOCN
LOCN2 S RMPR5("STATION")=RMPRSTN("IEN")
 S RMPR5("STATION IEN")=RMPRSTN("IEN")
 ;
 ;***** HCPCS - call prompt for HCPCS code
HCPCS S RMPROVAL=$G(RMPR1("HCPCS"))
 S RMPR1("HCPCS")=""
 W ! S RMPRERR=$$HCPCS^RMPRPIY3(.RMPR5,.RMPR1,.RMPREXC)
 I RMPREXC="T"!(RMPREXC="^") G AEX
 I RMPREXC="P" G LOCN
 I RMPROVAL'=RMPR1("HCPCS") D
 . K RMPR11,RMPR61
 . S RMPR11("HCPCS")=RMPR1("HCPCS")
 . Q
 S RMPR11("STATION")=RMPRSTN("IEN")
 S RMPR11("STATION IEN")=RMPRSTN("IEN")
 ;
 ;***** MASIT - call prompt for master item (in 661->441)
MASIT S RMPROVAL=$G(RMPR61("IEN"))
 D MASIT^RMPRPIY1(.RMPR61,.RMPREXC)
 I RMPREXC="T" G AEX
 I RMPREXC="P" G HCPCS
 I RMPREXC="^" G AEX
 I RMPROVAL'=RMPR61("IEN") D
 . S RMPRERR=$$GET^RMPRPIXD(.RMPR61)
 . K RMPRSRC,RMPRREO,RMPR4
 . S RMPR11("ITEM MASTER IEN")=RMPR61("IEN")
 . S RMPR11("DESCRIPTION")=RMPR61("ITEM MASTER")
 . S RMPR11("ITEM MASTER")=RMPR61("ITEM MASTER")
 . Q
 ;
 ;***** IDESC - call prompt for Item Description edit
IDESC S RMPROVAL=$G(RMPR11("DESCRIPTION"))
 D ITED^RMPRPIY4(.RMPR11,.RMPREXC)
 I RMPREXC="T" G AEX
 I RMPREXC="P" G MASIT
 I RMPREXC="^" G HCPCS
 I $G(RMPR11("DESCRIPTION"))="" D
 . S RMPR11("DESCRIPTION")=RMPR61("ITEM MASTER")
 . S RMPR11("ITEM MASTER")=RMPR61("ITEM MASTER")
 . Q
 I RMPROVAL'=RMPR11("DESCRIPTION") D
 . K RMPRSRC,RMPRREO
 . Q
 ;
 ;***** SRC - call prompt for Source (Commercial or VA)
SRC S RMPROVAL=$G(RMPRSRC)
 D SRC^RMPRPIY5(.RMPRSRC,.RMPREXC)
 I RMPREXC="P" G IDESC
 I RMPREXC="^" G HCPCS
 I RMPREXC="T" G AEX
 I RMPROVAL'=RMPRSRC K RMPRREO
 ;
 ; Update the inventory file (661.11)
 S RMPR11("SOURCE")=RMPRSRC
 S RMPR11("UNIT")=""
 S RMPRERR=0
 S RMPRUPDF=1 ;update flag
 ;
 ; Only create new record if one doesn't already exist
 I $D(^RMPR(661.11,"ASHMDI",RMPRSTN("IEN"),RMPR11("HCPCS"),RMPR61("IEN"),RMPR11("DESCRIPTION"))) D
 . S RMPRI=""
 . F  S RMPRI=$O(^RMPR(661.11,"ASHMDI",RMPRSTN("IEN"),RMPR11("HCPCS"),RMPR61("IEN"),RMPR11("DESCRIPTION"),RMPRI)) Q:RMPRI=""  D  Q:'RMPRUPDF
 .. S RMPR11("ITEM")=RMPRI
 .. S RMPR11("IEN")=""
 .. S RMPRERR=$$DUP^RMPRPIX1(.RMPR11,.RMPRDUP)
 .. I RMPRERR S RMPRUPDF=0 Q
 .. I 'RMPRDUP S RMPRUPDF=0 Q
 .. Q
 . Q
 I RMPRUPDF D
 . S RMPR11("ITEM")=""
 . K RMPR11("IEN")
 . S RMPRERR=$$CRE^RMPRPIX1(.RMPR11)
 . S RMPR4("RE-ORDER QTY")=0
 . S RMPRERR=$$CRE^RMPRPIX4(.RMPR4,.RMPR11,.RMPR5)
 . Q
 I RMPRERR D  G AEX
 . W !,"Problem updating inventory item file, please contact support."
 . H 3
 . Q
 ;
 ;***** REO - call prompt for Re-Order Quantity
REO S RMPROVAL=$G(RMPRREO)
 D REO^RMPRPIY5(.RMPRREO,.RMPREXC)
 I RMPREXC="P" G SRC
 I RMPREXC="^" G HCPCS
 I RMPREXC="T" G AEX
 ;
 ; Update the reorder file (661.4)
 I RMPROVAL=RMPRREO G QTY
 S RMPR4("RE-ORDER QTY")=RMPRREO
 S RMPRERR=$$UPD^RMPRPIX4(.RMPR4,,)
 ;
 ; At this point the item has been added to inventory (661.11) and
 ; the re-order file (661.4)
 ; The following prompts are for receipting in a quantity of the item
 ;
 ;***** QTY - call prompt for Quantity
QTY D QTY^RMPRPIY5(.RMPRQTY,.RMPREXC)
 I RMPREXC="P" G REO
 I RMPREXC="^" G HCPCS
 I RMPREXC="T" G AEX
 S RMPRQTY=+$G(RMPRQTY)
 I 'RMPRQTY G QTY
 ;
 ;***** UCST - call prompt for Unit Cost
UCST D UCST^RMPRPIY5(.RMPRUCST,.RMPREXC)
 I RMPREXC="P" G QTY
 I RMPREXC="^" G HCPCS
 I RMPREXC="T" G AEX
 S RMPRUCST=+$G(RMPRUCST)
 ;
 ;***** TVAL - Total Value - use if Unit Cost not used
TVAL I RMPRUCST D  G VEND
 . S RMPRTVAL=$J(RMPRQTY*RMPRUCST,0,2)
 . W !,"TOTAL COST OF QUANTITY: "_RMPRTVAL
 . Q
 D TVAL^RMPRPIY5(.RMPRTVAL,.RMPREXC)
 I RMPREXC="P" G UCST
 I RMPREXC="^" G HCPCS
 I RMPREXC="T" G AEX
 ;
 ;***** VEND - call prompt for Vendor
VEND D VEND^RMPRPIY5(.RMPRVEND,.RMPREXC)
 I RMPREXC="P" G UCST
 I RMPREXC="^" G HCPCS
 I RMPREXC="T" G AEX
 ;
 ;
 ;***** UNIT - call prompt for UNIT OF ISSUE
UNIT D UNIT^RMPRPIY5(.RMPRUNI,.RMPREXC)
 I RMPREXC="P" G UCST
 I RMPREXC="^" G HCPCS
 I RMPREXC="T" G AEX
 ;
 ;***** TRANS - Create receipt record for adding an item
TRANS S RMPR11("STATION")=RMPRSTN("IEN")
 S RMPR11("STATION IEN")=RMPRSTN("IEN")
 S RMPR6("QUANTITY")=RMPRQTY
 S RMPR6("VALUE")=RMPRTVAL
 S RMPR6("VENDOR")=RMPRVEND("IEN")
 S RMPR6("UNIT")=RMPRUNI("IEN")
 S RMPRERR=$$REC^RMPRPIU8(.RMPR6,.RMPR11,.RMPR5,1) ;receipt API
TRANSX I RMPRERR D
 . W !!,"** Inventory could not be updated, please contact support",!
 . Q
 E  D
 . W !!,"** Inventory updated.",!
 .;ask for number of labels and print barcode.
 . S RMPR11("HCPCS-ITEM")=RMPR11("HCPCS")_"-"_RMPR11("ITEM")
 . D NLAB^RMPRPIYY
 . Q
 K RMPR6,RMPRTVAL,RMPRQTY,RMPRUCST
 G HCPCS
 ;
 ;***** exit
AEX D KILL^XUSCLEAN
 Q