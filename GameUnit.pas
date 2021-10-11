unit GameUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ExtCtrls, StdCtrls, ComCtrls, XPMan;

type
  mas=array [1..255] of string;
  TGameForm = class(TForm)
    MainMenu1: TMainMenu;
    Timer1: TTimer;
    Memo1: TMemo;
    N3: TMenuItem;
    N4: TMenuItem;
    XPManifest1: TXPManifest;
    Field: TImage;
    N1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Timer2: TTimer;
    N2: TMenuItem;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GameForm: TGameForm;
  buf,winimg:TBitmap;
  path,login:string;
  best:textfile;
  map:array [0..3,0..3] of integer;
  map2:array [0..3,0..3] of integer;
  img:array [0..11] of TBitmap;
  score,bestscore,textscore,timei,steps:integer;
  n:boolean;
  logs:mas;
  re,nn:integer;

implementation

uses Unit1;


{$R *.dfm}

procedure TGameForm.FormCreate(Sender: TObject);
var
 i,j,s,l:integer;
begin
 re:=1;
 nn:=0;
 Timei:=0;
 Steps:=0;
 AssignFile(best,'best.txt');
 Reset(best);
 Read(best,login);
 Read(best,textscore);
 CloseFile(best);
 bestscore:=textscore;
 score:=0;
 Field.Canvas.Brush.Color:=clBtnFace;
 Field.Canvas.Rectangle(0,0,449,45);
 Field.Canvas.Font.Size:=12;
 Field.Canvas.Font.Style:=[fsBold];
 if score>bestscore then
  bestscore:=score;
 Field.Canvas.TextOut((ClientWidth-Field.Canvas.TextWidth('Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore))) div 2,12,'Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore));

 path:=ExtractFileDir(Application.ExeName);
 buf:=TBitmap.Create;
 buf.Width:=1000;
 buf.Height:=1100;

 winimg:=TBitmap.Create;
 winimg.Transparent:=True;

 for i:=0 to 11 do
  begin
   img[i]:=TBitmap.Create;
   img[i].LoadFromFile(path+'\Images\Puzzle\'+inttostr(i)+'.bmp');
  end;

 for i:=0 to 3 do
  for j:=0 to 3 do
   map[i,j]:=0;

 while (nn=0) do
  begin
   Randomize;
   s:=random(4);
   l:=random(4);
   if map[s,l]=0 then
    begin
     map[s,l]:=2;
     nn:=1;
    end;
  end;
end;

procedure TGameForm.Timer1Timer(Sender: TObject);
var
 i,j:integer;
begin
 for i:=0 to 3 do
  for j:=0 to 3 do
   begin
    //выбор картинки
    case map[i,j] of
     0: buf.Canvas.Draw(i*250,j*250+100,img[0]);
     2: buf.Canvas.Draw(i*250,j*250+100,img[1]);
     4: buf.Canvas.Draw(i*250,j*250+100,img[2]);
     8: buf.Canvas.Draw(i*250,j*250+100,img[3]);
     16: buf.Canvas.Draw(i*250,j*250+100,img[4]);
     32: buf.Canvas.Draw(i*250,j*250+100,img[5]);
     64: buf.Canvas.Draw(i*250,j*250+100,img[6]);
     128: buf.Canvas.Draw(i*250,j*250+100,img[7]);
     256: buf.Canvas.Draw(i*250,j*250+100,img[8]);
     512: buf.Canvas.Draw(i*250,j*250+100,img[9]);
     1024: buf.Canvas.Draw(i*250,j*250+100,img[10]);
     2048: buf.Canvas.Draw(i*250,j*250+100,img[11]);
    end;
   end;
 //проверка на поражение
 n:=False;
 for i:=0 to 3 do
  for j:=0 to 3 do
   if map[i,j]=0 then
    n:=True;//пустая клетка

 if n=False then
  begin
   Timer1.Enabled:=False;
   if Score>BestScore then
    begin
     Memo1.Lines.Clear;
     Memo1.Lines.Add(inttostr(Score));
     BestScore:=Score;
    end;
   Timer1.Enabled:=False;
   ShowMessage('Ты проиграл!'+'  Врмя: '+IntToStr(timei)+'  Ходы:'+IntToStr(steps));
  end;


 //Проверка на победу
 n:=False;
 for i:=0 to 3 do
  for j:=0 to 3 do
   if map[i,j]=2048 then
    n:=True;
   if n=true then
    begin
     if Score>BestScore then
      begin
       Memo1.Lines.Clear;
       BestScore:=Score;
      end;
     Timer1.Enabled:=False;
     ShowMessage('Ты победил!');
     score:=0;
     for i:=0 to 3 do
      for j:=0 to 3 do
       map[i,j]:=0;
     //buf.Canvas.Draw(0,128,WinImg);
    end;
  If Edit1.Visible=True then
   begin
    Field.Canvas.Brush.Color:=clBtnFace;
    Field.Canvas.Rectangle(0,0,449,45);
   end
  else
   begin
    Field.Canvas.StretchDraw(Rect(0,0,GameForm.ClientWidth,GameForm.ClientHeight),Buf);
    Field.Canvas.Brush.Color:=clBtnFace;
    Field.Canvas.Rectangle(0,0,449,45);
    Field.Canvas.Font.Size:=12;
    Field.Canvas.Font.Style:=[fsBold];
    Field.Canvas.TextOut((ClientWidth-Field.Canvas.TextWidth('Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore))) div 2,12,'Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore));
   end;
  if score>bestscore then
   bestscore:=score;
end;

Procedure SdvigDown;
 var
  i,j,k ,s,l: integer;
begin
 for i := 0 to 3 do
  for j := 3 downto 1 do
   //сдвиг
    if (map[i,j] = 0) then
     begin
      for k := j-1 downto 0 do
       if (map[i,k] > 0) then
        begin
         map[i,j]:=Map[i,k];
         map[i,k]:=0;
         while (nn=0) do
          begin
           Randomize;
           s:=random(4);
           l:=random(4);
           if map[s,l]=0 then
            begin
             map[s,l]:=2;
             nn:=1;
             end;
          end;
         break;
        end;
     end;
end;

Procedure SdvigUp;
 var
  i,j,k,s,l : integer;
begin
          //сдвиг
 For i := 0 to 3 do
  for j := 0 to 2 do
   if (map[i,j] = 0) then
    begin
     for k := j+1 to 3 do
      if (map[i,k] > 0) then
       begin
        map[i,j]:=Map[i,k];
        map[i,k]:=0;
        while (nn=0) do
         begin
          Randomize;
          s:=random(4);
          l:=random(4);
          if map[s,l]=0 then
           begin
            map[s,l]:=2;
            nn:=1;
            end;
         end;
        break;
       end;
    end;
end;

Procedure SdvigLeft;
 var
  i,j,k,s,l : integer;
begin
             //сдвиг
 for j := 0 to 3 do
  for i := 0 to 2 do
   if (map[i,j] = 0) then
    begin
     for k := i+1 to 3 do
      if (map[k,j] > 0) then
        begin
          map[i,j]:=Map[k,j];
          map[k,j]:=0;
         while (nn=0) do
          begin
           Randomize;
           s:=random(4);
           l:=random(4);
           if map[s,l]=0 then
            begin
             map[s,l]:=2;
             nn:=1;
             end;
          end;
         break;
        end;
     end;
end;



Procedure SdvigRight;
 var
  i,j,k,s,l : integer;
begin
 for j := 0 to 3 do
  for i := 3 downto 1 do
   //сдвиг
     if (map[i,j] = 0) then
      begin
       for k := i-1 downto 0 do
        if (map[k,j] > 0) then
         begin
          map[i,j]:=Map[k,j];
          map[k,j]:=0;
         while (nn=0) do
          begin
           Randomize;
           s:=random(4);
           l:=random(4);
           if map[s,l]=0 then
            begin
             map[s,l]:=2;
             nn:=1;
             end;
          end;
          break;
         end;
      end;
end;


procedure TGameForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 i,j,k1,k:integer;
begin
 if key=VK_F1 then
  Help.ShowModal;
 inc(steps);
 if re=1 then
  begin
   k1:=0;
    nn:=0; //не поставили 2
   //вниз
   if Key=VK_DOWN then
    begin
      SdvigDown;
      for i := 3 downto 0 do
       for j := 2 downto 0 do
        begin
         //сложение
         if (map[i,j]>0) and (map[i,j+1]=map[i,j]) then
          begin
           Score:=Score+map[i,j];
           Field.Canvas.Brush.Color:=clBtnFace;
           Field.Canvas.Rectangle(0,0,449,45);
           Field.Canvas.Font.Size:=12;
           Field.Canvas.Font.Style:=[fsBold];
           if score>bestscore then
           bestscore:=score;
           Field.Canvas.TextOut((ClientWidth-Field.Canvas.TextWidth('Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore))) div 2,12,'Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore));
           map[i,j+1]:=Map[i,j]*2;
           map[i,j]:=0;
          end;
        end;
      SdvigDown;
    end;

   //вверх
   if key=VK_UP then
    begin
     SdvigUp;
      for i := 3 downto 0 do
       for j := 1 to 3 do
        begin
         //сложение
         if (map[i,j]>0) and (map[i,j-1]=map[i,j]) then
          begin
           Score:=Score+map[i,j];
           Field.Canvas.Brush.Color:=clBtnFace;
           Field.Canvas.Rectangle(0,0,449,45);
           Field.Canvas.Font.Size:=12;
           Field.Canvas.Font.Style:=[fsBold];
           if score>bestscore then
           bestscore:=score;
           Field.Canvas.TextOut((ClientWidth-Field.Canvas.TextWidth('Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore))) div 2,12,'Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore));
           map[i,j-1]:=Map[i,j]*2;
           map[i,j]:=0;
          end;
        end;
     SdvigUp;
    end;

   //влево
   if Key=VK_Left then
    begin
     SdvigLeft;

      for j := 3 downto 0 do
       for i := 1 to 3 do
        begin
         //сложение
         if (map[i,j]>0) and (map[i-1,j]=map[i,j]) then
          begin
           Score:=Score+map[i,j];
             Field.Canvas.Brush.Color:=clBtnFace;
           Field.Canvas.Rectangle(0,0,449,45);
           Field.Canvas.Font.Size:=12;
           Field.Canvas.Font.Style:=[fsBold];
           if score>bestscore then
           bestscore:=score;
           Field.Canvas.TextOut((ClientWidth-Field.Canvas.TextWidth('Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore))) div 2,12,'Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore));
           map[i-1,j]:=Map[i,j]*2;
           map[i,j]:=0;
          end;
        end;

      SdvigLeft;
    end;

   //вправо
   if Key=VK_Right then
    begin

     SdvigRight;
      for j := 3 downto 0 do
       for i := 2 downto 0 do
        begin
         //сложение
         if (map[i,j]>0) and (map[i+1,j]=map[i,j]) then
          begin
           Score:=Score+map[i,j];
           Field.Canvas.Brush.Color:=clBtnFace;
           Field.Canvas.Brush.Color:=clBtnFace;
           Field.Canvas.Rectangle(0,0,449,45);
           Field.Canvas.Font.Size:=12;
           Field.Canvas.Font.Style:=[fsBold];
           if score>bestscore then
           bestscore:=score;
           Field.Canvas.TextOut((ClientWidth-Field.Canvas.TextWidth('Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore))) div 2,12,'Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore));
           map[i,j+1]:=Map[i,j]*2;
           map[i,j]:=0;
           map[i+1,j]:=Map[i,j]*2;
           map[i,j]:=0;
          end;
        end;
     SdvigRight;
    end;
  end;

 if re=0 then
  begin
   nn:=0; //не поставили 2
 //низ
  if Key=VK_DOWN then
   begin
    for k:=1 to 2 do
     begin
    for i:=0 to 3 do
     for j:=0 to 2 do
      begin
       //сдвиг если пусто
       if (map[i,j]>0) and (map[i,j+1]=0) then
       begin
        map[i,j+1]:=Map[i,j];
        map[i,j]:=0;
       end;
        //сложить, если снизу такой же блок
         if (map[i,j]>0) and (map[i,j+1]=map[i,j]) then
         begin
         Score:=Score+map[i,j];
         map[i,j+1]:=Map[i,j]*2;
         map[i,j]:=0;
         end;
       end;
      end;
    //ставим 2
  while (nn=0) do
   begin
    i:=random(4);
    j:=random(4);
    if map[i,j]=0 then
     begin
      map[i,j]:=2;
      nn:=1; //stavili 2
     end;
   end;
  end;

 //вверх
 if key=VK_UP then
  begin
   for k:=1 to 2 do
    begin
   for i:=0 to 3 do
    begin
     j:=3;
     while (j>0) do
      begin
       //сдвиг, если пусто
       if (map[i,j]>0) and (map[i,j-1]=0) then
        begin
         map[i,j-1]:=Map[i,j];
         map[i,j]:=0;
        end;
        //сложение, если снизу такой же блок
        if (map[i,j]>0) and (map[i,j-1]=map[i,j]) then
         begin
          Score:=Score+map[i,j];
          map[i,j-1]:=Map[i,j]*2;
          map[i,j]:=0;
         end;
       j:=j-1;
     end;
   end;
   end;
 //ставим 2
   while (nn=0) do
    begin
     i:=random(4);
     j:=random(4);
     if map[i,j]=0 then
      begin
       map[i,j]:=2;
       nn:=1;
       end;
    end;
  end;

 //влево
 if Key=VK_Left then
   begin
    for k:=1 to 2 do
     begin
    for j:=0 to 3 do
     begin
      i:=3;
      while (i>0) do
       begin
        //сдвиг если пусто
        if (map[i,j]>0) and (map[i-1,j]=0) then
         begin
          map[i-1,j]:=Map[i,j];
          map[i,j]:=0;
         end;
        //сложить, если равны
        if (map[i,j]>0) and (map[i-1,j]=map[i,j]) then
         begin
          Score:=Score+map[i,j];
          map[i-1,j]:=Map[i,j]*2;
          map[i,j]:=0;
         end;
        i:=i-1;
       end;
       end;
     end;
     //ставим 2
    while (nn=0) do
     begin
      i:=random(4);
      j:=random(4);
      if map[i,j]=0 then
       begin
        map[i,j]:=2;
        nn:=1;
       end;
     end;
   end;

 //вправо
 if Key=VK_Right then
  begin
   for k:=1 to 2 do
    begin
   for j:=0 to 3 do
    for i:=0 to 2 do
     begin
      //сдвиг, если пусто
      if (map[i,j]>0) and (map[i+1,j]=0) then
       begin
        map[i+1,j]:=Map[i,j];
        map[i,j]:=0;
       end;
      //сложить, если равно
      if (map[i,j]>0) and (map[i+1,j]=map[i,j]) then
      begin
       Score:=Score+map[i,j];
       map[i+1,j]:=Map[i,j]*2;
       map[i,j]:=0;
      end;
      end;
     end;
  //ставим 2
     while (nn=0) do
      begin
       i:=random(4);
       j:=random(4);
       if map[i,j]=0 then
        begin
         map[i,j]:=2;
         nn:=1;
        end;
      end;
  end;
  end;
end;


procedure TGameForm.N3Click(Sender: TObject);
begin
 Field.Picture.SaveToFile(login+'_'+IntToStr(Score)+DateToStr(Time)+'.bmp');
end;

procedure TGameForm.N5Click(Sender: TObject);
var
 i,j,s,l:integer;
begin
 timei:=0;
 Steps:=0;
 if re<>1 then
  begin
   score:=0;
   for i:=0 to 3 do
    for j:=0 to 3 do
     map[i,j]:=0;
      Randomize;
   s:=random(4);
   l:=random(4);
   map[s,l]:=2;  
   re:=1;
  end;
end;

procedure TGameForm.N6Click(Sender: TObject);
var
 i,j,s,l:integer;
begin
 timei:=0;
 Steps:=0;
 if re<>0 then
  begin
   score:=0;
   for i:=0 to 3 do
    for j:=0 to 3 do
     map[i,j]:=0;
      Randomize;
   s:=random(4);
   l:=random(4);
   map[s,l]:=2;  
   re:=0;
  end;
end;

procedure TGameForm.N7Click(Sender: TObject);
var
 i,j,s,l:integer;
begin
 Timei:=0;
 Steps:=0;
 n:=False;
 Timer1.Enabled:=True;
 score:=0;
 for i:=0 to 3 do
  for j:=0 to 3 do
   map[i,j]:=0;
  nn:=0;
  while (nn=0) do
  begin
   Randomize;
   s:=random(4);
   l:=random(4);
   if map[s,l]=0 then
    begin
     map[s,l]:=2;
     nn:=1;
    end;
  end;
end;

procedure TGameForm.N4Click(Sender: TObject);
var
 i:integer;
begin
 if textscore<score then
  begin
   AssignFile(best,'Best.txt');
   Rewrite(best);
   Writeln(best,login);
   Write(best,Score);
   CloseFile(best);
  end
 else
  begin
   AssignFile(best,'Best.txt');
   Rewrite(best);
   Writeln(best,login);
   Write(best,Bestscore);
   CloseFile(best);
  end;
 Close;
end;

procedure TGameForm.Timer2Timer(Sender: TObject);
begin
 inc(timei);
end;

procedure TGameForm.N2Click(Sender: TObject);
begin
 Edit1.Visible:=True;
 Edit1.Text:='';
end;

procedure TGameForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if (Edit1.Text<>'') and (key=#13) then
  begin
    Edit1.Visible:=False;
     Field.Canvas.Brush.Color:=clBtnFace;
     Field.Canvas.Rectangle(0,0,449,45);
     Field.Canvas.Font.Size:=12;
     Field.Canvas.Font.Style:=[fsBold];
     if score>bestscore then
      bestscore:=score;
    Field.Canvas.TextOut((ClientWidth-Field.Canvas.TextWidth('Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore))) div 2,12,'Имя: '+login+'   Счёт: '+IntToStr(Score)+'   Лучший рекорд: '+IntToStr(bestscore));
    login:=Edit1.Text;
  end;
end;

end.
