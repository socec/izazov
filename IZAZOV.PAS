program izazov;
uses crt, graph;
type horse=record ime:string;
                  p,f,poz,prvi,drugi,k1,k2,col:integer;
                  gotov,provjeren:boolean;
                  end;
     karta=record b:1..4;
                  z:1..8;
                  end;
var konj:array[1..7]of horse;
    poredak:array[1..7]of integer;
    w,graphdriver,graphmode,tb:integer;
    znak:array[1..8]of string;
    a,b,m:array[1..5]of karta;
    t:array[1..32]of integer;
    imas:array[0..8]of string;
    kredit,ulog,pot:longint;
    exitinfo,brzina:byte;
{*********************************************************
***************     zajednicki dio     *******************
**********************************************************}
{zajednicka tipka------------------------------------------------------}
procedure izlaztipka(c:char);
{unosi se k ili p, ovisno da li se koristi u konjima ili pokeru}
begin
setlinestyle(1,0,1);
setcolor(15);
case c of 'k': begin
               rectangle(520,310,630,345);
               outtextxy(530,315,'za povratak');
               outtextxy(530,330,'pritisni X'); end;
          'p': begin
               rectangle(495,310,605,345);
               outtextxy(505,315,'za povratak');
               outtextxy(505,330,'pritisni X'); end;
               end;
end;
procedure brisitipka(c:char);
begin
setfillstyle(1,2);
case c of 'k': bar(520,310,630,345);
          'p': bar(495,310,605,345);
          end;
end;
procedure strelice;
{u izbornicima se pokazu strelice koje pokazuju da se bira}
begin
setlinestyle(0,0,3);
line(400,190,400,200);
line(400,190,395,195);
line(400,190,405,195);
line(400,210,400,220);
line(400,220,395,215);
line(400,220,405,215);
end;
{******************************************
**********     KONJSKE UTRKE     **********
*******************************************}
{konji------------------------------------------------------------------}
procedure crtaj1(x,y,z:integer);
{raskorak /\}
var i:integer;
begin
for i:=26 to 26 do putpixel(x+i,y+0,z);
for i:=25 to 27 do putpixel(x+i,y+1,z);
for i:=24 to 28 do putpixel(x+i,y+2,z);
for i:=23 to 29 do putpixel(x+i,y+3,z);
for i:=22 to 30 do putpixel(x+i,y+4,z);
for i:=21 to 26 do putpixel(x+i,y+5,z);
    for i:=28 to 30 do putpixel(x+i,y+5,z);
    for i:=7 to 9 do putpixel(x+i,y+5,z);
for i:=20 to 25 do putpixel(x+i,y+6,z);
    for i:=29 to 31 do putpixel(x+i,y+6,z);
    for i:=4 to 11 do putpixel(x+i,y+6,z);
for i:=9 to 24 do putpixel(x+i,y+7,z);
    for i:=0 to 5 do putpixel(x+i,y+7,z);
for i:=10 to 24 do putpixel(x+i,y+8,z);
for i:=9 to 24 do putpixel(x+i,y+9,z);
for i:=9 to 24 do putpixel(x+i,y+10,z);
for i:=8 to 24 do putpixel(x+i,y+11,z);
{noge}
for i:=7 to 12 do putpixel(x+i,y+12,z);
    for i:=20 to 25 do putpixel(x+i,y+12,z);
for i:=6 to 9 do putpixel(x+i,y+13,z);
    for i:=23 to 26 do putpixel(x+i,y+13,z);
for i:=5 to 7 do putpixel(x+i,y+14,z);
    for i:=26 to 28 do putpixel(x+i,y+14,z);
for i:=4 to 5 do putpixel(x+i,y+15,z);
    for i:=28 to 29 do putpixel(x+i,y+15,z);
for i:=3 to 4 do putpixel(x+i,y+16,z);
    for i:=30 to 31 do putpixel(x+i,y+16,z);
for i:=2 to 3 do putpixel(x+i,y+17,z);
    for i:=31 to 32 do putpixel(x+i,y+17,z);
for i:=1 to 2 do putpixel(x+i,y+18,z);
    for i:=32 to 33 do putpixel(x+i,y+18,z);
end;
procedure crtaj3(x,y,z:integer);
{skupljene noge \/}
var i:integer;
begin
for i:=28 to 30 do putpixel(x+i,y+3,z);
for i:=26 to 31 do putpixel(x+i,y+4,z);
for i:=23 to 32 do putpixel(x+i,y+5,z);
    for i:=7 to 9 do putpixel(x+i,y+5,z);
for i:=21 to 33 do putpixel(x+i,y+6,z);
    for i:=4 to 11 do putpixel(x+i,y+6,z);
for i:=9 to 28 do putpixel(x+i,y+7,z);
    for i:=30 to 34 do putpixel(x+i,y+7,z);
    for i:=0 to 5 do putpixel(x+i,y+7,z);
for i:=10 to 27 do putpixel(x+i,y+8,z);
    for i:=33 to 35 do putpixel(x+i,y+8,z);
for i:=9 to 26 do putpixel(x+i,y+9,z);
for i:=9 to 25 do putpixel(x+i,y+10,z);
for i:=8 to 24 do putpixel(x+i,y+11,z);
{noge}
for i:=8 to 12 do putpixel(x+i,y+12,z);
    for i:=20 to 24 do putpixel(x+i,y+12,z);
for i:=8 to 11 do putpixel(x+i,y+13,z);
    for i:=22 to 24 do putpixel(x+i,y+13,z);
for i:=9 to 11 do putpixel(x+i,y+14,z);
    for i:=22 to 23 do putpixel(x+i,y+14,z);
for i:=11 to 12 do putpixel(x+i,y+15,z);
    for i:=21 to 22 do putpixel(x+i,y+15,z);
for i:=13 to 14 do putpixel(x+i,y+16,z);
    for i:=20 to 21 do putpixel(x+i,y+16,z);
for i:=14 to 15 do putpixel(x+i,y+17,z);
    for i:=19 to 20 do putpixel(x+i,y+17,z);
for i:=15 to 16 do putpixel(x+i,y+18,z);
    for i:=18 to 19 do putpixel(x+i,y+18,z);
end;
procedure crtaj2(x,y,z:integer);
{medukorak //}
var i:integer;
begin
for i:=28 to 30 do putpixel(x+i,y+3,z);
for i:=26 to 31 do putpixel(x+i,y+4,z);
for i:=23 to 32 do putpixel(x+i,y+5,z);
    for i:=7 to 9 do putpixel(x+i,y+5,z);
for i:=21 to 33 do putpixel(x+i,y+6,z);
    for i:=4 to 11 do putpixel(x+i,y+6,z);
for i:=9 to 28 do putpixel(x+i,y+7,z);
    for i:=30 to 34 do putpixel(x+i,y+7,z);
    for i:=0 to 5 do putpixel(x+i,y+7,z);
for i:=10 to 27 do putpixel(x+i,y+8,z);
    for i:=33 to 35 do putpixel(x+i,y+8,z);
for i:=9 to 26 do putpixel(x+i,y+9,z);
for i:=9 to 25 do putpixel(x+i,y+10,z);
for i:=8 to 24 do putpixel(x+i,y+11,z);
{noge}
for i:=7 to 12 do putpixel(x+i,y+12,z);
    for i:=20 to 24 do putpixel(x+i,y+12,z);
for i:=6 to 9 do putpixel(x+i,y+13,z);
    for i:=21 to 23 do putpixel(x+i,y+13,z);
for i:=5 to 7 do putpixel(x+i,y+14,z);
    for i:=22 to 23 do putpixel(x+i,y+14,z);
for i:=4 to 5 do putpixel(x+i,y+15,z);
    for i:=22 to 23 do putpixel(x+i,y+15,z);
for i:=3 to 4 do putpixel(x+i,y+16,z);
    for i:=22 to 23 do putpixel(x+i,y+16,z);
for i:=2 to 3 do putpixel(x+i,y+17,z);
    for i:=22 to 23 do putpixel(x+i,y+17,z);
for i:=1 to 2 do putpixel(x+i,y+18,z);
    for i:=23 to 24 do putpixel(x+i,y+18,z);
end;
procedure crtaj4(x,y,z:integer);
{medukorak \\}
var i:integer;
begin
for i:=26 to 26 do putpixel(x+i,y+0,z);
for i:=25 to 27 do putpixel(x+i,y+1,z);
for i:=24 to 28 do putpixel(x+i,y+2,z);
for i:=23 to 29 do putpixel(x+i,y+3,z);
for i:=22 to 30 do putpixel(x+i,y+4,z);
for i:=21 to 26 do putpixel(x+i,y+5,z);
    for i:=28 to 30 do putpixel(x+i,y+5,z);
    for i:=7 to 9 do putpixel(x+i,y+5,z);
for i:=20 to 25 do putpixel(x+i,y+6,z);
    for i:=29 to 31 do putpixel(x+i,y+6,z);
    for i:=4 to 11 do putpixel(x+i,y+6,z);
for i:=9 to 24 do putpixel(x+i,y+7,z);
    for i:=3 to 5 do putpixel(x+i,y+7,z);
for i:=10 to 24 do putpixel(x+i,y+8,z);
    for i:=0 to 2 do putpixel(x+i,y+8,z);
for i:=9 to 24 do putpixel(x+i,y+9,z);
for i:=9 to 24 do putpixel(x+i,y+10,z);
for i:=8 to 24 do putpixel(x+i,y+11,z);
{noge}
for i:=8 to 12 do putpixel(x+i,y+12,z);
    for i:=20 to 25 do putpixel(x+i,y+12,z);
for i:=9 to 11 do putpixel(x+i,y+13,z);
    for i:=23 to 26 do putpixel(x+i,y+13,z);
for i:=9 to 10 do putpixel(x+i,y+14,z);
    for i:=26 to 28 do putpixel(x+i,y+14,z);
for i:=10 to 11 do putpixel(x+i,y+15,z);
    for i:=28 to 29 do putpixel(x+i,y+15,z);
for i:=10 to 11 do putpixel(x+i,y+16,z);
    for i:=30 to 31 do putpixel(x+i,y+16,z);
for i:=11 to 12 do putpixel(x+i,y+17,z);
    for i:=31 to 32 do putpixel(x+i,y+17,z);
for i:=12 to 13 do putpixel(x+i,y+18,z);
    for i:=32 to 33 do putpixel(x+i,y+18,z);
end;
procedure crtaj0(x,y,z:integer);
{miruje}
var i:integer;
begin
for i:=26 to 26 do putpixel(x+i,y+0,z);
for i:=25 to 27 do putpixel(x+i,y+1,z);
for i:=24 to 28 do putpixel(x+i,y+2,z);
for i:=23 to 29 do putpixel(x+i,y+3,z);
for i:=22 to 30 do putpixel(x+i,y+4,z);
for i:=21 to 26 do putpixel(x+i,y+5,z);
    for i:=28 to 30 do putpixel(x+i,y+5,z);
for i:=20 to 25 do putpixel(x+i,y+6,z);
    for i:=29 to 31 do putpixel(x+i,y+6,z);
    for i:=7 to 10 do putpixel(x+i,y+6,z);
for i:=9 to 24 do putpixel(x+i,y+7,z);
    for i:=6 to 7 do putpixel(x+i,y+7,z);
for i:=9 to 24 do putpixel(x+i,y+8,z);
    for i:=5 to 6 do putpixel(x+i,y+8,z);
for i:=8 to 24 do putpixel(x+i,y+9,z);
    for i:=4 to 5 do putpixel(x+i,y+9,z);
for i:=8 to 24 do putpixel(x+i,y+10,z);
    for i:=4 to 5 do putpixel(x+i,y+10,z);
for i:=8 to 24 do putpixel(x+i,y+11,z);
    for i:=4 to 5 do putpixel(x+i,y+11,z);
{noge}
for i:=8 to 12 do putpixel(x+i,y+12,z);
    for i:=20 to 24 do putpixel(x+i,y+12,z);
    for i:=5 to 5 do putpixel(x+i,y+12,z);
for i:=9 to 11 do putpixel(x+i,y+13,z);
    for i:=21 to 23 do putpixel(x+i,y+13,z);
for i:=9 to 11 do putpixel(x+i,y+14,z);
    for i:=22 to 23 do putpixel(x+i,y+14,z);
for i:=10 to 11 do putpixel(x+i,y+15,z);
    for i:=22 to 23 do putpixel(x+i,y+15,z);
for i:=10 to 11 do putpixel(x+i,y+16,z);
    for i:=22 to 23 do putpixel(x+i,y+16,z);
for i:=11 to 12 do putpixel(x+i,y+17,z);
    for i:=22 to 23 do putpixel(x+i,y+17,z);
for i:=12 to 13 do putpixel(x+i,y+18,z);
    for i:=23 to 24 do putpixel(x+i,y+18,z);
end;
{osnovno-----------------------------------------------------------------}
procedure citajimena;
var i,k:integer;
    s:string;
    r:text;
begin
assign(r,'imena');
reset(r);
for i:=1 to 7 do begin
    readln(r,s);
    val(s,konj[i].col,k);
    readln(r,konj[i].ime);
    end;
close(r);
end;
procedure pisiimena;
var i:integer;
    r:text;
begin
assign(r,'imena');
rewrite(r);
for i:=1 to 7 do begin
    writeln(r,konj[i].col);
    writeln(r,konj[i].ime);
    end;
close(r);
end;
procedure citajformu;
{zapamceni rezultati, dodjeljuje koeficjente globalno}
var i,j,x,max:integer;
    r:file of longint;
    a:array[1..20]of longint;
    uspjeh,p:array[1..7]of integer;
    podjela:boolean;
begin
assign(r,'stats');
reset(r);
seek(r,filesize(r)-1);
read(r,kredit);
if kredit=0 then kredit:=(random(4)+2)*10;
{u kredit spremljeno stanje kredita}
close(r); reset(r);
x:=filesize(r)-1;
for i:=1 to x do read(r,a[i]);
close(r);
for i:=1 to 7 do begin konj[i].prvi:=0; konj[i].drugi:=0; end;
for i:=1 to 7 do begin
    for j:=1 to x do begin {broji koliko je puta konj bio 1. ili 2.}
        if (j mod 2=1) and (a[j]=i) then inc(konj[i].prvi);
        if (j mod 2=0) and (a[j]=i) then inc(konj[i].drugi);
    end;end;
for i:=1 to 7 do uspjeh[i]:=2*konj[i].prvi+konj[i].drugi;
{uspjeh = vrijednost 1. i 2. mjesta}
max:=20; j:=1;
repeat
{sortiranje po vrijednosti uspjeha}
podjela:=false;
for i:=1 to 7 do
    if uspjeh[i]=max then begin p[i]:=j; podjela:=true; end;
dec(max);
if podjela then inc(j);
until max=-1;
x:=4;
{koeficijent najboljeg je 4, penju se za po 2}
for i:=1 to 7 do begin
    for j:=1 to 7 do
        if p[j]=i then begin
           konj[j].k1:=x;
           konj[j].k2:=round(x/2);
           end;
    inc(x,2);
    end;
end;
{customize---------------------------------------------------------------}
procedure odaberi(x:integer);
var y:integer;
    s:string;
begin
y:=60+x*30;
str(x,s);
s:=s+'.';
outtextxy(100,y,s);
crtaj0(150,y-5,konj[x].col);
s:=konj[x].ime;
outtextxy(250,y,s);
end;
procedure urediime(x:integer);
var y:integer;
    s:string[25];
    c:char;
begin
y:=130;
setfillstyle(1,0);
bar(240,y-2,440,y+8);
s:='';
repeat
      c:=readkey;
      if ord(c)=0 then continue;
      if ord(c)=13 then break;
      if ord(c)=8 then delete(s,length(s),1);
      if ord(c)<>8 then s:=s+c;
      bar(240,y-2,440,y+8);
      settextjustify(2,2);
      outtextxy(440,y,s);
      settextjustify(0,2);
until ord(c)=13;
{posebno prilagodena procedura za unos vrijednosti u grafickom modu}
konj[x].ime:=s;
pisiimena;
end;
procedure urediboju(x:integer);
var y,i:integer;
    c:char;
    boja:array[1..5]of integer;
begin
boja[1]:=0; boja[2]:=8; boja[3]:=7; boja[4]:=6; boja[5]:=15;
for i:=1 to 5 do crtaj0(190+i*50,175,boja[i]);
setlinestyle(0,0,1);
setcolor(15);
y:=1;
repeat
for i:=1 to 5 do begin
    if y=i then setcolor(4) else setcolor(2);
    rectangle(185+i*50,170,225+i*50,200);
    end;
c:=readkey;
if ord(c)=75 then dec(y);
if ord(c)=77 then inc(y);
if y<1 then y:=1;
if y>5 then y:=5;
until ord(c)=13;
konj[x].col:=boja[y];
pisiimena;
end;
procedure uredi(x:integer);
var y,i:integer;
    s:string[25];
    c:char;
begin
setfillstyle(1,2);
bar(0,80,getmaxx,getmaxy);
setlinestyle(0,0,1);
setcolor(15);
rectangle(100,100,500,300);
y:=1;
repeat
if y=1 then setcolor(4) else setcolor(15);
s:='IME';
line(150,140,150+textwidth(s),140);
s:=s+'  :';
outtextxy(150,130,s);
setcolor(15);
outtextxy(240,130,konj[x].ime);
if y=2 then setcolor(4) else setcolor(15);
s:='BOJA';
line(150,190,150+textwidth(s),190);
s:=s+' :';
outtextxy(150,180,s);
crtaj0(240,175,konj[x].col);
if y=3 then setcolor(4) else setcolor(15);
s:='GOTOVO';
outtextxy(150,230,s);
line(150,240,150+textwidth(s),240);
c:=readkey;
if ord(c)=72 then dec(y);
if ord(c)=80 then inc(y);
if y<1 then y:=1;
if y>3 then y:=3;
until ord(c)=13;
case y of 1:urediime(x);
          2:urediboju(x);
          3:begin exitinfo:=2; exit; end;
     end;
end;
procedure customize;
{uredivanje imena i boje konja}
var i,y:integer;
    s:string;
    c:char;
begin
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
setcolor(15);
izlaztipka('k');
s:='ODABERI KONJA KOJEG CES UREDITI';
outtextxy(170,40,s);
setlinestyle(0,0,1);
setcolor(15);
line(170,50,170+textwidth(s),50);
y:=1;
repeat
for i:=1 to 7 do begin
    if y=i then setcolor(4) else setcolor(15);
    odaberi(i)
    end;
c:=readkey;
if ord(c)=72 then dec(y);
if ord(c)=80 then inc(y);
if y<1 then y:=1;
if y>7 then y:=7;
until ord(c) in [13,120,88];
if ord(c) in [120,88] then begin exitinfo:=1; exit; end;
exitinfo:=0;
repeat uredi(y); until exitinfo=2;
end;
{administracija----------------------------------------------------------}
procedure okvirzaodabir;
var s:string;
begin
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
settextstyle(0,0,1);
setcolor(15);
s:='ODABERI KONJA NA KOJEG SE KLADIS';
outtextxy(150,20,s);
setlinestyle(0,0,1);
line(150,30,150+textwidth(s),30);
outtextxy(50,70,'IME KONJA');
outtextxy(280,55,'U ZADNJIH 10 UTRKA');
outtextxy(270,70,'POBIJEDIO');
outtextxy(370,70,'2.MJESTO');
outtextxy(500,55,'KOEFICIJENTI');
outtextxy(475,70,'POBJEDA');
outtextxy(555,70,'2.MJESTO');
outtextxy(30,220,'KREDIT :');
str(kredit,s);
outtextxy(120,220,s);
line(30,80,620,80);
line(30,200,620,200);
izlaztipka('k');
end;
procedure forma(x:integer);
var y:integer;
    s:string;
begin
settextstyle(0,0,1);
y:=75+x*15;
str(x,s);
s:=s+'. ';
outtextxy(30,y,s);
outtextxy(50,y,konj[x].ime);
str(konj[x].prvi,s);
outtextxy(310,y,s);
str(konj[x].drugi,s);
outtextxy(390,y,s);
str(konj[x].k1,s);
s:='x '+s;
outtextxy(490,y,s);
str(konj[x].k2,s);
s:='x '+s;
outtextxy(570,y,s);
end;
procedure selekcija;
var i,y:integer;
    c:char;
begin
settextstyle(0,0,1);
y:=1;
repeat
for i:=1 to 7 do begin
    if y=i then setcolor(4) else setcolor(15);
    forma(i);
    end;
c:=readkey;
if ord(c)=72 then dec(y);
if ord(c)=80 then inc(y);
if y<1 then y:=1;
if y>7 then y:=7;
until ord(c) in [13,120,88];
if ord(c) in [120,88] then begin exitinfo:=4; exit; end;
w:=y;
{u w je spremljen odabrani konj}
end;
function ulaganje:boolean;
var y,k:integer;
    s:string[10];
    c:char;
begin
settextstyle(0,0,1);
setcolor(15);
outtextxy(30,255,'ULOG   :');
repeat
setfillstyle(1,0);
bar(120,253,200,263);
s:='';
      repeat
      c:=readkey;
      if not (ord(c) in [48..57,8,13,120,88]) then continue;
      if ord(c) in [120,88] then begin exitinfo:=5; exit; end;
      if ord(c)=13 then break;
      if ord(c)=8 then delete(s,length(s),1);
      if ord(c)<>8 then s:=s+c;
      bar(120,253,200,263);
      settextjustify(2,2);
      outtextxy(200,255,s);
      settextjustify(0,2);
      until ord(c)=13;
val(s,ulog,k);
until (ulog>=0) and (ulog<=kredit) and (k=0);
setfillstyle(1,2);
bar(120,253,200,263);
outtextxy(120,255,s);
outtextxy(120,255,s);
outtextxy(30,290,'DOBITAK :');
outtextxy(120,290,'za pobjedu');
str(ulog*konj[w].k1,s);
outtextxy(250,290,s);
outtextxy(120,310,'za 2.mjesto');
str(ulog*konj[w].k2,s);
outtextxy(250,310,s);
brisitipka('k'); {brise tekst tipke za izlaz jer tu nece vrijediti}
y:=1;
setlinestyle(0,0,1);
rectangle(480,220,585,290);
repeat
if y=1 then setcolor(4) else setcolor(15);
outtextxy(500,240,'POTVRDI');
if y=2 then setcolor(4) else setcolor(15);
outtextxy(500,260,'ODUSTANI');
c:=readkey;
if ord(c)=72 then y:=1;
if ord(c)=80 then y:=2;
until ord(c)=13;
if y=1 then ulaganje:=true;
if y=2 then ulaganje:=false;
end;
procedure administracija;
begin
repeat
exitinfo:=0;
okvirzaodabir;
selekcija;
if exitinfo=4 then begin exitinfo:=3; exit; end;
until (ulaganje) and (exitinfo<>5);
end;
{utrka----------------------------------------------------------------}
procedure postavistazu;
var i:integer;
begin
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
setlinestyle(0,0,3);
setcolor(15);
for i:=0 to 7 do begin
                 line(0,35+i*40,getmaxx,35+i*40);
                 if (i=w) or (i+1=w) then setcolor(4);
                 line(0,35+i*40,35,35+i*40);
                 setcolor(15);
                 end;
for i:=1 to 7 do crtaj0(0,45+(i-1)*40,konj[i].col);
line(35,35,35,315);
setlinestyle(1,0,3);
setcolor(2);
for i:=1 to 7 do line(35,45+(i-1)*40,35,65+(i-1)*40);
{resetka}
end;
function korak:integer;
{vraca random broj koraka konja}
var a:integer;
begin
a:=random(13)+1;
korak:=1;
if a mod 2=0 then korak:=2;
if a mod 3=0 then korak:=3;
if a=12 then korak:=1;
{omjer mogucih koraka 1:2:3 = 6:5:2 mogucnosti}
end;
procedure pomak(x:integer);
{spada pod utrka, pomice konje i ispisuje ih}
var i,j,y:integer;
    b:array[1..7]of integer;
begin
for i:=1 to 7 do b[i]:=korak;
{b je broj koraka za koji se pomakne konj u toj rundi}
for i:=3 downto 1 do begin
    for j:=1 to 7 do begin
        if b[j]=i then begin
           if konj[j].gotov then continue;
           y:=45+(j-1)*40;
           {y koordinata na ekranu za odabranog konja}
           bar(0,y,getmaxx,y+20);
           inc(konj[j].p,2);
           if konj[j].p>604 then konj[j].p:=604;
           if (konj[j].p=604) and (konj[j].gotov=false) then begin
                                  konj[j].f:=b[j];
                                  konj[j].gotov:=true;
                                  crtaj0(konj[j].p,y,konj[j].col);
                                  continue;
                                  end;
           case (x mod 4) of 0:crtaj1(konj[j].p,y,konj[j].col);
                             1:crtaj2(konj[j].p,y,konj[j].col);
                             2:crtaj3(konj[j].p,y,konj[j].col);
                             3:crtaj4(konj[j].p,y,konj[j].col);
                             end;
           dec(b[j]);
           {regulira da se istovremeno pomicu oni s istim korakom, 3,2,1}
           end;
        end;
    delay(brzina); {***BRZINA***, globalna varijabla, default 20}
    end;
end;
procedure utrka; {koristi: postavistazu, pomak}
var i,j,y,pozicija,kraj:integer;
    podjela:boolean;
    c:char;
begin
for i:=1 to 7 do with konj[i] do begin
    gotov:=false; provjeren:=false; f:=0; p:=0; poz:=0; end;
pozicija:=1; kraj:=0;
postavistazu;
setfillstyle(1,2);
bar(250,100,400,210); {mjesto za sljedeci prozorcic odabira}
setlinestyle(0,0,1);
setcolor(15);
rectangle(250,100,400,210);
y:=1;
repeat
if y=1 then setcolor(4) else setcolor(15);
outtextxy(280,130,'POKRENI UTRKU');
if y=2 then setcolor(4) else setcolor(15);
outtextxy(280,170,'ODUSTANI');
c:=readkey;
if ord(c)=72 then y:=1;
if ord(c)=80 then y:=2;
until ord(c)=13;
if y=2 then begin exitinfo:=6; exit; end;
{pokrenuta utrka}
postavistazu;
delay(1500);
j:=0;
repeat
pomak(j);
podjela:=false;
for i:=1 to 7 do begin
    if (konj[i].gotov) and (konj[i].provjeren=false) then begin
                       konj[i].poz:=pozicija;
                       konj[i].provjeren:=true;
                       inc(kraj);
                       podjela:=true;end;
    end;
if podjela then inc(pozicija);
inc(j);
if keypressed then c:=readkey;
{ucitava u prazno ako se za vrijeme utrke slucajno nesto pritisne}
until kraj=7;
{gotova utrka}
setlinestyle(0,0,1); setcolor(15);
rectangle(500,325,580,345);
setcolor(4);
outtextxy(520,330,'DALJE');
repeat c:=readkey; until ord(c)=13;
end;
{rezultat------------------------------------------------------------}
procedure poredavanje;
{analizira zavrsetak i raspodjeljuje pozicije}
var i,j,k:integer;
begin
for i:=1 to 7 do begin
    for j:=1 to 6 do begin
        for k:=j+1 to 7 do begin
            if (konj[j].poz=i) and (konj[k].poz=i) then begin
               if konj[j].f>konj[k].f then begin
                  inc(konj[k].poz); inc(konj[k].f,3) end
                                      else begin
                   inc(konj[j].poz); inc(konj[j].f,3) end;
end;end;end;end;
for i:=1 to 7 do begin
    for j:=1 to 7 do if konj[j].poz=i then poredak[i]:=j; end;
end;
procedure rekord; {pamti rezultate zadnjih 10 utrka}
var i,j:integer;
    r:file of longint;
    a:array[1..20]of longint;
begin
assign(r,'stats');
reset(r);
j:=filesize(r)-1;
if j<20 then begin
   for i:=1 to j do read(r,a[i]);
   end;
if j=20 then begin
   read(r,a[i]); read(r,a[i]);
   {u prazno prva dva da ih izbrise}
   for i:=1 to 18 do read(r,a[i]);
   dec(j,2);
   end;
for i:=1 to 7 do if poredak[1]=i then a[j+1]:=i;
for i:=1 to 7 do if poredak[2]=i then a[j+2]:=i;
rewrite(r);
for i:=1 to j+2 do write(r,a[i]);
write(r,kredit);
close(r);
end;
procedure rezultat;
{ispisuje rezultat}
var i:integer;
    dobitak:longint;
    s:string;
    c:char;
begin
poredavanje;
if poredak[1]=w then begin
   dobitak:=round(ulog*konj[w].k1)-ulog;
   inc(kredit,dobitak);
   rekord;
   end;
if poredak[2]=w then begin
   dobitak:=round(ulog*konj[w].k2)-ulog;
   inc(kredit,dobitak);
   rekord;
   end;
if (poredak[1]<>w) and (poredak[2]<>w) then
   begin
   dec(kredit,ulog);
   rekord;
   end;
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
settextstyle(0,0,1);
setcolor(15);
s:='POREDAK UTRKE';
outtextxy(170,50,s);
setlinestyle(0,0,1);
line(150,60,190+textwidth(s),60);
for i:=1 to 7 do begin
    str(i,s);
    s:=s+'. ';
    s:=s+konj[poredak[i]].ime;
    if poredak[i]=w then setcolor(4) else setcolor(15);
    outtextxy(150,60+i*15,s);
    end;
setcolor(15);
if (poredak[1]=w) or (poredak[2]=w) then begin
                                    str(dobitak+ulog,s);
                                    s:='DOBITAK :  '+s;
                                    end;
if (poredak[1]<>w) and (poredak[2]<>w) then begin
                                       str(ulog,s);
                                       s:='GUBITAK :  '+s;
                                       end;
outtextxy(150,240,s);
str(kredit,s);
s:='KREDIT  :  '+s;
outtextxy(150,280,s);
rectangle(520,300,580,330);
setcolor(4);
outtextxy(530,310,'DALJE');
repeat c:=readkey; until ord(c)=13;
end;
{konjmeni----------------------------------------------------------}
procedure konjmeni;
var y:integer;
    s:string;
    c:char;
begin
exitinfo:=0;
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
settextstyle(0,0,2);
setcolor(15);
s:='KONJSKE UTRKE';
outtextxy(160,70,s);
setlinestyle(0,0,3);
line(160,90,160+textwidth(s),90);
strelice;
crtaj0(70,50,0);
crtaj0(450,50,8);
crtaj0(70,280,8);
crtaj0(450,280,0);
settextstyle(0,0,1);
y:=1;
repeat
if y=1 then setcolor(4) else setcolor(15);
outtextxy(200,150,'UTRKE');
if y=2 then setcolor(4) else setcolor(15);
outtextxy(200,200,'UREDI KONJE');
if y=3 then setcolor(4) else setcolor(15);
outtextxy(200,250,'IZLAZ');
c:=readkey;
if ord(c)=72 then dec(y);
if ord(c)=80 then inc(y);
if y<1 then y:=1;
if y>3 then y:=3;
until ord(c)=13;
case y of 1:begin
                 repeat
                       citajformu;
                       citajimena;
                       administracija;
                       if exitinfo=3 then break;
                       utrka;
                       if exitinfo=6 then continue;
                       rezultat;
                 until exitinfo=3;
                 end;
          2:begin
                 citajformu;
                 citajimena;
                 repeat
                 customize;
                 until exitinfo=1;
                 end;
          3:begin
                 exitinfo:=7;
                 exit;
                 end;
          end;
end;
procedure konji;
begin
repeat konjmeni; until exitinfo=7;
exitinfo:=1;
end;
{**********************************
**********     POKER     **********
***********************************}
{poker-------------------------------------------------------------------}
procedure kara(x,y:integer);
var i:integer;
begin
for i:=7 to 7 do putpixel(x+i,y+0,4);
for i:=6 to 8 do putpixel(x+i,y+1,4);
for i:=5 to 9 do putpixel(x+i,y+2,4);
for i:=4 to 10 do putpixel(x+i,y+3,4);
for i:=3 to 11 do putpixel(x+i,y+4,4);
for i:=2 to 12 do putpixel(x+i,y+5,4);
for i:=1 to 13 do putpixel(x+i,y+6,4);
for i:=0 to 14 do putpixel(x+i,y+7,4);
for i:=1 to 13 do putpixel(x+i,y+8,4);
for i:=2 to 12 do putpixel(x+i,y+9,4);
for i:=3 to 11 do putpixel(x+i,y+10,4);
for i:=4 to 10 do putpixel(x+i,y+11,4);
for i:=5 to 9 do putpixel(x+i,y+12,4);
for i:=6 to 8 do putpixel(x+i,y+13,4);
for i:=7 to 7 do putpixel(x+i,y+14,4);
end;
procedure pik(x,y:integer);
var i:integer;
begin
for i:=7 to 7 do putpixel(x+i,y+0,0);
for i:=6 to 8 do putpixel(x+i,y+1,0);
for i:=5 to 9 do putpixel(x+i,y+2,0);
for i:=4 to 10 do putpixel(x+i,y+3,0);
for i:=3 to 11 do putpixel(x+i,y+4,0);
for i:=2 to 12 do putpixel(x+i,y+5,0);
for i:=1 to 13 do putpixel(x+i,y+6,0);
for i:=0 to 14 do putpixel(x+i,y+7,0);
for i:=0 to 14 do putpixel(x+i,y+8,0);
for i:=0 to 14 do putpixel(x+i,y+9,0);
for i:=1 to 13 do putpixel(x+i,y+10,0);
for i:=2 to 5 do putpixel(x+i,y+11,0);
    for i:=9 to 12 do putpixel(x+i,y+11,0);
    for i:=7 to 7 do putpixel(x+i,y+11,0);
for i:=7 to 7 do putpixel(x+i,y+12,0);
for i:=6 to 8 do putpixel(x+i,y+13,0);
for i:=5 to 9 do putpixel(x+i,y+14,0);
end;
procedure herc(x,y:integer);
var i:integer;
begin
for i:=2 to 5 do putpixel(x+i,y+1,4);
    for i:=9 to 12 do putpixel(x+i,y+1,4);
for i:=1 to 6 do putpixel(x+i,y+2,4);
    for i:=8 to 13 do putpixel(x+i,y+2,4);
for i:=0 to 14 do putpixel(x+i,y+3,4);
for i:=0 to 14 do putpixel(x+i,y+4,4);
for i:=0 to 14 do putpixel(x+i,y+5,4);
for i:=0 to 14 do putpixel(x+i,y+6,4);
for i:=1 to 13 do putpixel(x+i,y+7,4);
for i:=2 to 12 do putpixel(x+i,y+8,4);
for i:=3 to 11 do putpixel(x+i,y+9,4);
for i:=4 to 10 do putpixel(x+i,y+10,4);
for i:=5 to 9 do putpixel(x+i,y+11,4);
for i:=6 to 8 do putpixel(x+i,y+12,4);
for i:=7 to 7 do putpixel(x+i,y+13,4);
end;
procedure tref(x,y:integer);
var i:integer;
begin
for i:=5 to 9 do putpixel(x+i,y+1,0);
for i:=4 to 10 do putpixel(x+i,y+2,0);
for i:=4 to 10 do putpixel(x+i,y+3,0);
for i:=4 to 10 do putpixel(x+i,y+4,0);
for i:=5 to 9 do putpixel(x+i,y+5,0);
for i:=6 to 8 do putpixel(x+i,y+6,0);
for i:=1 to 4 do putpixel(x+i,y+7,0);
    for i:=10 to 13 do putpixel(x+i,y+7,0);
    for i:=6 to 8 do putpixel(x+i,y+7,0);
for i:=0 to 14 do putpixel(x+i,y+8,0);
for i:=0 to 14 do putpixel(x+i,y+9,0);
for i:=0 to 14 do putpixel(x+i,y+10,0);
for i:=1 to 5 do putpixel(x+i,y+11,0);
    for i:=9 to 13 do putpixel(x+i,y+11,0);
    for i:=7 to 7 do putpixel(x+i,y+11,0);
for i:=7 to 7 do putpixel(x+i,y+12,0);
for i:=6 to 8 do putpixel(x+i,y+13,0);
for i:=5 to 9 do putpixel(x+i,y+14,0);
end;
procedure znakovi;
{koristeni zankovi na kartama i imena kombinacija}
begin
znak[8]:='7';
znak[7]:='8';
znak[6]:='9';
znak[5]:='10';
znak[4]:='J';
znak[3]:='Q';
znak[2]:='K';
znak[1]:='A';
imas[8]:='straight flush';
imas[7]:='four of a kind';
imas[6]:='full house';
imas[5]:='flush';
imas[4]:='straight';
imas[3]:='three of a kind';
imas[2]:='two pair';
imas[1]:='pair';
imas[0]:='high card';
end;
procedure deal(var w:array of karta; i:integer);
{i=koja karta po redu, w=koji spil}
var x,y,j,k:integer;
    postoji:boolean;
begin
repeat
      x:=random(4)+1; {boja}
      y:=random(8)+1; {znak}
      j:=x*10+y;      {memorirana kombinacija karte}
      postoji:=false;
      for k:=1 to 32 do if t[k]=j then postoji:=true;
until postoji=false;
w[i-1].b:=x;
w[i-1].z:=y;
t[tb]:=j;
inc(tb);  {tb je globalna varijabla za poziciju u talonu}
end;
procedure vidi(w:array of karta; x,y:integer);
var i:integer;
begin
setfillstyle(1,15);
settextstyle(0,0,1);
for i:=0 to 4 do begin
    bar(x+i*80,y,x+60+i*80,y+70);
    case w[i].b of 1:begin herc(x+22+i*80,y+23); setcolor(4); end;
                     2:begin pik(x+22+i*80,y+23); setcolor(0); end;
                     3:begin kara(x+22+i*80,y+23); setcolor(4); end;
                     4:begin tref(x+22+i*80,y+23); setcolor(0); end;
                     end;
    settextjustify(0,2); outtextxy(x+5+i*80,y+5,znak[w[i].z]);
    settextjustify(2,0); outtextxy(x+55+i*80,y+65,znak[w[i].z]);
    end;
    settextjustify(0,2);
end;
procedure sklopljenekarte(x,y:integer);
var i:integer;
begin
for i:=0 to 4 do begin
    setfillstyle(6,9);
    bar(x+i*80,y,x+60+i*80,y+70);
    end;
setlinestyle(1,0,1);
setcolor(15);
rectangle(20,10,450,330);
end;
{odredivanje handa-------------------------------------------------}
function analiza(w:array of karta):integer;
var i,j:integer; x,y:array[1..5]of integer;
    stfl,four,fuhu,flus,stra,tree,topa,pair:boolean;
    herc,kara,tref,pik:integer;
    broj:array[1..8]of integer;
begin
stfl:=false; four:=false; fuhu:=false; flus:=false;
stra:=false; tree:=false; topa:=false; pair:=false;
herc:=0; kara:=0; tref:=0; pik:=0;
for i:=1 to 8 do broj[i]:=0;
{ucitavanje}
for i:=1 to 5 do begin
    x[i]:=w[i-1].b; y[i]:=w[i-1].z; end;
for i:=1 to 5 do begin
    if x[i]=1 then inc(herc); if x[i]=2 then inc(pik);
    if x[i]=3 then inc(kara); if x[i]=4 then inc(tref);
    inc(broj[y[i]]); {broji kojih znakova ima koliko}
    end;
{flush}
if (herc=5)or(kara=5)or(tref=5)or(pik=5) then flus:=true;
{straight}
for i:=1 to 4 do begin
    stra:=true;
    for j:=i to i+4 do if broj[j]=0 then stra:=false;
    if stra then break;
    end;
{straight flush}
if (stra and flus) then stfl:=true;
for i:=1 to 8 do begin
    {pair, two pair}
    if broj[i]=2 then begin
       if pair then topa:=true; pair:=true; end;
    {3 of a kind, full house}
    if broj[i]=3 then begin
       tree:=true;
       for j:=1 to 8 do if broj[j]=2 then fuhu:=true; end;
    {4 of a kind}
    if broj[i]=4 then four:=true;
    end;
analiza:=0; {kad nema nista}
if stfl then analiza:=8 else
if four then analiza:=7 else
if fuhu then analiza:=6 else
if flus then analiza:=5 else
if stra then analiza:=4 else
if tree then analiza:=3 else
if topa then analiza:=2 else
if pair then analiza:=1;
end;
function duel(a,b:array of karta):integer;
{usporeduje 2 spila, bitan je redosljed upisivanja spilova}
var i,j:integer;
    h:array[1..4]of integer;
    x,y:array[1..5]of integer;
    broj:array[1..8]of integer;
begin
for i:=1 to 4 do h[i]:=0;
for i:=1 to 8 do broj[i]:=0;
duel:=0;
if analiza(a)>analiza(b) then duel:=1;  {najjaca analiza je 8}
if analiza(a)<analiza(b) then duel:=2;
if analiza(a)=analiza(b) then begin
   begin
   for i:=1 to 5 do begin
       x[i]:=a[i-1].b; y[i]:=a[i-1].z; inc(broj[a[i-1].z]); end;
   if analiza(a) in [8,5,4,0] then
      for i:=1 to 8 do if broj[i]>0 then begin
          if h[1]>0 then begin h[3]:=i; break; end;
          h[1]:=i; end;
   if analiza(a)=7 then
      for i:=1 to 8 do begin
          if broj[i]=4 then h[1]:=i;
          if broj[i]=1 then h[3]:=i; end;
   if analiza(a) in [6,3] then begin
      for i:=1 to 8 do if broj[i]=3 then h[1]:=i;
      for i:=1 to 8 do begin
          if (broj[i]>0) and (broj[i]<>3) then begin h[3]:=i; break; end; end;
      end;
   if analiza(a)=2 then
      for i:=1 to 8 do if broj[i]=2 then begin
          if h[1]>0 then begin h[3]:=i; break; end;
          h[1]:=i; end;
   if analiza(a)=1 then begin
      for i:=1 to 8 do if broj[i]=2 then h[1]:=i;
      for i:=1 to 8 do begin
          if (broj[i]>0) and (broj[i]<>2) then begin h[3]:=i; break; end; end;
      end;
   end;
   for i:=1 to 8 do broj[i]:=0;
   begin
   for i:=1 to 5 do begin
       x[i]:=b[i-1].b; y[i]:=b[i-1].z; inc(broj[b[i-1].z]); end;
   if analiza(b) in [8,5,4,0] then
      for i:=1 to 8 do if broj[i]>0 then begin
          if h[2]>0 then begin h[4]:=i; break; end;
          h[2]:=i; end;
   if analiza(b)=7 then
      for i:=1 to 8 do begin
          if broj[i]=4 then h[2]:=i;
          if broj[i]=1 then h[4]:=i; end;
   if analiza(b) in [6,3] then begin
      for i:=1 to 8 do if broj[i]=3 then h[2]:=i;
      for i:=1 to 8 do begin
          if (broj[i]>0) and (broj[i]<>3) then begin h[4]:=i; break; end; end;
      end;
   if analiza(b)=2 then
      for i:=1 to 8 do if broj[i]=2 then begin
          if h[2]>0 then begin h[4]:=i; break; end;
          h[2]:=i; end;
   if analiza(b)=1 then begin
      for i:=1 to 8 do if broj[i]=2 then h[2]:=i;
      for i:=1 to 8 do begin
          if (broj[i]>0) and (broj[i]<>2) then begin h[4]:=i; break; end; end;
      end;
   end;
if h[1]<h[2] then duel:=1;
if h[1]>h[2] then duel:=2;
if h[1]=h[2] then begin if h[3]<=h[4] then duel:=1;
                        if h[3]>h[4] then duel:=2; end;
end;
end;
{igra--------------------------------------------------------------------}
procedure uzmipare;
var r:file of longint;
begin
assign(r,'stats');
reset(r);
seek(r,filesize(r)-1);
read(r,kredit);
close(r);
end;
procedure spremipare;
var r:file of longint;
begin
assign(r,'stats');
reset(r);
seek(r,filesize(r)-1);
truncate(r);
write(r,kredit);
close(r);
end;
procedure protivnik;
var i,j,x:integer;
begin
x:=random(100)+1;
if x in [25..30] then begin
                     for i:=1 to 100 do begin
                         tb:=20;
                         for j:=1 to 5 do deal(m,j);
                         if duel(m,b)=1 then b:=m;
                         end;
                     end
                else begin
                     x:=(x mod 10)-2;
                     if x<0 then x:=0;
                     {tezina protivnika}
                     for i:=1 to x do begin
                         tb:=20;
                         for j:=1 to 5 do deal(m,j);
                         if duel(m,b)=1 then b:=m;
                         end;
                     end;
end;
procedure okvir;
var s:string;
begin
setfillstyle(1,2);
bar(100,140,270,170);
settextstyle(0,0,1);
setlinestyle(1,0,1);
setcolor(15);
rectangle(100,140,270,170);
s:='POT :';
outtextxy(120,150,s);
str(pot,s);
outtextxy(170,150,s);
setfillstyle(1,2);
bar(479,29,621,131);
rectangle(480,30,620,130);
s:='KREDIT :';
outtextxy(500,40,s);
str(kredit,s);
settextjustify(2,2);
outtextxy(580,60,s);
settextjustify(0,2);
outtextxy(500,90,'ULOG :');
setfillstyle(1,0);
bar(500,108,580,118);
str(ulog,s);
settextjustify(2,2);
outtextxy(580,110,s);
settextjustify(0,2);
izlaztipka('p');
end;
procedure kladenje(x:integer);
var k:integer;
    s:string[10];
    c:char;
begin
izlaztipka('p');
if x=1 then begin
   inc(kredit,ulog);
   dec(pot,2*ulog);
   okvir;
   end;
{ulazni parametar 1 znaci da je vec ulozeno
pa kad ponovno ulaze treba pokazat stvarno stanje kredita}
setlinestyle(0,0,3);
setcolor(4);
rectangle(480,80,620,130);
setfillstyle(1,0);
setcolor(15);
repeat
bar(500,108,580,118);
s:='';
      repeat
      c:=readkey;
      if not (ord(c) in [48..57,8,13,120,88]) then continue;
      if ord(c) in [120,88] then begin okvir; exitinfo:=1; break; end;
      if ord(c)=13 then break;
      if ord(c)=8 then delete(s,length(s),1);
      if ord(c)<>8 then s:=s+c;
      bar(500,108,580,118);
      settextjustify(2,2);
      outtextxy(580,110,s);
      settextjustify(0,2);
      until ord(c)=13;
if exitinfo=1 then begin ulog:=0; break; end;
val(s,ulog,k);
until (ulog>=0) and (ulog<=kredit) and (k=0);
dec(kredit,ulog);
inc(pot,2*ulog);
setcolor(15);
okvir;
exitinfo:=0;
end;
procedure mjenjaj(x,z:integer);
var i,k,e,y:integer;
    c:char;
    j:array[1..5]of integer;
begin
setcolor(0);
settextjustify(2,2);
outtextxy(425,z-20,imas[analiza(a)]);
settextjustify(0,2);
for i:=1 to 5 do j[i]:=0;
repeat
      y:=2;
      repeat
            setlinestyle(0,0,1);
            setcolor(15);
            rectangle(480,210,620,290);
            if y=1 then setcolor(4) else setcolor(15);
            outtextxy(500,220,'DIJELI KARTE');
            if y=2 then setcolor(4) else setcolor(15);
            outtextxy(500,240,'MIJENJAJ ULOG');
            if y=3 then setcolor(4) else setcolor(15);
            outtextxy(500,260,'ODUSTANI');
            repeat
                  c:=readkey;
                  val(c,k,e);
            until (ord(c) in [13,72,80,120,88]) or ((e=0) and (k>0) and (k<6));
            if ord(c) in [120,88] then begin exitinfo:=2; exit; end;
            case j[k] of 0:j[k]:=1;
                         1:j[k]:=0; end;
            case j[k] of 0:setcolor(2);
                         1:setcolor(15); end;
            settextstyle(0,0,1);
            outtextxy(x+15+(k-1)*80,z+90,'HOLD');
            if ord(c)=72 then dec(y);
            if ord(c)=80 then inc(y);
            if y<1 then y:=1;
            if y>3 then y:=3;
      until ord(c)=13;
case y of 2:kladenje(1);
          3:begin inc(kredit,ulog); exitinfo:=1; exit; end;
          end;
until (y=1) and (ulog>0);
setcolor(2);
settextjustify(2,2);
outtextxy(425,z-20,imas[analiza(a)]);
settextjustify(0,2);
for i:=1 to 5 do if j[i]=0 then deal(a,i);
setcolor(0);
settextjustify(2,2);
outtextxy(425,z-20,imas[analiza(a)]);
settextjustify(0,2);
end;
procedure povecajulog;
var y,kontrolakladenja:integer;
    c:char;
begin
brisitipka('p');
setfillstyle(1,2);
bar(480,210,620,290);
setcolor(15);
rectangle(480,210,620,270);
kontrolakladenja:=2;
y:=1;
repeat
      repeat
            brisitipka('p');
            if y=1 then setcolor(4) else setcolor(15);
            outtextxy(500,220,'POKAZI KARTE');
            if y=2 then setcolor(4) else setcolor(15);
            outtextxy(500,240,'POVECAJ ULOG');
            repeat
                  c:=readkey;
            until ord(c) in [13,72,80];
            if ord(c)=72 then y:=1;
            if ord(c)=80 then y:=2;
      until ord(c)=13;
if y=2 then begin kladenje(kontrolakladenja); kontrolakladenja:=1; end;
until y=1;
end;
procedure ishod(x:integer);
var y:integer;
    s:string;
    c:char;
begin
brisitipka('p');
setcolor(0);
settextjustify(2,2);
outtextxy(425,x+85,imas[analiza(b)]);
settextjustify(0,2);
case duel(a,b) of 1: begin inc(kredit,pot); s:='POBIJEDIO SI'; end;
                  2: s:='IZGUBIO SI';
                  end;
outtextxy(500,160,s);
spremipare;
setfillstyle(1,2);
bar(480,210,620,290);
setcolor(15);
rectangle(480,210,620,270);
y:=1;
repeat
     if y=1 then setcolor(4) else setcolor(15);
     outtextxy(500,220,'NOVA PARTIJA');
     if y=2 then setcolor(4) else setcolor(15);
     outtextxy(500,240,'PREKINI');
     repeat
           c:=readkey;
     until ord(c) in [13,72,80];
     if ord(c)=72 then y:=1;
     if ord(c)=80 then y:=2;
until ord(c)=13;
if y=2 then begin exitinfo:=2; exit; end;
end;
procedure postavke;
var i:integer;
begin
znakovi;
uzmipare;
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
tb:=1;
for i:=1 to 32 do t[i]:=0;
if ulog>kredit then ulog:=0;
if kredit=0 then kredit:=(random(4)+2)*10;
dec(kredit,ulog);
pot:=2*ulog;
{pamti zadnji ulog i odmah ga ulaze}
end;
procedure igra;
var i:integer;
begin
repeat
      exitinfo:=0;
      postavke;
      sklopljenekarte(45,30);
      okvir;
      sklopljenekarte(45,210);
      delay(500);
      for i:=1 to 5 do deal(a,i);
      vidi(a,45,210);
      for i:=1 to 5 do deal(b,i);
      mjenjaj(45,210);
      if exitinfo=2 then exit;
until exitinfo=0;
vidi(a,45,210);
povecajulog;
protivnik;
vidi(b,45,30);
ishod(30);
end;
procedure handslist;
var s:string;
    c:char;
begin
bar(0,0,getmaxx,getmaxy);
s:='POPIS KOMBINACIJA U POKERU PREMA JACINI';
outtextxy(150,30,s);
line(150,40,150+textwidth(s),40);
outtextxy(100,70,'1. STRAIGHT FLUSH');
line(100,80,300,80);
outtextxy(150,85,'5 KARATA U NIZU U ISTOJ BOJI');
outtextxy(100,100,'2. FOUR OF A KIND (POKER)');
line(100,110,300,110);
outtextxy(150,115,'4 KARTE S ISTIM ZNAKOM');
outtextxy(100,130,'3. FULL HOUSE');
line(100,140,300,140);
outtextxy(150,145,'3 KARTE S ISTIM ZNAKOM + 2 KARTE S ISTIM ZNAKOM');
outtextxy(100,160,'4. FLUSH');
line(100,170,300,170);
outtextxy(150,175,'5 KARATA U ISTOJ BOJI');
outtextxy(100,190,'5. STRAIGHT');
line(100,200,300,200);
outtextxy(150,205,'5 KARATA U NIZU');
outtextxy(100,220,'6. THREE OF A KIND');
line(100,230,300,230);
outtextxy(150,235,'3 KARTE S ISTIM ZNAKOM');
outtextxy(100,250,'7. TWO PAIR');
line(100,260,300,260);
outtextxy(150,265,'2 PUTA PO 2 KARTE S ISTIM ZNAKOM ');
outtextxy(100,280,'8. PAIR');
line(100,290,300,290);
outtextxy(150,295,'2 KARTE S ISTIM ZNAKOM');
outtextxy(100,310,'9. HIGH CARD');
line(100,320,300,320);
outtextxy(150,325,'NITI JEDNA OD GORE NAVEDENIH KOMBINACIJA');
rectangle(520,305,610,330);
setcolor(4);
outtextxy(540,315,'DALJE');
repeat c:=readkey; until ord(c)=13;
end;
procedure uputepoker;
var y:integer;
    s:string;
    c:char;
begin
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
setlinestyle(0,0,1);
setcolor(15);
s:='UPUTE';
outtextxy(250,30,s);
line(250,40,250+textwidth(s),40);
outtextxy(80,70,'IGRA SE FIVE CARD DRAW POKER U KOJEM DOBIJES PET KARATA');
line(143,80,303,80);
outtextxy(80,85,'I MOZES ZAMIJENITI SVE ILI ODREDENE KARTE KAKO BI IMAO');
outtextxy(80,100,'STO BOLJU KOMBINACIJU.');
outtextxy(80,115,'');
outtextxy(80,130,'BIRAS KARTE KOJE CES OSTAVITI KOD SEBE  (HOLD) !!');
line(249,140,309,140);
outtextxy(80,145,'');
outtextxy(80,160,'KARTE BIRAS PRITISKOM BROJEVA OD 1 DO 5');
line(255,170,390,170);
outtextxy(80,175,'');
outtextxy(80,190,'BROJ 1 ODGOVARA PRVOJ KARTI S LIJEVA.');
outtextxy(80,205,'BROJ 5 ODGOVARA ZADNJOJ KARTI S LIJEVA.');
outtextxy(80,220,'');
outtextxy(80,235,'OBRATI PAZNJU NA TO KOLIKO SI ULOZIO U PARTIJI.');
outtextxy(80,250,'');
outtextxy(80,265,'SRETNO S KARTAMA !');
y:=2;
rectangle(440,290,600,340);
repeat
      if y=1 then setcolor(4)else setcolor(15);
      outtextxy(450,300,'POPIS KOMBINACIJA');
      if y=2 then setcolor(4)else setcolor(15);
      outtextxy(450,320,'NATRAG U IGRU');
      repeat
            c:=readkey;
      until ord(c) in [13,72,80];
      if ord(c)=72 then y:=1;
      if ord(c)=80 then y:=2;
until ord(c)=13;
case y of 1:handslist;
          2:exit;
          end;
end;
procedure pokermeni;
var y:integer;
    s:string;
    c:char;
begin
exitinfo:=0;
ulog:=0;
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
settextstyle(0,0,2);
setcolor(15);
s:='POKER';
outtextxy(210,70,s);
setlinestyle(0,0,3);
line(210,90,210+textwidth(s),90);
strelice;
tref(100,50);
kara(450,50);
herc(100,280);
pik(450,280);
settextstyle(0,0,1);
y:=2;
repeat
if y=1 then setcolor(4) else setcolor(15);
outtextxy(200,150,'ODIGRAJ PARTIJU');
if y=2 then setcolor(4) else setcolor(15);
outtextxy(200,200,'PROCITAJ UPUTE');
if y=3 then setcolor(4) else setcolor(15);
outtextxy(200,250,'IZLAZ');
c:=readkey;
if ord(c)=72 then dec(y);
if ord(c)=80 then inc(y);
if y<1 then y:=1;
if y>3 then y:=3;
until ord(c)=13;
case y of 1: repeat igra until exitinfo=2;
          2: uputepoker;
          3: begin exitinfo:=3; exit; end;
          end;
end;
procedure poker;
begin
repeat
pokermeni;
until exitinfo=3;
exitinfo:=1;
end;
{*******************************************
**********     GLAVNI PROGRAM     **********
********************************************}
{program-----------------------------------------------------}
procedure provjeradatoteka;
var r1:file of longint;
    r2:text;
    i,k:integer;
    j:longint;
    s:string;
begin
assign(r1,'stats');
assign(r2,'imena');
{$i-}
reset(r1);
if ioresult<>0 then begin
   rewrite(r1);
   j:=100;
   write(r1,j);
   end;
{$i+}
close(r1);
{$i-}
reset(r2);
if ioresult<>0 then begin
   rewrite(r2);
   s:='08761580';
   for i:=1 to 4 do begin writeln(r2,s[i]); writeln(r2,'konj ',i); end;
   write(r2,s[5]); writeln(r2,s[6]); writeln(r2,'konj 5');
   for i:=6 to 7 do begin writeln(r2,s[i+1]); writeln(r2,'konj ',i); end;
   end;
{$i+}
close(r2);
end;
procedure setup;
{podesenje brzine trcanja na razlicitim racunalima}
var y:integer;
    c:char;
begin
c:=readkey;
if c='E' then c:=readkey;
if c='T' then c:=readkey;
if c='U' then c:=readkey;
if c='P' then begin
restorecrtmode;
clrscr;
textcolor(15);
gotoxy(10,5); write('max brzina konja : 5');
gotoxy(10,6); write('min brzina konja : 85');
y:=1;
repeat
      gotoxy(10,10); write('trenutna brzina : ',brzina);
      repeat
            if y=1 then textcolor(4) else textcolor(15);
            gotoxy(12,15); write('nova brzina : ');
            if y=2 then textcolor(4) else textcolor(15);
            gotoxy(12,17); write('izlaz');
            gotoxy(80,25);
            c:=readkey;
            if ord(c)=72 then y:=1;
            if ord(c)=80 then y:=2;
      until ord(c)=13;
      if y=1 then
             repeat gotoxy(12,15); delline; insline;
                    gotoxy(12,15); write('nova brzina : ');
                    readln(brzina);
             until brzina in [5..85];
until y=2;
setgraphmode(1);
end;
{vraca natrag u grafiku}
end;
procedure glavnimeni;
var y:integer;
    s:string;
    c:char;
begin
exitinfo:=0;
setfillstyle(1,2);
bar(0,0,getmaxx,getmaxy);
settextstyle(0,0,2);
setcolor(15);
s:='IZAZOV';
outtextxy(200,70,s);
setlinestyle(0,0,3);
line(200,90,200+textwidth(s),90);
strelice;
settextstyle(0,0,1);
y:=2;
repeat
if y=1 then setcolor(4) else setcolor(15);
outtextxy(200,150,'KONJSKE UTRKE');
if y=2 then setcolor(4) else setcolor(15);
outtextxy(200,200,'POKER');
if y=3 then setcolor(4) else setcolor(15);
outtextxy(200,250,'IZLAZ');
c:=readkey;
if ord(c)=72 then dec(y);
if ord(c)=80 then inc(y);
if y<1 then y:=1;
if y>3 then y:=3;
if c='S' then begin setup; exit; end;
{za S izleti u setup i vrati se na pocetak cijele procedure}
until ord(c)=13;
case y of 1: konji;
          2: poker;
          3: begin exitinfo:=2; exit; end;
          end;
end;
{glavni program---------------------------------------------------------}
begin
randomize;
provjeradatoteka;
graphdriver:=vga;
graphmode:=1;
initgraph(graphdriver,graphmode,'');
if graphresult <> 0 then begin
   clrscr;
   writeln;writeln('NEDOSTAJE GRAFICKI DRIVER');
   writeln;writeln('EGAVGA.BGI');
   delay(5000);
   halt;
   end;
brzina:=20;
exitinfo:=0;
repeat glavnimeni; until exitinfo=2;
closegraph;
end.
